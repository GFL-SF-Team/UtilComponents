/*
 * @history: [INT-288] Dmytro Lambru 18.11.18 - Added user rights check before DML operations and added 'without sharing' keyword
 */
public virtual without sharing class L_JunctionObjectController {
    // Create a savepoint
    public static Savepoint databaseSavePoint = Database.setSavepoint();

    public static GetSettingsForComponentService.RelatedObjectWrapper relatedObjectWrapper;
    public static GetSettingsForComponentService.SearchObjectWrapper searchObjectWrapper;
    public static GetSettingsForComponentService.FieldsForShowWrapper fieldsForShowWrapper;
    public static GetSettingsForComponentService.FieldsForEditWrapper fieldsForEditWrapper;

    @AuraEnabled
    public static List<Map<String,String>> getAvaliableTabs(Id recordId,String relatedObject) {
        String objectName = getObjectApiName(recordId);
        return GetSettingsForComponentService.getRelatedObjectSettingsAviliableToEdit(objectName);
    }
    
    @AuraEnabled
    public static Map<String, String> generateDataForComponent(Id recordId,String relatedObject) {
        String objectName = getObjectApiName(recordId);
        try{
            Map<String,Object> settingForComponent = GetSettingsForComponentService.initSettingsForComponent(objectName,relatedObject);

            relatedObjectWrapper = (GetSettingsForComponentService.RelatedObjectWrapper)settingForComponent.get('relatedObjectWrapper');
            searchObjectWrapper = (GetSettingsForComponentService.SearchObjectWrapper)settingForComponent.get('searchObjectWrapper');
            fieldsForShowWrapper = (GetSettingsForComponentService.FieldsForShowWrapper)settingForComponent.get('fieldsForShowWrapper');
            fieldsForEditWrapper = (GetSettingsForComponentService.FieldsForEditWrapper)settingForComponent.get('fieldsForEditWrapper');
        } catch (Exception e) {
            throw new AuraHandledException('Some problems with config for component');
        }
       
        Map<String, String> recordParams = new Map<String, String>();

        String query = generateQueryPart();

        query += ' WHERE ' + relatedObjectWrapper.fieldRelatedToCurrentObject + ' = \'' + recordId + '\'';

        if(relatedObjectWrapper.filterFields.size() > 0){

            for(String filterParam : relatedObjectWrapper.filterFields.keySet()){
                String filterParamsAsString = DataAccessorHelper.createStringListWithNameFromListName(relatedObjectWrapper.filterFields.get(filterParam));
                query += ' AND ' + filterParam + ' IN ' + filterParamsAsString;

            }

        }
System.debug(query);
        String recordsData = getRecords(query);

        recordParams.put('relatedParams', JSON.serialize(relatedObjectWrapper));
        recordParams.put('searchParams', JSON.serialize(searchObjectWrapper));
        recordParams.put('fieldsForUpdate', JSON.serialize(fieldsForEditWrapper));
        recordParams.put('fieldsForShow', JSON.serialize(fieldsForShowWrapper));
        recordParams.put('recordsData', recordsData);
        return recordParams;
    }

    /*
	 * @history: [INT-288] Dmytro Lambru 18.11.18 - Added user rights check before insert
	 */
    @AuraEnabled
    public static String addRecordToJuncionObject(Id currentRecordId, Id relatedRecordId, String relatedRecords,String fieldsForUpdate,String fieldsForShow) {
        String recordsData;
        List<AggregateResult> checkDuplicateResult;
        try{
            relatedObjectWrapper = (GetSettingsForComponentService.RelatedObjectWrapper) System.JSON.deserialize(relatedRecords, GetSettingsForComponentService.RelatedObjectWrapper.class);
            fieldsForEditWrapper = (GetSettingsForComponentService.FieldsForEditWrapper) System.JSON.deserialize(fieldsForUpdate, GetSettingsForComponentService.FieldsForEditWrapper.class);
            fieldsForShowWrapper = (GetSettingsForComponentService.FieldsForShowWrapper) System.JSON.deserialize(fieldsForShow, GetSettingsForComponentService.FieldsForShowWrapper.class);

            if(relatedObjectWrapper.checkDuplicate == true){
                String checkDuplicateQuery = ' SELECT COUNT(Id) recordsCount ' + 
                                        ' FROM '+ relatedObjectWrapper.junctionObject + 
                                        ' WHERE ' + relatedObjectWrapper.fieldRelatedToCurrentObject + ' = \'' + currentRecordId + '\'' + 
                                        ' AND ' + relatedObjectWrapper.fieldRelatedToRelatedObject + ' = \'' + relatedRecordId + '\'';

                checkDuplicateResult = Database.query(checkDuplicateQuery);
            }
        }catch (QueryException e) {
            throw new AuraHandledException('Duplicate Check Error');
        } catch (AccessErrorException e) {
            throw new AuraHandledException('Access error');
        } catch (Exception e) {
            throw new AuraHandledException('System error');
        }

        if((Integer)checkDuplicateResult[0].get('recordsCount') > 0){
            throw new AuraHandledException('Error! Duplicate Record');
        }

        try {
            sObject sObj = Schema.getGlobalDescribe().get(relatedObjectWrapper.junctionObject).newSObject() ;
            sObj.put(relatedObjectWrapper.fieldRelatedToCurrentObject, currentRecordId);
            sObj.put(relatedObjectWrapper.fieldRelatedToRelatedObject, relatedRecordId);

            if(!relatedObjectWrapper.additionalFields.isEmpty()){

                for(String field : relatedObjectWrapper.additionalFields.keySet()){
                    sObj.put(field, relatedObjectWrapper.additionalFields.get(field));
                }

            }

            if ( !Utills.schemaCheckObjectIsCreateable(relatedObjectWrapper.junctionObject) ) {
                //Rollback to the previous values
                Database.rollback(databaseSavePoint);
                throw new AuraHandledException('You have no rights to do this!');
            }

            insert sObj;

            recordsData = getNewJunctionReecord(currentRecordId, relatedRecordId, sObj.Id);
        } catch (DmlException e) {
            throw new AuraHandledException('Add error');
        } catch (Exception e) {
            throw new AuraHandledException('System error');
        }
        return recordsData;
    }

    private static String getNewJunctionReecord(Id currentRecordId, Id relatedRecordId, Id sObjectId) {

        String recordsData;
        try {
            Map<String, String> recordParams = new Map<String, String>();
            String query = generateQueryPart();
            query += ' WHERE ' + relatedObjectWrapper.fieldRelatedToCurrentObject + ' = \'' + currentRecordId + '\'' +
                    ' AND ' + relatedObjectWrapper.fieldRelatedToRelatedObject + ' = \'' + relatedRecordId + '\'' +
                    ' AND id = \'' + sObjectId + '\'' ;

            recordsData = getRecords(query);
        } catch (QueryException e) {
            throw new AuraHandledException('Some query problem');
        } catch (Exception e) {
            throw new AuraHandledException('System error');
        }

        return recordsData;
    }

    public static String getRecords(String query) {
        List<RecordsDataWrapper> junctionObjectWrapperList = new List<RecordsDataWrapper>();
        try {
            List<sObject> recordQueryResultList = Database.query(query);
            junctionObjectWrapperList = generateJunctionDataWrapper(recordQueryResultList);
        } catch (QueryException e) {
            System.debug(e.getLineNumber());
            System.debug(e.getMessage());
            throw new AuraHandledException('Some query problem');
        } catch (Exception e) {
            throw new AuraHandledException('System error');
        }
        return JSON.serialize(junctionObjectWrapperList);
    }

    /*
	 * @history: [INT-288] Dmytro Lambru 18.11.18 - Added user rights check before delete
	 */
    @AuraEnabled
    public static void deleteRecordFromJunctionObject(Id junctionRecordId) {

        String objectName = getObjectApiName(junctionRecordId);

        if ( !Utills.schemaCheckObjectIsDeletable(objectName) ) {
            //Rollback to the previous values
            Database.rollback(databaseSavePoint);
            throw new AuraHandledException('You have no rights to do this!');
        }

        Database.DeleteResult deleteResult = Database.delete(junctionRecordId);

        if(!deleteResult.isSuccess()){
            throw new AuraHandledException('Delete error');
        }
    }

    private static List<RecordsDataWrapper> generateJunctionDataWrapper(List<sObject> recordQueryResultList) {
        List<RecordsDataWrapper> junctionObjectWrapperList = new List<RecordsDataWrapper>();

        for (sObject recordQueryResult : recordQueryResultList) {
            RecordsDataWrapper junctionObjectWrapper = new RecordsDataWrapper();
            for (String field : fieldsForShowWrapper.fields) {
                Map<String, String> fieldParam = fieldsForShowWrapper.fieldsForShow.get(field);

                Object fieldValue;
                String type = fieldParam.get('type');

                if (fieldParam.get('relatedObject') != null && fieldParam.get('relatedObject') != '') {
                    fieldValue = recordQueryResult.getSObject(fieldParam.get('relatedObject')).get(field);
                    
                    if(fieldValue == null){
                        fieldValue = valueForNull(type);
                    }

                } else {
                    fieldValue = recordQueryResult.get(field);

                    if(fieldValue == null){
                        fieldValue = valueForNull(type);
                    }
                }

                Map<String, Object> fieldParams = new Map<String, Object>();
                fieldParams.put('value', fieldValue);
                fieldParams.put('type', fieldParam.get('type'));
                fieldParams.put('label', fieldParam.get('label'));
                fieldParams.put('show', fieldParam.get('show'));
                fieldParams.put('format', fieldParam.get('format'));
                fieldParams.put('junctionObjectId', (Id) recordQueryResult.get('id'));
                if(fieldParam.get('relatedObject') != '' ){
                    fieldParams.put('relatedObjectId', (Id) recordQueryResult.getSObject(fieldParam.get('relatedObject')).get('id'));
                }
                fieldParams.put('field', field);
                junctionObjectWrapper.recordsData.add(fieldParams);

            }
            junctionObjectWrapperList.add(junctionObjectWrapper);
        }
        return junctionObjectWrapperList;
    }

    private static String generateQueryPart(){
        String query = 'SELECT ';
        Integer relatedJunctionObjectFieldsSize = relatedObjectWrapper.junctionObjectField.size();
        Integer j = 1;

        for (String fieldForSelect : relatedObjectWrapper.junctionObjectField) {
            if (j == relatedJunctionObjectFieldsSize) {
                query += fieldForSelect + ' ';
            } else {
                query += fieldForSelect + ', ';
            }
            j++;
        }

        for (String fieldInRelatedObject : relatedObjectWrapper.fieldsInRelatedObject) {
            query += ',' + relatedObjectWrapper.relatedObject + '.' + fieldInRelatedObject + ' ';
        }

        query += ' FROM ' + relatedObjectWrapper.junctionObject + ' ';

        return query;
    }

    private static Object valueForNull(String type){

        Object fieldValue;

        if(type == 'Decimal'){
            fieldValue = 0;
        }else if (type == 'String') {
            fieldValue = '';
        }else if (type == 'Checkbox') {
            fieldValue = false;
        }

        return fieldValue;
    }

    private static String getObjectApiName(Id recordId) {
        String objectName = '';
        try {
            //Get prefix from record ID
            //This assumes that you have passed at least 3 characters
            String myIdPrefix = String.valueOf(recordId).substring(0, 3);

            //Get schema information
            Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();

            //Loop through all the sObject types returned by Schema
            for (Schema.SObjectType stype : gd.values()) {
                Schema.DescribeSObjectResult r = stype.getDescribe();
                String prefix = r.getKeyPrefix();

                //Check if the prefix matches with requested prefix
                if (prefix != null && prefix.equals(myIdPrefix)) {
                    objectName = r.getName();
                    break;
                }
            }
        } catch (Exception e) {
            throw new AuraHandledException('System error');
        }
        return objectName;

    }
    
    public class RecordsDataWrapper {
        public List<Map<String, Object>> recordsData = new List<Map<String, Object>>();
    }
}