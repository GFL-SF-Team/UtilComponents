/**
 * Created by ashcherbanyuk on 10.05.2018.
 */

public class DataAccessorHelper {

    public static List<SObject> getDataFromOrg(String queryString) {
        SObject[] sobjectList = new SObject[]{};
        try {

            sobjectList = Database.query(queryString);

        } catch(QueryException exc) {
            /* Can TODO alert email for the Administrator */
//            Utills.createConsoleLog('QueryException > DataAccessorHelper.getDataFromOrg() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage() + ' Stack Trace: ' + exc.getStackTraceString());
//            Utills.createErrorLog('DataAccessorHelper', 'getDataFromOrg', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
        }
        
        return sobjectList;
    }
    
    public static String createStringWithFieldsLike(String[] fieldsForSearchList, String valueForSearch) {
        String stringWithFieldsLike = String.escapeSingleQuotes(fieldsForSearchList[0]) + ' LIKE \'%' + valueForSearch + '%\' ';
        Integer listSize = fieldsForSearchList.size();
        
        if (listSize > 1) {
            for (Integer i=1; i<listSize; i++) {
                stringWithFieldsLike += 'OR ' + String.escapeSingleQuotes(fieldsForSearchList[i]) + ' LIKE \'%' + valueForSearch + '%\' ';
            }
        }
        
        return stringWithFieldsLike;
    }
    
    public static String createStringListWithIdFromSObjectList(SObject[] triggerNew) {
        String stringList = ' (';
        
        for (SObject item : triggerNew) {
            stringList += ' \'' + item.Id + '\', ';
        }
        
        stringList = stringList.removeEnd(', ') + ') ';
        
        return stringList;
    }

    //INT-58
    public static String createStringListWithIdFromSObjectMap(Map<Id, SObject> triggerNewMap) {
        String stringList = ' (';
        
        for (String key : triggerNewMap.keySet()) {
            stringList += ' \'' + key + '\', ';
        }
        
        stringList = stringList.removeEnd(', ') + ') ';
        
        return stringList;
    }

    public static String createStringListWithIdFromIdSet(Set<Id> idSet) {

        String stringList;

        if (idSet.isEmpty()) {

            stringList = ' (\'\') ';
        } else {

            stringList = ' (';
            for (Id i : idSet) {
                stringList += ' \'' + i + '\', ';
            }
            stringList = stringList.removeEnd(', ') + ') ';
        }

        return  stringList;
    }



    //alokotosh; You should use only set for this operations
    public static String createStringListWithIdFromIdSet(List<Id> idList) {
        String stringList = ' (';
        for (Id i : idList) {
            stringList += ' \'' + i + '\', ';
        }
        stringList = stringList.removeEnd(', ') + ') ';
        return  stringList;
    }

    public static String createStringListWithNameFromListName(String[] names) {
        String stringList = ' (';
        for (String i : names) {
            stringList += ' \'' + i + '\', ';
        }
        stringList = stringList.removeEnd(', ') + ') ';
        return  stringList;
    }


    public static Map<Id, SObject> getDataMapFromOrg(String queryString) {
        Map<Id, SObject> sobjectMap = new Map<Id, SObject>();
        try {
            sobjectMap =  new Map<Id, SObject>((List<SObject>)Database.query(queryString));

        } catch(QueryException exc) {
            /* Can TODO alert email for the Administrator */
            Utills.createConsoleLog('QueryException > DataAccessorHelper.getDataMapFromOrg() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage() + ' Stack Trace: ' + exc.getStackTraceString());
//            Utills.createErrorLog('DataAccessorHelper', 'getDataMapFromOrg', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
        }

        return sobjectMap;
    }


}