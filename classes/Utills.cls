/**
* Created by ashcherbanyuk on 25.05.2018.
 *
 * @history
 *       -  Anna Makhovskaya 18/09/2018 INT-182
*/

public class Utills {
	public static Boolean isTriggerExecuted = false;


	public static Boolean validateEmail(String email){
		String emailRegex = '([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})';
		Pattern myPattern = Pattern.compile(emailRegex);
		Matcher myMatcher = myPattern.matcher(email);
		System.debug('##_____## ' + '23 ' + myMatcher.matches());
		return myMatcher.matches();

	}

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
			/* Can TODO alert email for the Administrator */
			Utills.createConsoleLog('Exception > Utills.schemaCheckPicklistValue() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
//			Utills.createErrorLog('Utills', 'schemaCheckPicklistValue', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
		}

		return options;

	}


	public static String getFieldLabelFormSObject(String sObjectAPI, String fieldAPI){

		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		Schema.SObjectType objectSchema = schemaMap.get(sObjectAPI);
		Map<String, Schema.SObjectField> fieldMap = objectSchema.getDescribe().fields.getMap();

		return	fieldMap.get(fieldAPI).getDescribe().getLabel();
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
			/* Can TODO alert email for the Administrator */
			Utills.createConsoleLog('Exception > Utills.schemaCheckPicklistValue() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
//			Utills.createErrorLog('Utills', 'schemaCheckPicklistValue', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
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
			/* Can TODO alert email for the Administrator */
			Utills.createConsoleLog('Exception > Utills.schemaCheckPicklistValue() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
//			Utills.createErrorLog('Utills', 'schemaCheckPicklistValue', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
		}

		return result;
	}

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
			/* Can TODO alert email for the Administrator */
			Utills.createConsoleLog('Exception > Utills.schemaGetObjectRecordTypeIdByDeveloperName() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
//			Utills.createErrorLog('Utills', 'schemaGetObjectRecordTypeIdByDeveloperName', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
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
			/* Can TODO alert email for the Administrator */
			Utills.createConsoleLog('Exception > Utills.schemaGetObjectRecordTypeIdByDeveloperName() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
//			Utills.createErrorLog('Utills', 'schemaGetObjectRecordTypeIdByDeveloperName', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
		}

		return recordTypeId;
	}

	/**
	* Method for create an info log.
	* @parameter className - Classes where the event occcurs.
	* @parameter method - Method where the event occcurs.
	* @parameter line - Line where the event occcur.
	* @parameter message - Event message.
	* @parameter type - Event type.
	*/

	
//	public static void createLog(String className, String method, Integer line, String message, String type) {
//		AIS_Solutions_Log__c newLog = new AIS_Solutions_Log__c(
//				Classes__c = className,
//				Method__c = method,
//				Line__c = line,
//				Message__c = message,
//				Type__c = type,
//				Status__c = 'New'
//		);
//
//		try {
//
//			insert newLog;
//
//		} catch (DmlException exc) {
//			/* Can TODO alert email for the Administrator */
//			Utills.createConsoleLog('DmlException > Utills.createLog() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
//		}
//	}

//	/**
//	* Method for create an error log.
//	* @parameter className - Classes where the error occcurs.
//	* @parameter method - Method where the error occcurs.
//	* @parameter line - Line where the error occcur.
//	* @parameter message - Error message.
//	*/
//	public static void createErrorLog(String className, String method, Integer line, String message) {
//		Utills.createLog(className, method, line, message, 'ERROR');
//	}


	public static String trackException(Boolean leaveDebug, Boolean leaveRecordLog, String method, Exception e, Type t){

		ExceptionData eData = new ExceptionData(e, t, method);
        String serializedExc = JSON.serialize(eData);

        if(leaveDebug){
            System.debug(serializedExc);
        }

        if(leaveRecordLog){
//            Utills.createLog(eData.classType, method, eData.inLine, eData.message, 'ERROR');
        }

        return serializedExc;
    }

	/**
	* Method for create an info log.
	* @parameter className - Classes where the info occcurs.
	* @parameter method - Method where the info occcurs.
	* @parameter line - Line where the info occcur.
	* @parameter message - Information message.
	*/
	//Not used now
	// public static void createInfoLog(String className, String method, Integer line, String message) {
	//     Utills.createLog(className, method, line, message, 'INFO');
	// }

	public static void createConsoleLog(String message) {
		System.debug(message);
	}

	/**
	* Method return Developer Name from Record Type - Product
	*/
	public static String getRecordTypeDevNameFromProductByRecordTypeId(String recordTypeId) {
		try {
			Schema.DescribeSObjectResult describeProduct = Schema.SObjectType.Product2;
			Map<Id,Schema.RecordTypeInfo> recordTypeMapById = describeProduct.getRecordTypeInfosById();
			Schema.RecordTypeInfo recordTypeById =  recordTypeMapById.get(recordTypeId);
			String developerName;
			developerName = recordTypeById.getDeveloperName();
			return developerName;

		} catch (Exception e) {
			System.debug('Exception caught: ' + e.getMessage());
		}
		return null;
	}

	/**
	*
	* Method return String CurrencyIsoCode Lable by isoCode value
	*
	*/
	public static String getCurrencyLabelForProductByCurrencyIsoCode(String isoCode) {
		try {
			Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{'Product2'})[0];
			Map<String, Schema.SObjectField> fieldsMap = objectDesc.fields.getMap();
			Schema.DescribeFieldResult fieldResult = fieldsMap.get('CurrencyIsoCode').getDescribe();
			List<Schema.PicklistEntry> picklistEntry = fieldResult.getPicklistValues();

			for (Schema.PicklistEntry pickEntry : picklistEntry) {
				if (pickEntry.getValue() == isoCode) {
					String currencyLable = pickEntry.getLabel();
					return currencyLable;
				}
			}
			return null;
		} catch (Exception e) {
			System.debug('Exception caught: ' + e.getMessage() + 'Line ' + e.getLineNumber());
			return null;
		}

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
	* calculate performance for product
	* used Christian menthod CalculateProductPayoff->choiceofUnderlying (copypaste)
	*/

//	public static Decimal getPerfomanceByProduct(Product2 p){
//
//		// List<ProductUnderlyingAssignee__c> lUnderlyings= TM_UtilsController.getListUnderlyings(p);
//
//		List<ProductUnderlyingAssignee__c> lUnderlyings= p.ProductUnderlyingAssignees__r;
//		for(ProductUnderlyingAssignee__c underlying : lUnderlyings){
//			if(underlying.Performance__c == null){
//				underlying.Performance__c =0;
//			}
//		}
//
//		Decimal performance = 0;
//		if(lUnderlyings.isEmpty()){
//			return performance;
//		}
//		// If it is a single product Basket
//		if(p.Underlying_type__c == 'Single' || p.Underlying_type__c == 'Single (bearish)'){
//			performance = lUnderlyings[0].Performance__c;
//		}
//
//		//If it is a Worst of Basket
//		if(p.Underlying_type__c == 'Worst of'){
//			for(ProductUnderlyingAssignee__c uw : lUnderlyings){
//				if(performance == 0){
//					performance = uw.Performance__c;
//				}
//
//				if(uw.Performance__c < performance){
//					performance = uw.Performance__c;
//				}
//				System.debug('Performance to worst of: ' + performance);
//			}
//		}
//
//		//If it is a Best of basket
//		if(p.Underlying_type__c == 'Best of' || p.Underlying_type__c == 'Best of (bearish)'){
//			for(ProductUnderlyingAssignee__c uw : lUnderlyings){
//				if(performance == 0){
//					performance = uw.Performance__c;
//				}
//
//				if(uw.Performance__c > performance){
//					performance = uw.Performance__c;
//				}
//				System.debug('Performance to best of og: ' + performance);
//			}
//		}
//
//		//If it is a basket
//		if(p.Underlying_type__c == 'Basket'){
//			for(ProductUnderlyingAssignee__c uw : lUnderlyings){
//				performance += uw.Performance__c;
//				System.debug('Sum of performance: ' + performance);
//			}
//
//			//average
//			performance = performance / lUnderlyings.size();
//			System.debug('Average of performance: ' + performance);
//		}
//
//		//If it is a Multichance
//		if(p.Underlying_type__c == 'Multichance'){
//			performance = getPerformanceByMultichanceUnderlying(lUnderlyings, p) *100;
//		}
//
//		//If it is a Multiperformance
//		if(p.Underlying_type__c == 'Multiperformance (Sum of performance)'){
//			Decimal sumaPerf = 0;
//			for(ProductUnderlyingAssignee__c uw : lUnderlyings){
//				sumaPerf += uw.Performance__c - 100;
//			}
//			performance = 100 + sumaPerf;
//		}
//
//		System.debug('Performance to return: ' + performance);
//		return performance;
//	}


//	public static Decimal getPerformanceByMultichanceUnderlying (List<ProductUnderlyingAssignee__c> lULW, Product2 invProd) {
//		System.debug('*** getPerformanceByMultichance');
//		Decimal performance;
//		List<Decimal> lPerformances = new List<Decimal>();
//		for (Integer i = 0; i < lULW.size(); i++) {
//			lPerformances.add(lULW[i].Performance__c);
//		}
//		lPerformances.sort();
//		System.debug('*** lPerformances: ' + lPerformances);
//		Integer index = Integer.valueOf(invProd.Multichance__c) - 1;
//		return performance = lPerformances[index];
//	}

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
	*This call returns: 123,456,789.1234
	*The parameters used are:
	*dec: Number of decimal places to show
	*tSep: Thousand separator
	*dSep: Decimal separator
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

	/*
	 * method returns Set AccountRecordTypesId By RecordType Api Name Trade's Accounts
	 * @history: amakhovskaya 5/3/19 - fix - removed not existing recordTypesApiName from list
	 * */
	public static Set<Id> getSetAccountRecordTypesId(){
		Set<Id> recordTypesIdList = new Set<Id>();
		List<String> recordTypesApiNameArray = new List<String> {
				Constants.ACCOUNT_INDIVIDUAL_CLIENT_RECORDTYPE_API_NAME,
				Constants.ACCOUNT_INSTITUTIONAL_CLIENT_RECORDTYPE_API_NAME
				};
		for(String apiName : recordTypesApiNameArray) {
			Id recordTypeId = Utills.schemaGetObjectRecordTypeIdByDeveloperName('Account', apiName);
			recordTypesIdList.add(recordTypeId);
		}
		return recordTypesIdList;
	}



//	public static Decimal getCouponValueForObservation(Product2 product) {
//		Decimal result = 0.00;
//
//		if(product.Coupon_p_a__c != null) {
//			if (product.Frequency__c == Constants.FREQUENCY_ANNUALLY_PICKLIST_API_NAME) {
//				result = product.Coupon_p_a__c;
//			}
//			else if (product.Frequency__c == Constants.FREQUENCY_SEMIANNUALLY_PICKLIST_API_NAME) {
//				result = product.Coupon_p_a__c / 2;
//			}
//			else if (product.Frequency__c == Constants.FREQUENCY_QUARTERLY_PICKLIST_API_NAME) {
//				result = product.Coupon_p_a__c / 4;
//			}
//			else if (product.Frequency__c == Constants.FREQUENCY_MONTHLY_PICKLIST_API_NAME) {
//				result = product.Coupon_p_a__c / 12;
//			}
//			else if (product.Frequency__c == Constants.FREQUENCY_WEEKLY_PICKLIST_API_NAME) {
//				result = product.Coupon_p_a__c / 52;
//			}
//			//INT-182 Anna Makhovskaya
//			else if (product.Frequency__c == Constants.FREQUENCY_ATMATURITY_PICKLIST_API_NAME) {
//				result = product.Coupon_p_a__c / 12 * product.Maturity__c;
//			}
//		}
//
//		return result;
//	}

	public static Boolean checkNumberField(Decimal field){
		if(field > 0 && field != null) {
			return true; 
		} else {
			return false;
		}
	}
    
    /*
     * @author: Dmytro Lambru
     * @description: Helps you build a string representing the number that is separated in thousands and has a fixed number of decimal places
     * @ticket: COM-47
     * @date: 08.10.18
     * @param: dec - Number of decimal places to show
     * @param: tSep - Thousand separator
     * @param: dSep - Decimal separator
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
     * @author: Dmytro Lambru
     * @date: 25.10.2018
     * @description: to get a non-null value
     * @param: value - decimal to check
     * @ticket: INT-261
     * @test: L_TradeInfoDashboardControllerTest.testGetData()
     */
	public static Decimal getValueOrZeroIfNull(Decimal value) {
        Decimal result = 0;
        
        if (value != null) {
            result = value;
        }
        
        return result;
    }

	/*
	 * @author: Aleksandr Shcherbanyuk
	 * @date: 11/06/18
	 * @description: Throw AuraHandledException
	 * @param: String with message
	 */
	public static AuraHandledException throwCustomAuraHandledException(String message) {
		if (message != null) {
			AuraHandledException e = new AuraHandledException(message);
			e.setMessage(message);
			throw e;
		}
		return null;
	}


	/*
	 * @author: Aleksandr Shcherbanyuk
	 * @date: 11/08/18
	 * @Params: Id Trade__c, Boolean isTradeStep (component uses for Trade path or not)
	 * @description: This method check for path step on trade and return value true/false
	 */
//	public static Boolean isShowComponentOnTradeRecordPageByParam(Id tradeId, Boolean isTradeStep) {
//		Boolean result = true;
//		if (!isTradeStep) {
//			String currentStep = [SELECT AccomplishTradeSteps__c FROM Trade__c WHERE Id = :tradeId LIMIT 1].AccomplishTradeSteps__c;
//			if (currentStep != null) {
//				if (currentStep == Constants.TRADE_ACCOMPLISH_TRADE_STEPS_APINAME.values()[0] || currentStep == Constants.TRADE_ACCOMPLISH_TRADE_STEPS_APINAME.values()[1]) {
//					result = false;
//				}
//			}
//		}
//		return result;
//	}

	/*
	 * @author: Aleksandr Shcherbanyuk
	 * @date: 11/13/18
	 * @Params: String Object api name, String field api name
	 * @description: This method returns Map String String - key=picklist Label, value = picklist Api name
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
			return null;
		}
	}

	/*
	 * @author: Dmytro Lambru
	 * @date: 18.11.18
	 * @Params: String for converting
	 * @description: Makes the first character in an uppercase
	 */
	public static String firstCharacterToUppercase(String stringToConvert) {
		if ( String.isNotEmpty(stringToConvert) && stringToConvert.length() > 1) {
			stringToConvert = stringToConvert.substring(0,1).toUpperCase() + stringToConvert.substring(1).toLowerCase();
		}

		return stringToConvert;
	}

	/*
	 * @author: Dmytro Lambru
	 * @date: 18.11.18
	 * @Params: objectName - the name of the object to check
	 * @description: Verification of rights for the current user
	 */
	public static Boolean schemaCheckObjectIsDeletable(String objectName) {
		/*
		 * Get describe of the Object
		 */
		Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];

		return objectDesc.isDeletable();
	}

	/*
	 * @author: Dmytro Lambru
	 * @date: 18.11.18
	 * @Params: objectName - the name of the object to check
	 * @description: Verification of rights for the current user
	 */
	public static Boolean schemaCheckObjectIsUpdateable(String objectName) {
		/*
		 * Get describe of the Object
		 */
		Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];

		return objectDesc.isUpdateable();
	}

	/*
	 * @author: Dmytro Lambru
	 * @date: 18.11.18
	 * @Params: objectName - the name of the object to check
	 * @description: Verification of rights for the current user
	 */
	public static Boolean schemaCheckObjectIsCreateable(String objectName) {
		/*
		 * Get describe of the Object
		 */
		Schema.DescribeSObjectResult objectDesc = Schema.describeSObjects(new String[]{objectName})[0];

		return objectDesc.isCreateable();
	}


	/*
	 * @Author: Aleksandr Shcherbanyuk
	 * @Created Date: 12/18/2018
	 * @Params: Product Id, String list (can be 'Pending', 'Approved' 'Rejected' - defined in class Constants)
	 * @Description: Method return true/false if approval process exist by statuses
	 * @History: Aleksandr Shcherbanyuk - All Done 12/18/2018
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


	/* @author: Dmytro Lambru
	 * @description: Get set with ID of all 'Public Group' members
	 * @date: 05.12.18
	 * @param: publicGroupApiName - API name of 'Public Group'
	 */
	public static Set<Id> getAllUsersFromPublicGroup(String publicGroupApiName) {
		Set<Id> userIdFromPublicGroupSet = new Set<Id>();
		Set<Id> userOrGroupIdSet = new Set<Id>();

		Group[] groupList = [
				SELECT (SELECT UserOrGroupId FROM GroupMembers)
				FROM Group
				WHERE DeveloperName = :publicGroupApiName
				LIMIT 1
		];

		if ( !groupList.isEmpty() ) {
			Group groupToExtract = groupList[0];

			for (GroupMember groupMember : groupToExtract.GroupMembers) {
				userOrGroupIdSet.add(groupMember.UserOrGroupId);
			}
		}

		if ( !userOrGroupIdSet.isEmpty() ) {
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

			if ( !roleIdSet.isEmpty() ) {
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

		return userIdFromPublicGroupSet;
	}

	/* @Author: Dmytro Lambru / Moved from ProductTriggerService by Aleksandr Shcherbanyuk
	 * @Description: If the input date isn't business day - transform date to business day
	 * @Date: 02/21/19
	 * @Param: Date date For Transform
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
	 * @author: Dmytro Lambru
	 * @ticket: [INT-301]
	 * @test: No - 'System.VisualforceException' with message "Methods defined as TestMethod do not support getContent call" when call Utills.getUserSessionIdFromVFPage() in tests
	 * @date: 15.03.2019
	 * @description: to get user session id from VF page, because 'UserInfo.getSessionId()' doesn't work with @AuraEnabled
	 */
	public static String getUserSessionIdFromVFPage() {
		String SESSION_ID_START = '%SESSION_ID_START%';
		String SESSION_ID_END = '%SESSION_ID_END%';

		String pageContent = Page.UserSessionId.getContent().toString();

		Integer startIndex = pageContent.indexOf(SESSION_ID_START) + SESSION_ID_START.length();
		Integer endIndex = pageContent.indexOf(SESSION_ID_END);

		return pageContent.substring(startIndex, endIndex);
	}

    /*
    * @description: Class created to keep exceptions data and can be serialized
    * @author: alokotosh
    * @created: 1/18/19
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

	/*
	* @author: Dmytro Lambru
	* @ticket: [INT-373]
	* @test: L_PricerTest
	* @date: 02.04.2019
	* @description:
	* @param: objectDescribe - object description
	* @param: fieldApiName - picklist field API Name
	* @param: valueApiName - option value API Name
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

	/*
	 * @author: Dmytro Lambru
	 * @date: 10.04.2019
	 * @description: to stop the execution of the code for a certain number of seconds
	 * @param: startDateString - string with date in format 'YYYY-MM-dd' as the starting date for searching history
	 * @param: numberOfSeconds - the number of seconds to wait
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
    * @param: Set<Id> contactIds - set of contact's Ids
    */

//	public static Map<Id,Id> getMapOfActiveInCommunityUsers(Set<Id> contactIds){
//		Map<Id, Id> contactIdToUserId = new Map<Id, Id>();
//
//		for (User uItem : DataAccessor.contactsAvailableInCommunity(contactIds)) {
//			contactIdToUserId.put(uItem.ContactId, uItem.Id);
//		}
//
//		return contactIdToUserId;
//	}
}