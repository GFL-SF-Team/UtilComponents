public with sharing class TimeLoggerController {

    private static LightningResult response = new LightningResult();

	@AuraEnabled
	public static LightningResult saveLog(String recordJsonString) {

		try {

			Time_Log__c timeLog = (Time_Log__c)JSON.deserialize(recordJsonString, Time_Log__c.class);

			insert timeLog;

            response = response.setResult( JSON.serialize(timeLog) );
        } catch (QueryException exc) {
            response = response.setError( JSON.serialize(new ExceptionData(exc, TimeLoggerController.class, 'saveLog')) );
        } catch (Exception exc) {
            response = response.setError( JSON.serialize(new ExceptionData(exc, TimeLoggerController.class, 'saveLog')) );
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

	/*
     * @description: Class created to keep exceptions data and can be serialized
     */
	public class ExceptionData{
		@AuraEnabled public String exceptionType {get;set;}
		@AuraEnabled public String classType {get;set;}
		@AuraEnabled public String method {get;set;}
		@AuraEnabled public Integer inLine {get;set;}
		@AuraEnabled public String message {get;set;}
		@AuraEnabled public String stackTraceString {get;set;}

		public ExceptionData(Exception exc, Type t, String methodName){
			this.exceptionType = exc.getTypeName();
			this.classType = t.getName();
			this.method = methodName;
			this.inLine = exc.getLineNumber();
			this.message = exc.getMessage();
			this.stackTraceString = exc.getStackTraceString();
		}
	}
}
