/* @name: Util_LookupController
 * @test: Util_LookupTest
 * @author: Dmytro Lambru
 * @date: 22.05.19
 * @description: Controller for 'utilLookup' LWC
 */
public with sharing class Util_LookupController {
	
    private static LightningResult response = new LightningResult();

	/**
	 * @description             search for records by config
	 * @param  stringToSearch   string with value for search
	 * @param  searchConfigJson json string with search config
	 * @return                  response with found records
	 */
	@AuraEnabled
	public static LightningResult lookup(String stringToSearch, String searchConfigJson) {

		try {
			Util_D_SearchConfig searchConfig = Util_D_SearchConfig.parse(searchConfigJson);

			if (!Utils.schemaCheckObjectIsAccessible(searchConfig.objectName)) {
				// return empty list
				return response.setResult('[]');
			}

			Util_D_RecordInfo[] recordInfoList = Util_LookupHelper.searchRecords(stringToSearch, searchConfig);

            response = response.setResult( JSON.serialize(recordInfoList) );
        } catch (QueryException exc) {
            response = response.setError( Utils.trackException(true, false, 'lookup', exc, Util_LookupController.class) );
        } catch (Exception exc) {
            response = response.setError( Utils.trackException(true, false, 'lookup', exc, Util_LookupController.class) );
        }

        return response;
	}	
}
