public with sharing class TimeLoggerController {

    private static TimeLoggerController.LightningResult response = new TimeLoggerController.LightningResult();

	@AuraEnabled
	public static TimeLoggerController.LightningResult saveLog(String recordJsonString) {

		try {

			Time_Log__c timeLog = (Time_Log__c)JSON.deserialize(recordJsonString, Time_Log__c.class);

			insert timeLog;

			System.debug('json >>>' + recordJsonString);
			System.debug('obj >>>' + timeLog);

            // Time_Log__c timeLog = new Time_Log__c(
            //     TimeSpent__c = 'Utility Bar Test'
            // );

            // insert timeLog;

			// Util_D_SearchConfig searchConfig = Util_D_SearchConfig.parse(searchConfigJson);

			// if (!Utils.schemaCheckObjectIsAccessible(searchConfig.objectName)) {
			// 	// return empty list
			// 	return response.setResult('[]');
			// }

			// Util_D_RecordInfo[] recordInfoList = Util_LookupHelper.searchRecords(stringToSearch, searchConfig);

            response = response.setResult( JSON.serialize(timeLog) );
        } catch (QueryException exc) {
            response = response.setError( Utils.trackException(true, false, 'saveLog', exc, TimeLoggerController.class) );
        } catch (Exception exc) {
            response = response.setError( Utils.trackException(true, false, 'saveLog', exc, TimeLoggerController.class) );
        }

        return response;
	}

	public class LightningResult {

		/* Successful(TRUE) or not successful(FALSE) operation */
		@AuraEnabled public Boolean success {get; set;}

		/* For send a message */
		@AuraEnabled public String message {get; set;}

		/* Data in JSON string */
		@AuraEnabled public String data {get; set;}

		/* Code number for the error */
		@AuraEnabled public Integer code {get; set;}

		/* For success response - set JSON data  */
		public LightningResult setResult(String data) {
			this.data = data;
			this.success = TRUE;
			return this;
		}

		/* For error response - set message */
		public LightningResult setError(String message) {
			this.message = message;
			this.success = FALSE;
			return this;
		}

		/* For error response with error code number */
		public LightningResult setError(Integer code) {
			this.code = code;
			this.success = FALSE;
			return this;
		}

		/* For error response with message and error code number */
		public LightningResult setError(String message, Integer code) {
			this.message = message;
			this.code = code;
			this.success = FALSE;
			return this;
		}
	}
}
