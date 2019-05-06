public class DataAccessorHelper {

    /*
	 * @description: Starts a request for execution and returns  list of sObjects or an empty list
	 * @parameter:
	 * 	queryString [String] - query string
	 * */
    public static List<SObject> getDataFromOrg(String queryString) {

        SObject[] sobjectList = new SObject[]{};

        try {
            sobjectList = Database.query(queryString);

        } catch(QueryException exc) {
            Utils.createConsoleLog('QueryException > DataAccessorHelper.getDataFromOrg() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage() + ' Stack Trace: ' + exc.getStackTraceString());
            Utils.createErrorLog('DataAccessorHelper', 'getDataFromOrg', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());

            if ( !Trigger.isExecuting ) {
                throw new AuraHandledException('QueryException > DataAccessorHelper.getDataFromOrg() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage() + ' Stack Trace: ' + exc.getStackTraceString());
            }
        }

        return sobjectList;
    }

    /*
	 * @description: Starts a request for execution and return a single sObject or null
	 * @parameter:
	 * 	queryString [String] - query string
	 * */
    public static SObject getObjectItemFromOrg(String queryString_limit_1) {

        SObject sObjectItem = null;

        try {
            sObjectItem = Database.query(queryString_limit_1);

        } catch(QueryException exc) {
            Utils.createConsoleLog('QueryException > DataAccessorHelper.getObjectItemFromOrg() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage() + ' Stack Trace: ' + exc.getStackTraceString());
            Utils.createErrorLog('DataAccessorHelper', 'getObjectItemFromOrg', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());

            if ( !Trigger.isExecuting ) {
                throw new AuraHandledException('QueryException > DataAccessorHelper.getObjectItemFromOrg() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage() + ' Stack Trace: ' + exc.getStackTraceString());
            }
        }

        return sObjectItem;
    }



    public static String createStringWithFieldsLike(String[] fieldsForSearchList, String valueForSearch) {

        String stringWithFieldsLike = String.escapeSingleQuotes(fieldsForSearchList[0]) + ' LIKE \'%' + valueForSearch + '%\' ';
        Integer listSize = fieldsForSearchList.size();

        if (listSize > 1) {
            for (Integer i = 1; i < listSize; i++) {
                stringWithFieldsLike += 'OR ' + String.escapeSingleQuotes(fieldsForSearchList[i]) + ' LIKE \'%' + valueForSearch + '%\' ';
            }
        }

        return stringWithFieldsLike;
    }

    /*
	 * @description: Return string with objects Id from list of objects for query
	 * @parameter:
	 * 	triggerNew [SObject[]] - array of  objects
	 * */
    public static String createStringListWithIdFromSObjectList(SObject[] triggerNew) {
        String stringList = ' (';

        for (SObject item : triggerNew) {
            stringList += ' \'' + item.Id + '\', ';
        }

        stringList = stringList.removeEnd(', ') + ') ';

        return stringList;
    }

    /*
	 * @description: Return string with objects Id from map for query
	 * @parameter:
	 * 	triggerNewMap [Map<Id, SObject>] - map with  objects' data
	 * */
    public static String createStringListWithIdFromSObjectMap(Map<Id, SObject> triggerNewMap) {

        String stringList = ' (';

        for (String key : triggerNewMap.keySet()) {
            stringList += ' \'' + key + '\', ';
        }

        stringList = stringList.removeEnd(', ') + ') ';

        return stringList;
    }

    /*
	 * @description: Return string with objects Id from set for query
	 * @parameter:
	 * 	idSet [Set<Id>] - set of objects ids
	 * */
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


    //You should use only set for this operations
    public static String createStringListWithIdFromIdSet(List<Id> idList) {

        String stringList = ' (';

        for (Id i : idList) {
            stringList += ' \'' + i + '\', ';
        }

        stringList = stringList.removeEnd(', ') + ') ';

        return  stringList;
    }


    /*
	 * @description: Return string from list strings
	 * @parameter:
	 * 	names [String[]] - array of strings
	 * */
    public static String createStringListWithNameFromListName(String[] names) {

        String stringList = ' (';

        for (String i : names) {
            stringList += ' \'' + i + '\', ';
        }

        stringList = stringList.removeEnd(', ') + ') ';

        return  stringList;
    }


    /*
	 * @description: Starts a request for execution and returns  map of sObjects or an empty map
	 * @parameter:
	 * 	queryString [String] - query string
	 * */
    public static Map<Id, SObject> getDataMapFromOrg(String queryString) {

        Map<Id, SObject> sobjectMap = new Map<Id, SObject>();

        try {
            sobjectMap =  new Map<Id, SObject>((List<SObject>)Database.query(queryString));

        } catch(QueryException exc) {
            Utils.createConsoleLog('QueryException > DataAccessorHelper.getDataMapFromOrg() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage() + ' Stack Trace: ' + exc.getStackTraceString());
            Utils.createErrorLog('DataAccessorHelper', 'getDataMapFromOrg', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());

            if ( !Trigger.isExecuting ) {
                throw new AuraHandledException('QueryException > DataAccessorHelper.getDataMapFromOrg() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage() + ' Stack Trace: ' + exc.getStackTraceString());
            }
        }

        return sobjectMap;
    }
}