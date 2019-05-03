/* Class: L_SearchController
 * Test Class:
 * @author:
 * @ticket: []
 * @date:
 * @description:
 * @history: [INT-301] | 11.03.19 | Dmytro Lambru - added map 'ResultWrapper.fieldNameToValueMap'
 *           [INT-373] | 09.04.19 | Dmytro Lambru - bracket wrap added for 'partStringForSearch'
 */
public with sharing class L_SearchController {
    @AuraEnabled
    public static String searchDB(String recordId, String objectName, List<String> fieldForSearchLists, Integer lim, List<String> fieldForShow, String searchText, String prefix, List<String> filterRecordType, Map<String, List<Object>> filterFields, List<String> sortRecordFields) {

        searchText = '\'%' + String.escapeSingleQuotes(searchText.trim()) + '%\'';

        String partStringForSearch = '';
        Integer i = 0;
        Integer j = 0;
        Integer fieldForShowSize = fieldForShow.size() - 1;
        String queryPart = 'SELECT id,';

        Schema.DescribeSObjectResult accountDescribe = Schema.getGlobalDescribe().get(objectName).getDescribe();
        Map<String, Schema.RecordTypeInfo> recordTypeMapByName = accountDescribe.getRecordTypeInfosByName();

        String whereClouser = '';
        if (filterRecordType != null && !filterRecordType.isEmpty()) {
            List<String> recordTypeIdList = new List<String>();
            for (String recordTypeName : filterRecordType) {
                Schema.RecordTypeInfo recordTypeInfo = recordTypeMapByName.get(recordTypeName);
                String recordTypeId = recordTypeInfo.getRecordTypeId();
                recordTypeIdList.add(recordTypeId);
            }
            whereClouser = ' AND  RecordTypeId IN :recordTypeIdList';
        }

        if (String.isEmpty(recordId)) {
            if (filterFields != null && !filterFields.isEmpty()) {
                for (String field : filterFields.keySet()) {
                    List<String> whereClauserParams = new List<String>();
                    for (Object item : filterFields.get(field)) {
                        whereClauserParams.add((String) item);
                    }
                    whereClouser += ' AND ' + field + ' IN ' + DataAccessorHelper.createStringListWithNameFromListName(whereClauserParams) + ' ' ;
                }

            }
        }

        for (String fieldShow : fieldForShow) {
            if (i == fieldForShowSize) {
                queryPart += fieldShow;
            } else {
                queryPart += fieldShow + ',';
            }
            i++;
        }

        if (String.isEmpty(recordId)) {
            if (!fieldForSearchLists.isEmpty()) {
                partStringForSearch = '(';

                for (String field : fieldForSearchLists) {

                    if (j == 0) {
                        partStringForSearch += field + ' LIKE ' + searchText + ' ' ;
                    } else {
                        partStringForSearch += ' OR ' + field + ' LIKE ' + searchText ;
                    }

                    j++;
                }

                partStringForSearch += ')';
            }
        } else {
            partStringForSearch += ' Id = ' + '\'' + recordId + '\' ';
        }


        String orderByStr = '';

        if (sortRecordFields != null && !sortRecordFields.isEmpty()) {
            orderByStr += ' ORDER BY ' + string.join(sortRecordFields, ',');
        }
        String query = queryPart +
                ' FROM ' + objectName +
                ' WHERE ' + partStringForSearch + whereClouser +
                orderByStr +
                ' LIMIT ' + lim;

        List<sObject> sobjList = Database.query(query);
        List<ResultWrapper> lstRet = new List<ResultWrapper>();

        for (SObject s : sobjList) {
            ResultWrapper obj = new ResultWrapper();

            obj.prefix = prefix;
            for (String fieldParam : fieldForShow) {
                Object fieldValue = s.get(fieldParam);
                String valueAsString = String.valueOf(fieldValue);

                obj.fieldNameToValueMap.put(fieldParam, valueAsString);
                obj.resultParams.add(valueAsString);
            }
            obj.id = s.Id;
            lstRet.add(obj);
        }
        return JSON.serialize(lstRet) ;
    }

    public class ResultWrapper {
        public List<String> resultParams { get; set; }
        public String name { get; set; }
        public String record { get; set; }
        public Id id { get; set; }
        public String prefix { get; set; }
        public Map<String, String> fieldNameToValueMap { get; set; }

        {
            this.resultParams = new String[]{
            };
            this.fieldNameToValueMap = new Map<String, String>();
        }
    }
}