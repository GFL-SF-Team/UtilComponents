public class Utils {

	public static Boolean validateEmail(String email){
		String emailRegex = '([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})';
		Pattern myPattern = Pattern.compile(emailRegex);
		Matcher myMatcher = myPattern.matcher(email);

		return myMatcher.matches();
	}

	/*
	@return Eu date format (DD-MM-YYYY)
	*/
	public static String formatDateToEUFormat(Date dateForFormat){

		if(dateForFormat != null){
			String day = dateForFormat.day() < 10 ? String.valueOf('0'+ dateForFormat.day()) : String.valueOf(dateForFormat.day());
			String month = dateForFormat.month() < 10 ? String.valueOf('0'+ dateForFormat.month()) : String.valueOf(dateForFormat.month());

			return String.valueOf(day + '-' + month + '-' + dateForFormat.year());
		}

		return null;
	}

	/*
	 * @description: If the input date isn't business day - transform date to business day
	 * @parameter:
	 * 	dateForTransform [Date] - Date date For Transform
	 */
	public static Date addDaysIfItWeekend(Date dateForTransform) {
		Datetime dateForCalculate = Datetime.newInstance(dateForTransform.year(), dateForTransform.month(), dateForTransform.day());
		Integer dayNumberOfWeek = Integer.valueOf(dateForCalculate.format('u'));

		if (dayNumberOfWeek == 6) {
			dateForTransform = dateForTransform.addDays(2);
		}
		else if (dayNumberOfWeek == 7) {
			dateForTransform = dateForTransform.addDays(1);
		}

		return dateForTransform;
	}

	/*
	*This call returns: 123,456,789.1234
	*@parameters:
	*	dec: Number of decimal places to show
	*	tSep: Thousand separator
	*	dSep: Decimal separator
	*/
	public static String doNumberFormatting(Decimal val, integer dec, String tSep, String dSep) {

		String s, tmp;
		Integer i = 4 + dec;

		// If the number of decimals is zero (0)... prevents the first 1000s seperator from being set at the 4th.
		if(dec==0){
			i--;
		}

		s = val.setScale(dec).toPlainString().replace(tSep, dSep);
		while(s.length() > i) {
			tmp = s.substring(0, s.length() - i) + tSep + s.substring(s.length() - i);
			s = tmp;
			i += 4;
		}

		// If the number is negative and has a number non-decimal digits divisible by 3, it prevents putting a comma before the 1st digit (ex -300,000.00  comes out -,300,000.00)
		if (s.substring(0,1) == '-') {
			if (s.substring(1,2) == tSep) {
				s = '-' + s.substring(2);
			}
		}

		return s;
	}


	public static Boolean checkNumberField(Decimal field){

		if(field > 0 && field != null) {
			return true;
		} else {
			return false;
		}
	}


	/*
	* @description: Helps you build a string representing the number that is separated in thousands and has a fixed number of decimal places
	* @parameters:
	* 	dec [Integer]- Number of decimal places to show
	* 	tSep [String] - Thousand separator
	* 	dSep [String]- Decimal separator
	*/
	public static String formatNumberIntoString(Decimal val, integer dec, String tSep, String dSep) {

		String s = '', tmp;

		if(val != null) {
			Integer i = 4 + dec;

			// If the number of decimals is zero (0)... prevents the first 1000s seperator from being set at the 4th.
			if (dec == 0) {
				i--;
			}

			s = val.setScale(dec).toPlainString().replace(tSep, dSep);
			while (s.length() > i) {
				tmp = s.substring(0, s.length() - i) + tSep + s.substring(s.length() - i);
				s = tmp;
				i += 4;
			}

			// If the number is negative and has a number non-decimal digits divisible by 3, it prevents putting a comma before the 1st digit (ex -300,000.00  comes out -,300,000.00)
			if (s.substring(0, 1) == '-') {
				if (s.substring(1, 2) == tSep) {
					s = '-' + s.substring(2);
				}
			}
		}
		return s;
	}

	/*
     * @description: to get a non-null value
     * @parameter:
	 * 	value [Decimal]- decimal to check
     */
	public static Decimal getValueOrZeroIfNull(Decimal value) {

		Decimal result = 0;

		if (value != null) {
			result = value;
		}

		return result;
	}

	/*
	 * @description: Makes the first character in an uppercase
	 * @parameter:
	 * 	stringToConvert [String] - String for converting
	 */
	public static String firstCharacterToUppercase(String stringToConvert) {
		if ( String.isNotEmpty(stringToConvert) && stringToConvert.length() > 1) {
			stringToConvert = stringToConvert.substring(0,1).toUpperCase() + stringToConvert.substring(1).toLowerCase();
		}

		return stringToConvert;
	}


	/*
	 * @description: to get user session id from VF page, because 'UserInfo.getSessionId()' doesn't work with @AuraEnabled
	 * @test: No - 'System.VisualforceException' with message "Methods defined as TestMethod do not support getContent call" when call Utills.getUserSessionIdFromVFPage() in tests
	 */
	/*
	 public static String getUserSessionIdFromVFPage() {
		String SESSION_ID_START = '%SESSION_ID_START%';
		String SESSION_ID_END = '%SESSION_ID_END%';

		String pageContent = Page.UserSessionId.getContent().toString();

		Integer startIndex = pageContent.indexOf(SESSION_ID_START) + SESSION_ID_START.length();
		Integer endIndex = pageContent.indexOf(SESSION_ID_END);

		return pageContent.substring(startIndex, endIndex);
	}
	 */



	/*
	 * @description: to stop the execution of the code for a certain number of seconds
	 * @parameters:
	 * 	numberOfSeconds [Integer] - the number of seconds to wait
	 * @note: Warning! Per-Transaction Apex Limits! Maximum CPU time on the Salesforce servers | Synchronous Limit: 10,000 milliseconds | Asynchronous Limit: 60,000 milliseconds
	 */
	public static void codeFreeze(Integer numberOfSeconds) {
		Decimal delayInMilliseconds = numberOfSeconds * 1000;
		Decimal startingTime = System.currentTimeMillis();

		while (System.currentTimeMillis() - startingTime < delayInMilliseconds)  {
			/* Do nothing until desired delay has passed */
		}
	}

	/*
    * @description: get map of active community users associated by contacs set: keys- user's contactId, values - user's id
    * @parameter:
	* 	contactIds [Set<Id> ] - set of contact's Ids
    */
	public static Map<Id,Id> getMapOfActiveInCommunityUsers(Set<Id> contactIds){

		Map<Id, Id> contactIdToUserId = new Map<Id, Id>();

		for (User uItem : DataAccessor.contactsAvailableInCommunity(contactIds)) {
			contactIdToUserId.put(uItem.ContactId, uItem.Id);
		}

		return contactIdToUserId;
	}

	//********************************************* Work with SObject (fields) ***************************************************//

	public static String getFieldLabelFormSObject(String sObjectAPI, String fieldAPI){

		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		Schema.SObjectType objectSchema = schemaMap.get(sObjectAPI);
		Map<String, Schema.SObjectField> fieldMap = objectSchema.getDescribe().fields.getMap();

		return	fieldMap.get(fieldAPI).getDescribe().getLabel();
	}


	/*
	 * @description: Verification of rights for the current user
	 * @parameter:
	 * 	objectName [String] - the name of the object to check
	 */
	public static Boolean schemaCheckObjectIsDeletable(String objectName) {
		/*
		 * Get describe of the Object
		 */
		Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];

		return objectDesc.isDeletable();
	}

	/*
	 * @description: Verification of rights for the current user
	 * @parameter:
	 * 	objectName [String] - the name of the object to check
	 */
	public static Boolean schemaCheckObjectIsUpdateable(String objectName) {
		/*
		 * Get describe of the Object
		 */
		Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];

		return objectDesc.isUpdateable();
	}

	/*
	 * @description: Verification of rights for the current user
	 * @parameter:
	 * 	objectName [String] - the name of the object to check
	 */
	public static Boolean schemaCheckObjectIsCreateable(String objectName) {
		/*
		 * Get describe of the Object
		 */
		Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];

		return objectDesc.isCreateable();
	}



	//********************************************* Work with Picklist ***************************************************//

	public static Model.ListOption[] getPicklistEntitiesAsLightningOptionsWithValues(List<String> values, System.Type sObjectType, String fieldAPIName, Model.ListOption[] options){

		if(sObjectType == null || fieldAPIName == null ||  options == null) return options;

		try {
			Map<String,String> selectedValuesMap = new Map<String,String>();

			for (String sItem : values){
				selectedValuesMap.put(sItem,sItem);
			}
			String sObjectApi = sObjectType.toString();
			/* Get describe of the Object */
			Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{sObjectApi})[0];
			/* Get all Fields of the Object */
			Map<String, Schema.SObjectField> fieldsMap = objectDesc.fields.getMap();
			/* Get describe of the field by name */
			Schema.DescribeFieldResult fieldResult = fieldsMap.get(fieldAPIName).getDescribe();
			/* Get values of the field */
			List<Schema.PicklistEntry> picklistEntry = fieldResult.getPicklistValues();

			for (Schema.PicklistEntry pickEntry : picklistEntry) {
				if (pickEntry.isActive() && selectedValuesMap.containsKey(pickEntry.getValue())) {
					options.add( new Model.ListOption(pickEntry.getLabel(), pickEntry.getValue(), false));
				}
			}

		} catch(Exception exc) {
			Utils.createConsoleLog('Exception > Utills.schemaCheckPicklistValue() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
			Utils.createErrorLog('Utills', 'schemaCheckPicklistValue', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
		}

		return options;

	}


	public static Model.ListOption[] getPicklistEntitiesAsLightningOptions(System.Type sObjectType, String fieldAPIName, Model.ListOption[] options){

		if(sObjectType == null || fieldAPIName == null ||  options == null) return options;

		try {

			String sObjectApi = sObjectType.toString();
			/* Get describe of the Object */
			Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{sObjectApi})[0];
			/* Get all Fields of the Object */
			Map<String, Schema.SObjectField> fieldsMap = objectDesc.fields.getMap();
			/* Get describe of the field by name */
			Schema.DescribeFieldResult fieldResult = fieldsMap.get(fieldAPIName).getDescribe();
			/* Get values of the field */
			List<Schema.PicklistEntry> picklistEntry = fieldResult.getPicklistValues();

			for (Schema.PicklistEntry pickEntry : picklistEntry) {
				if (pickEntry.isActive()) {
					options.add( new Model.ListOption(pickEntry.getLabel(), pickEntry.getValue(), false));
				}
			}

		} catch(Exception exc) {
			Utils.createConsoleLog('Exception > Utills.schemaCheckPicklistValue() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
			Utils.createErrorLog('Utills', 'schemaCheckPicklistValue', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
		}

		return options;
	}

	public static Boolean schemaCheckPicklistValue(String objectName, String fieldName, String picklistValueForCheck) {
		Boolean result = FALSE;

		try {
			/* Get describe of the Object */
			Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];
			/* Get all Fields of the Object */
			Map<String, Schema.SObjectField> fieldsMap = objectDesc.fields.getMap();
			/* Get describe of the field by name */
			Schema.DescribeFieldResult fieldResult = fieldsMap.get(fieldName).getDescribe();
			/* Get values of the field */
			List<Schema.PicklistEntry> picklistEntry = fieldResult.getPicklistValues();

			for (Schema.PicklistEntry pickEntry : picklistEntry) {
				if (pickEntry.getValue() == picklistValueForCheck) {
					result = TRUE;
				}
			}

		} catch(Exception exc) {
			Utils.createConsoleLog('Exception > Utills.schemaCheckPicklistValue() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
			Utils.createErrorLog('Utills', 'schemaCheckPicklistValue', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
		}

		return result;
	}


	/** return value for picklist */
	public static String getPicklistValue(String apiName , String fieldName, String objectName){

		String picklistValue;

		try {

			Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];
			/* Get all Fields of the Object */
			Map<String, Schema.SObjectField> fieldsMap = objectDesc.fields.getMap();
			/* Get describe of the field by name */
			Schema.DescribeFieldResult fieldResult = fieldsMap.get(fieldName).getDescribe();
			/* Get values of the field */
			List<Schema.PicklistEntry> picklistEntry = fieldResult.getPicklistValues();

			for (Schema.PicklistEntry pickEntry : picklistEntry) {
				if (pickEntry.getValue() == apiName) {
					picklistValue = pickEntry.getLabel();
				}
			}

		} catch (Exception e) {
			System.debug('Exception caught: ' + e.getMessage() + 'Line ' + e.getLineNumber());

			return null;
		}

		return picklistValue;
	}

	/*
	 * @description: This method returns Map String String - key=picklist Label, value = picklist Api name
	 * @parameter:
	 * 	objectName [String] - String Object api name,
	 * 	fieldName [String] - String field api name
	 */
	public static Map<String, String> getPicklistAllLabelsValuesAsMap( String objectName, String fieldName) {

		Map<String, String> result = new Map<String, String>();

		try {

			Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];
			/* Get all Fields of the Object */
			Map<String, Schema.SObjectField> fieldsMap = objectDesc.fields.getMap();
			/* Get describe of the field by name */
			Schema.DescribeFieldResult fieldResult = fieldsMap.get(fieldName).getDescribe();
			/* Get values of the field */
			List<Schema.PicklistEntry> picklistEntry = fieldResult.getPicklistValues();

			for (Schema.PicklistEntry pickEntry : picklistEntry) {
				result.put(pickEntry.getLabel(), pickEntry.getValue());
			}

			return result;

		} catch (Exception e) {
			System.debug('Exception caught: ' + e.getMessage() + 'Line ' + e.getLineNumber());
		}

		return null;
	}


	/*
	* @description:
	* @parameters:
	* 	objectDescribe [Schema.DescribeSObjectResult] - object description
	* 	fieldApiName [String] - picklist field API Name
	* 	valueApiName [String] - option value API Name
	*/
	public static String getPicklistOptionLabelByOptionApiName(Schema.DescribeSObjectResult objectDescribe, String fieldApiName, String valueApiName) {
		String picklistValueLabel;

		/* Get all Fields of the Object */
		Map<String, Schema.SObjectField> fieldsMap = objectDescribe.fields.getMap();
		/* Get describe of the field by name */
		Schema.DescribeFieldResult fieldResult = fieldsMap.get(fieldApiName).getDescribe();
		/* Get values of the field */
		List<Schema.PicklistEntry> picklistEntry = fieldResult.getPicklistValues();

		for (Schema.PicklistEntry pickEntry : picklistEntry) {

			if (pickEntry.getValue() == valueApiName) {
				picklistValueLabel = pickEntry.getLabel();
			}
		}

		return picklistValueLabel;
	}



	//********************************************* Work with RecordType ***************************************************//

	public static Boolean schemaCheckRecordTypeDeveloperNameById(String objectName, Id recordTypeId, String recordTypeDeveloperName) {
		Boolean result = FALSE;

		try {
			/* Get describe of the Object */
			Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];
			/* Get map with the all RecordType of the object with ID keys */
			Map<Id,Schema.RecordTypeInfo> recordTypeIdAndInfoMap = objectDesc.getRecordTypeInfosById();
			/* Get a particular RecordType by ID */
			Schema.RecordTypeInfo recordTypeInfo = recordTypeIdAndInfoMap.get(recordTypeId);
			/*Check API Name */
			if (recordTypeInfo.getDeveloperName() == recordTypeDeveloperName) {
				result = TRUE;
			}

		} catch(Exception exc) {
			Utils.createConsoleLog('Exception > Utills.schemaGetObjectRecordTypeIdByDeveloperName() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
			Utils.createErrorLog('Utills', 'schemaGetObjectRecordTypeIdByDeveloperName', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
		}

		return result;
	}

	public static Id schemaGetObjectRecordTypeIdByDeveloperName(String objectName, String recordTypeDeveloperName) {
		Id recordTypeId;

		try {
			/* Get describe of the Object */
			Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];
			/* Get map with the all RecordType of the object by API name */
			Map<String,Schema.RecordTypeInfo> recordTypeMapByDeveloperName = objectDesc.getRecordTypeInfosByDeveloperName();
			/* Get a particular RecordType by API name */
			Schema.RecordTypeInfo recordTypeInfo = recordTypeMapByDeveloperName.get(recordTypeDeveloperName);
			/* Get the ID from a particular RecordType */
			recordTypeId = recordTypeInfo.getRecordTypeId();

		} catch(Exception exc) {
			Utils.createConsoleLog('Exception > Utills.schemaGetObjectRecordTypeIdByDeveloperName() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
			Utils.createErrorLog('Utills', 'schemaGetObjectRecordTypeIdByDeveloperName', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
		}

		return recordTypeId;
	}


	//********************************************* Work with ApprovalProcess ***************************************************//
	/*
	* @description: Method return true/false if approval process exist by statuses
	* @parameters:
	 * productId [Id] - Product Id,
	 * statuses [String[]] - String list (can be 'Pending', 'Approved' 'Rejected' - defined in class Constants)
 	*/
	public static Boolean isApprovalProcessExist(Id productId, String[] statuses) {

		Boolean result = false;

		ProcessInstance[] processInstances = [
				SELECT Id FROM ProcessInstance WHERE TargetObjectId = :productId AND Status IN :statuses
		];

		if (processInstances != null && !processInstances.isEmpty()) {
			result = true;
		}

		return result;
	}


	//********************************************* Work with Public Groups ***************************************************//
	/*
	 * @description: Get set with ID of all 'Public Group' members
	 * @parameter:
	 * 	publicGroupApiName [String] - API name of 'Public Group'
	 */
	public static Set<Id> getAllUsersFromPublicGroup(String publicGroupApiName) {

		Set<Id> userIdFromPublicGroupSet = new Set<Id>();
		Set<Id> userOrGroupIdSet = new Set<Id>();

		try {
			Group[] groupList = [
					SELECT (SELECT UserOrGroupId
					FROM GroupMembers)
					FROM Group
					WHERE DeveloperName = :publicGroupApiName
			LIMIT 1
			];

			if (!groupList.isEmpty()) {
				Group groupToExtract = groupList[0];

				for (GroupMember groupMember : groupToExtract.GroupMembers) {
					userOrGroupIdSet.add(groupMember.UserOrGroupId);
				}
			}

			if (!userOrGroupIdSet.isEmpty()) {
				User[] userFromGroupList = [
						SELECT Id
						FROM User
						WHERE Id IN :userOrGroupIdSet
				LIMIT 50000
				];

				for (User user : userFromGroupList) {
					userIdFromPublicGroupSet.add(user.Id);
				}

				Group[] groupWithRelatedIdList = [
						SELECT RelatedId
						FROM Group
						WHERE Id IN :userOrGroupIdSet
				LIMIT 50000
				];

				Set<Id> roleIdSet = new Set<Id>();
				for (Group groupWithRelatedId : groupWithRelatedIdList) {
					roleIdSet.add(groupWithRelatedId.RelatedId);
				}

				if (!roleIdSet.isEmpty()) {
					User[] userWithRoleList = [
							SELECT Id
							FROM User
							WHERE UserRoleId IN :roleIdSet
					LIMIT 50000
					];

					for (User user : userWithRoleList) {
						userIdFromPublicGroupSet.add(user.Id);
					}
				}
			}
		}catch(Exception exc){
			Utils.createConsoleLog('Exception > Utills.getAllUsersFromPublicGroup() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
			Utils.createErrorLog('Utills', 'getAllUsersFromPublicGroup', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
		}

		return userIdFromPublicGroupSet;
	}


	//********************************************* Work with Logs ***************************************************//
	/**
	* @description: Method for create an info log.
	* @parameters:
	* 	className [String] - Classes where the event occcurs.
	* 	method [String] - Method where the error occcurs.
	* 	line [Integer] - Line where the error occcur.
	* 	message [String] - Error message.
	* 	type [String] - Event type.
	*/
	public static void createLog(String className, String method, Integer line, String message, String type) {

		Solutions_Log__c newLog = new Solutions_Log__c(
				Classes__c = className,
				Method__c = method,
				Line__c = line,
				Message__c = message,
				Type__c = type,
				Status__c = 'New'
		);

		try {

			insert newLog;

		} catch (DmlException exc) {
			Utils.createConsoleLog('DmlException > Utills.createLog() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
		}
	}

	/**
	* @description: Method for create an error log.
	* @parameters:
	* 	className [String] - Classes where the error occcurs.
	* 	method [String] - Method where the error occcurs.
	* 	line [Integer] - Line where the error occcur.
	* 	message [String] - Error message.
	*/
	public static void createErrorLog(String className, String method, Integer line, String message) {
		Utils.createLog(className, method, line, message, 'ERROR');
	}

	/*
	 * @description: Create console record on error
	 * @parameter:
	 * 	message [String] - Error message.
	 * */
	public static void createConsoleLog(String message) {
		System.debug(message);
	}


	//********************************************* Work with Exception ***************************************************//

	/*
	 * @description: Throw AuraHandledException
	 * @parameter:
	 * 	message [String] - String with message
	 */
	public static AuraHandledException throwCustomAuraHandledException(String message) {
		if (message != null) {
			AuraHandledException e = new AuraHandledException(message);
			e.setMessage(message);
			throw e;
		}
		return null;
	}

	public static String trackException(Boolean leaveDebug, Boolean leaveRecordLog, String method, Exception e, Type t){

		ExceptionData eData = new ExceptionData(e, t, method);
		String serializedExc = JSON.serialize(eData);

		if(leaveDebug){
			System.debug(serializedExc);
		}

		if(leaveRecordLog){
			Utils.createLog(eData.classType, method, eData.inLine, eData.message, 'ERROR');
		}

		return serializedExc;
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