/* @name: Util_LookupController
 * @test: Util_LookupControllerTest
 * @author: Dmytro Lambru
 * @date: 22.05.19
 * @description: Controller for 'utilLookup' LWC
 */
public with sharing class Util_LookupController {
    private static LightningResult response = new LightningResult();

	@AuraEnabled(cacheable=true)
	public static LightningResult lookup(String stringToSearch, String searchConfigJson) {

		try {
			SearchConfig searchConfig = (SearchConfig) System.JSON.deserialize(searchConfigJson, SearchConfig.class);

			if (false) {
				return response.setError(401);
			}

            response = response.setResult( JSON.serialize(generateQueryString(stringToSearch, searchConfig)) );
        }
        catch (Exception exc) {
            response = response.setError( exc.getStackTraceString() );
        }

        return response;
	}

	public static String generateQueryString(String stringToSearch, SearchConfig searchConfig) {
		String queryString = 'SELECT ';
		// add fields
		queryString += 'Id,' + String.join(searchConfig.fieldForQueryList, ',') + ' ';
		// add target object
		queryString += 'FROM ' + searchConfig.objectName + ' ';
		// add WHERE clause
		queryString += generateWhereClause(stringToSearch, searchConfig);
		// add ORDER BY
		//TODO: order

		return queryString;
	}

	public static String generateWhereClause(String stringToSearch, SearchConfig searchConfig) {
		String whereClauseString = 'WHERE (';

		for (Integer i = 0, length = searchConfig.fieldForSearchList.size(); i < length; i++) {
			String fieldName = searchConfig.fieldForSearchList[i];

			if (i != 0) {
				whereClauseString += 'OR ';
			}

			whereClauseString += fieldName + ' LIKE \'%' + stringToSearch + '%\' ';
		}

    	whereClauseString += ')';

		return whereClauseString;
	}

	public class SearchConfig {

		public String objectName;
		public Boolean isFieldLabelHidden;
		public String[] fieldForSearchList;
		public String[] fieldForQueryList;
		public List<Map<String, String>> fieldToShowList;
		// public List<FieldToShowList> fieldToShowList;
		
		// public class FieldToShowList {
		// 	public String fieldName;
		// 	public String fieldLabel;
		// }
	}
}
