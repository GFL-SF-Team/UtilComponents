/**
 * Created by ashcherbanyuk on 10.05.2018.
 */

public with sharing class DataAccessor {

//
//	public static List<Product2> getProductsForObservationBatch(List<Product2> scope, Date submittedDate){
//
//		return [
//				SELECT Id, Maturity__c, Name, NextObservation__c, CurrencyIsoCode,Alternative_Currency__c, Redemption_currency__c , Strike__c, Frequency__c, Capital_Protection_Level__c, Strike_level__c, Cap__c, Coupon_type__c, Payoff__c, Coupon_trigger__c,
//				Coupon_in_fine__c, Coupon_p_a__c,Issue_Date__c, Initial_Fixing_Date__c, Call_type__c, Autocall_trigger__c, Barrier_type__c, Barrier_level__c,
//				Redemption_Date__c, Final_Fixing_Date__c, isActive, Underlying_type__c, Multichance__c,
//				Call_rate__c,Issuer__c,First_call_in__c, RecordTypeId, Upside_Participation_Level__c,
//				Maturity_weeks__c,Product_subtype__c,Converted__c,Bonus_Level__c, Barrier_activated__c, RecordType.DeveloperName, Downside_leverage__c,
//				Floating_Underlying__r.Name, Coupon_Type_cln2__c,
//				(select Id,
//						Underlying__r.Name,
//						Underlying__r.Close__c,
//						Underlying__r.CurrencyIsoCode,
//						Underlying__r.Hidden_Ticker_Bloomberg__c,
//						Underlying__r.Low__c,
//                 		Underlying__r.High__c,
//						Underlying__r.Name__c,
//						Underlying__r.Spot__c,
//						Underlying__r.Spot_10_AM_EDT__c,
//						Underlying__r.Type__c,
//						Strike__c,
//						Name,
//						Weighting__c,
//						Performance__c
//						FROM ProductUnderlyingAssignees__r),
//				(select Id,
//						Add_to_Invoice__c,
//						AIS_Margin__c,
//						AIS_Margin_Cash__c,
//						Broker_Margin__c,
//						Broker_Name__c,
//						Contact__c,
//						Client_Margin__c,
//						Client_Margin_Cash__c,
//						Account_Name__c,
//						CurrencyIsoCode,
//						Introducer_Address__c,
//						IntroducerContact__c,
//						Introducer_Margin__c,
//						Introducer_Margin_Cash__c,
//						Introducer_Name__c,
//						ISIN_Code__c,
//						Issuer__c,
//						IssuerProduct__c,
//						Line_to_Confirmation__c,
//						Line_To_Confirmation_with_Introducer__c,
//						Line_to_invoice__c,
//						Market_Price__c,
//						Price_client__c,
//						Price_Final_Client__c,
//						Price_Issuer__c,
//						Product_Description__c,
//						Sales__c,
//						Sales_Account__c,
//						Settlement_Date__c,
//						Size__c,
//						Total__c,
//						Name,
//						Sales_Rep__c,
//						Trade_Date__c,
//						Trade_type__c,
//						Trade_not_handled_by_AIS__c,
//						Sales_Rep__r.Name
//						FROM  Trades__r),
//				(select Id, Date__c,
//						Type__c,
//						Product__c,
//						Payment_date__c,
//						Coupon_trigger__c,
//						Coupon_Value__c,
//						Autocall_trigger__c,
//						Final_payment_date__c,
//						Obsv_number__c,
//						CurrencyIsoCode,
//						Paid__c,
//						Next_Observation__c,
//						Call_rate__c FROM Observations__r)
//				FROM Product2 WHERE IsActive = true AND Id IN: scope  ORDER BY Barrier_type__c, RecordTypeId
//		];
//	}
//
//
//	public static Trade__c[] getTradeContactAssigneesFromProducts(Product2[] scopedProducts){
//
//		return [SELECT Id,
//				Add_to_Invoice__c,
//				AIS_Margin__c,
//				AIS_Margin_Cash__c,
//				Broker_Margin__c,
//				Broker_Name__c,
//				Contact__c,
//				Client_Margin__c,
//				Client_Margin_Cash__c,
//				Account_Name__c,
//				CurrencyIsoCode,
//				Introducer_Address__c,
//				IntroducerContact__c,
//				Introducer_Margin__c,
//				Introducer_Margin_Cash__c,
//				Introducer_Name__c,
//				ISIN_Code__c,
//				Issuer__c,
//				IssuerProduct__c,
//				Line_to_Confirmation__c,
//				Line_To_Confirmation_with_Introducer__c,
//				Line_to_invoice__c,
//				Market_Price__c,
//				Price_client__c,
//				Price_Final_Client__c,
//				Price_Issuer__c,
//				Product_Description__c,
//				Sales__c,
//				Sales_Account__c,
//				Settlement_Date__c,
//				Size__c,
//				Total__c,
//				Name,
//				Trade_Date__c,
//				Trade_not_handled_by_AIS__c,
//				Trade_type__c,
//				(select Contact__c,Contact__r.Email from TradeContactAssignees__r where Related_To__c = 'Observation')
//				FROM  Trade__c WHERE ISIN_Code__c IN : scopedProducts];
//	}
//
//	/*
//	 * @history: [INT-191] 02.10.18 Dmytro Lambru: Added field "First_Payment_Date__c" to query
//	 */
//	public static Product2[] getProductsAllFieldsFromProductsList(List<Product2> productsScope){
//		if(!productsScope.isEmpty()){
//			return  [SELECT First_Payment_Date__c, Maturity__c, NextObservation__c, Name, CurrencyIsoCode, Alternative_Currency__c, Redemption_currency__c , Strike__c, Frequency__c, Capital_Protection_Level__c, Strike_level__c, Cap__c, Coupon_type__c, Payoff__c, Coupon_trigger__c,
//					Coupon_in_fine__c, Coupon_p_a__c,Issue_Date__c, Initial_Fixing_Date__c, Call_type__c, Autocall_trigger__c, Barrier_type__c, Barrier_level__c,
//					Redemption_Date__c, Final_Fixing_Date__c, isActive, Underlying_type__c, Multichance__c,
//					Call_rate__c,Issuer__c,First_call_in__c, RecordTypeId, Upside_Participation_Level__c,
//					Maturity_weeks__c,Product_subtype__c,Converted__c,Bonus_Level__c, Barrier_activated__c, RecordType.DeveloperName, Interest_Type__c  FROM Product2 WHERE Id IN : productsScope];
//		}
//
//		return new List<Product2>();
//	}
//
//	public static List<Observation__c> getObservationsForRemoveByProductId(Product2[] productList) {
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromSObjectList(productList);
//
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id ' +
//						'FROM Observation__c ' +
//						'WHERE Product__c IN' + stringWithIdList +
//						'LIMIT 50000'
//		);
//	}
//
//	public static List<Observation__c> getObservationsForRemove() {
//
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id ' +
//						'FROM Observation__c ' +
//						'WHERE Product__c = NULL ' +
//						'LIMIT 50000'
//		);
//	}
//
//	public static List<Observation__c> getObservationsWithTypeCallabilityByProductId(Product2[] triggerNew) {
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromSObjectList(triggerNew);
//
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Date__c, Dif_ObservationToday__c, Product__c ' +
//						'FROM Observation__c ' +
//						'WHERE Type__c = \'Callability\' ' +
//						'AND Product__c IN' + stringWithIdList +
//						'ORDER BY Product__c, Date__c ' +
//						'LIMIT 50000'
//		);
//	}
//
//	public static List<SObject> getRecordsWithValuesLike(String objectName, String fieldNameForDisplay, String[] fieldsForSearchList, String valueForSearch) {
//		String stringWithFieldsLike = DataAccessorHelper.createStringWithFieldsLike(fieldsForSearchList, valueForSearch);
//
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, ' + String.escapeSingleQuotes(fieldNameForDisplay) + ' ' +
//						'FROM ' + String.escapeSingleQuotes(objectName) + ' ' +
//						'WHERE ' + stringWithFieldsLike +
//						'LIMIT 1000'
//		);
//	}
//
//	public static List<Observation__c> getObservationListByProductId(Id productId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, ' +
//						'Product__c, ' +
//						'Obsv_number__c, ' +
//						'Type__c, ' +
//						'Date__c, ' +
//						'Payment_date__c, ' +
//						'Final_payment_date__c, ' +
//						'Autocall_trigger__c, ' +
//						'Coupon_trigger__c, ' +
//						'Call_rate__c, ' +
//						'Paid__c, ' +
//						'Payoff__c ' +
//						'FROM Observation__c ' +
//						'WHERE Product__c = \''+ String.escapeSingleQuotes(productId) +'\' ' +
//						'LIMIT 50000'
//		);
//	}
//
//	//INT-58
//	public static List<Product2> getTradesByProductWithChengedCurrency(Map<Id, Product2> changedCurrencyInProducts) {
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromSObjectMap(changedCurrencyInProducts);
//
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, (SELECT Id FROM Trades__r) ' +
//						'FROM Product2 ' +
//						'WHERE Id IN ' + stringWithIdList + ' ' +
//						'LIMIT 50000'
//		);
//	}
//
//	//COM-3
//	public static List<ProductUnderlyingAssignee__c> getUnderlyingsAndProductByProductId(Id productId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Performance__c, Strike__c, Underlying__c, ' +
//						'Product__r.Name, Product__r.ProductCode, Product__r.Barrier_level__c, ' +
//						'Product__r.RecordTypeId, Product__r.Product_subtype__c, Product__r.Payoff__c, ' +
//						'Product__r.Issuer__r.Name, Product__r.Currency__c, Product__r.CurrencyIsoCode, ' +
//						'Product__r.Delivery_type__c, Product__r.Px_Last__c, Product__r.RecordType.Name, ' +
//						'Product__r.Underlying_type__c, Product__r.Multichance__c, Product__r.Maturity__c, ' +
//						'Product__r.Issue_Date__c, Product__r.Initial_Fixing_Date__c, Product__r.Final_Fixing_Date__c, ' +
//						'Product__r.Redemption_Date__c, Product__r.Issue_price__c, Product__r.Strike_level__c, ' +
//						'Product__r.Barrier_type__c, Product__r.Coupon_p_a__c, ' +
//						'Product__r.Frequency__c, Product__r.Coupon_type__c, Product__r.Coupon_trigger__c, ' +
//						'Product__r.Lookback__c, Product__r.Lookback_Period__c, Product__r.Safety_effect__c, ' +
//						'Product__r.Safety_barrier__c, Product__r.Call_type__c, Product__r.First_call_in__c, ' +
//						'Product__r.Autocall_trigger__c, Product__r.Call_rate__c, Product__r.IsActive, ' +
//						'Underlying__r.Name, Underlying__r.Name__c, Underlying__r.Spot__c ' +
//						'FROM ProductUnderlyingAssignee__c ' +
//						'WHERE Product__c = \''+ String.escapeSingleQuotes(productId) +'\' ' +
//						'LIMIT 50000'
//		);
//	}
//
//	/*
//	 * COM-40 dlambru
//	 * @history: COM-61 amakhovskaya  added  to query field Final_Fixing_Level__c, Weighting__c
//	 */
//	public static List<ProductUnderlyingAssignee__c> getJunctionsWithUnderlyingByProductId(Id productId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Performance__c, Strike__c, Underlying__c, Weighting__c, ' +
//						'Underlying__r.Name, Underlying__r.Name__c, Underlying__r.Spot__c, Final_Fixing_Level__c ' +
//						'FROM ProductUnderlyingAssignee__c ' +
//						'WHERE Product__c = \''+ String.escapeSingleQuotes(productId) +'\' ' +
//						'LIMIT 50000'
//		);
//	}
//
//	/*
//	 * COM-40 dlambru
//	 */
//	public static List<Product2> getProductByProductId(Id productId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Name, ProductCode, RecordTypeId, Product_subtype__c, ' +
//						'Payoff__c, Currency__c, CurrencyIsoCode, Barrier_level__c, Capital_Protection_Level__c, Delivery_type__c, ' +
//						'Px_Last__c, RecordType.Name, RecordType.DeveloperName, Underlying_type__c, Multichance__c, Maturity__c, Issuer__r.Name, ' +
//						'Initial_Fixing_Date__c, Final_Fixing_Date__c, Redemption_Date__c, Issue_Date__c, Issue_price__c, ' +
//						'Strike_level__c, Barrier_type__c, Coupon_p_a__c, Frequency__c, Coupon_type__c, ' +
//						'Coupon_trigger__c, Lookback__c, Lookback_Period__c, Safety_effect__c, Safety_barrier__c, ' +
//						'Call_type__c, First_call_in__c, Autocall_trigger__c, Call_rate__c, IsActive ' +
//						'FROM Product2 WHERE Id = \'' + String.escapeSingleQuotes(productId) + '\' ' +
//						'LIMIT 1'
//		);
//	}
//
//	/*
//	 * @history: [INT-191] 02.10.18 Dmytro Lambru: Added "Product__r.Coupon_Type_cln2__c", "Product__r.Floating_Underlying__r.Name", "Product__r.Floating_Underlying__r.Name__c" field to query
//	 *           [INT-245] 17.10.18 Dmytro Lambru: Added "Final_Fixing_Level__c", "Product__r.IsActive" field to query
//	 *           [INT-257] 10/18/18 Aleksandr Shcherbanyuk: Added Product__r.Underlying_type__c and Weighting__c fields to query
//	 *           [INT-278] 14.11.18 Dmytro Lambru: Added Underlying__r.Spot_10_am_EDT__c field to query
//	 */
//	public static List<ProductUnderlyingAssignee__c> getUnderlyingsAndProductByProductIdForInternal(Id productId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Final_Fixing_Level__c, Performance__c, Strike__c, Underlying__c, Weighting__c, ' +
//						'Product__r.IsActive, Product__r.Upside_Participation_Level__c, Product__r.Interest_Type__c, Product__r.Strike_level__c, ' +
//						'Product__r.Floating_Underlying__r.Name__c, Product__r.Floating_Underlying__r.Name, ' +
//						'Product__r.Coupon_Type_cln2__c, Product__r.Barrier_type__c, Product__r.Barrier_level__c, Product__r.RecordTypeId, ' +
//						'Product__r.Coupon_p_a__c, Product__r.Frequency__c, Product__r.Coupon_type__c, Product__r.Underlying_type__c, ' +
//						'Product__r.Coupon_trigger__c, Product__r.Call_type__c, Product__r.Autocall_trigger__c, ' +
//						'Product__r.Call_rate__c, Product__r.Maturity__c, Product__r.First_call_in__c, Product__r.Name, ' +
//						'Product__r.Final_Fixing_Date__c, Product__r.Redemption_Date__c, Product__r.Product_subtype__c, ' +
//						'Product__r.RecordType.DeveloperName, Product__r.Maturity_weeks__c, Product__r.Capital_Protection_Level__c, ' +
//						'Product__r.Recovery_type__c, Product__r.Settlement_Type__c, Product__r.Strike__c, Product__r.Coupon_in_fine__c, ' +
//						'Underlying__r.Name, Underlying__r.Name__c, Underlying__r.Spot__c, Underlying__r.Spot_10_am_EDT__c ' +
//						'FROM ProductUnderlyingAssignee__c ' +
//						'WHERE Product__c = \''+ String.escapeSingleQuotes(productId) +'\' ' +
//						'LIMIT 50000'
//		);
//	}
//
//	/*
//	 * @history: [INT-191] 02.10.18 Dmytro Lambru: Added "Coupon_Type_cln2__c", "Floating_Underlying__r.Name", "Floating_Underlying__r.Name__c" field to query
//	 *           [INT-245] 17.10.18 Dmytro Lambru: Added "IsActive" field to query
//	 *           [INT-257] 10/18/18 Aleksandr Shcherbanyuk: Added Underlying_type__c field to query
//	 */
//	public static List<Product2> getProductByProductIdForInternal(Id productId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Name, IsActive, Floating_Underlying__r.Name__c, Floating_Underlying__r.Name, Coupon_Type_cln2__c, ' +
//						'Barrier_type__c, Barrier_level__c, Final_Fixing_Date__c, Redemption_Date__c, Upside_Participation_Level__c, ' +
//						'RecordTypeId, Product_subtype__c, Coupon_p_a__c, Frequency__c, Coupon_type__c, Interest_Type__c, ' +
//						'Coupon_trigger__c, Call_type__c, Autocall_trigger__c, Call_rate__c, Maturity__c, Strike_level__c, ' +
//						'First_call_in__c, Maturity_weeks__c, RecordType.DeveloperName, Capital_Protection_Level__c, ' +
//						'Settlement_Type__c, Recovery_type__c, Strike__c, Coupon_in_fine__c, Underlying_type__c, Multichance__c, ' +
//						'(SELECT Id, Performance__c, Weighting__c FROM ProductUnderlyingAssignees__r) ' +
//						'FROM Product2 WHERE Id = \''+ String.escapeSingleQuotes(productId) +'\' ' +
//						'LIMIT 1'
//		);
//	}
//
//	public static List<ProductUnderlyingAssignee__c> getUnderlyingByProductUnderlyingAssigneeId(Id productUnderlyingAssigneeId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Performance__c, Strike__c, Underlying__c, Final_Fixing_Level__c, Weighting__c, ' +
//						'Product__r.Barrier_level__c, Product__r.RecordType.DeveloperName, Product__r.Capital_Protection_Level__c, ' +
//						'Underlying__r.Name, Underlying__r.Name__c, Underlying__r.Spot__c, Underlying__r.Spot_10_am_EDT__c ' +
//						'FROM ProductUnderlyingAssignee__c ' +
//						'WHERE Id = \''+ String.escapeSingleQuotes(productUnderlyingAssigneeId) +'\' LIMIT 1'
//		);
//	}
//
//	public static List<Observation__c> getObservationsByTypeAndProductId(Id productId, String type) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Date__c, Obsv_number__c, Final_payment_date__c, Payment_date__c, Type__c, ' +
//						'Autocall_trigger__c, Coupon_trigger__c,Payoff__c,Call_rate__c,	Paid__c, Coupon_In_Fine__c, ' +
//						'Coupon_Value__c ' +
//						'FROM Observation__c ' +
//						'WHERE Product__c = \''+ String.escapeSingleQuotes(productId) +'\' ' +
//						'AND Type__c = \'' + String.escapeSingleQuotes(type) + '\' ' +
//						'ORDER BY  Obsv_number__c'
//		);
//	}
//
//	public static List<Product2> getProductsWithObservationsWithTypeCallability(Map<Id, SObject> sobjectMap) {
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromSObjectMap(sobjectMap);
//
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT ID, Closest_Observation_Date__c, ' +
//						'(SELECT Id, Date__c, Dif_ObservationToday__c FROM Observations__r WHERE Type__c = \'' + Constants.TYPE_CALLABILITY_PICKLIST_API_NAME + '\') ' +
//						'FROM Product2 ' +
//						'WHERE Id IN ' + stringWithIdList +
//						'LIMIT 50000'
//		);
//	}
//
//	public static List<Price_Request__c> getPriceRequestAndUnderlyingsIdByPriceRequestId(Id priceRequestId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Barrier_level__c, Barrier_type__c, Coupon_in_fine__c, Coupon_p_a__c, ' +
//						'Coupon_trigger__c, Coupon_type__c, CurrencyIsoCode, Delivery_type__c, Final_Fixing_Date__c, ' +
//						'Frequency__c, Initial_Fixing_Date__c, Issue_Date__c, Maturity__c, ' +
//						'Multichance__c, Name, Price_request_type__c, Product_subtype__c, RecordType.DeveloperName, ' +
//						'Redemption_Date__c, Reference_Rate__c, Reoffer_number__c, Size__c, Solve_for__c, Strike_level__c, ' +
//						'Strike__c, Underlying_type__c, Price_request_status__c, Autocall_trigger__c, First_call_in__c, ' +
//						'(SELECT Underlying__c FROM PriceRequestUnderlyingAssignees__r) ' +
//						'FROM Price_Request__c ' +
//						'WHERE Id = \''+ String.escapeSingleQuotes(priceRequestId) +'\' ' +
//						'LIMIT 1'
//		);
//	}
//
//	public static List<PriceRequestIssuerAssignee__c> getIssuerByPriceRequestId(Id priceRequestId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Account__c ' +
//						'FROM  PriceRequestIssuerAssignee__c ' +
//						'WHERE Price_Request__c  = \''+ String.escapeSingleQuotes(priceRequestId) +'\''
//		);
//	}
//
//	public static List<RecordType> getRecordTypeListIdByPriceRequestRecordTypeDeveloperName(String developerName) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id ' +
//						'FROM RecordType ' +
//						'WHERE DeveloperName = \''+ String.escapeSingleQuotes(developerName) +'\' ' +
//						'AND SObjectType = \'Product2\' ' +
//						'LIMIT 1'
//		);
//	}
//
//	/*@history
//	 *
//	 *@Andriy Kolotiy 9/11/18 add Introducer Email To query
//	 *@Andriy Kolotiy 9/11/18 add Strike_level__c To query
//	 *@Andriy Kolotiy 10/08/18 add Settlement_Date__c  To query
//	 *@Andriy Kolotiy 10/10/18 add product fields To query - Stop_Loss__c, Leverage__c, Spread_Coupon_p_a__c, Reference_Rate__c,Initial_Leverage__c   INT-138
//	 *@Andriy Kolotiy 10/12/18 add product fields To query - Account_Counterparty__r.Confirmation_emails__c   marge INT-227(Christian)
//	 *  @alokotosh changed Confirmation_emails__c to ConfirmationEmailsList__c
//	 */
//	public static List<Trade__c> getTradeWithProductFieldByTradeId(Id tradeId) {
//
//		String queryString ='SELECT Account_Name__c, Size__c, Price_Final_Client__c, Client_Margin__c, Execution_price__c, Price_Issuer__c,' +
//				'Introducer_Margin__c, AIS_Margin__c, Trade_Date__c, Settlement_Date__c, ISIN_Code__r.Product_subtype__c, ' +
//				'ISIN_Code__r.RecordType.DeveloperName, ISIN_Code__r.CurrencyIsoCode, ISIN_Code__r.RecordType.Name, ' +
//				'ISIN_Code__r.Issuer__r.Name, ISIN_Code__r.Issuer__c, ISIN_Code__r.Issuer__r.ConfirmationEmailsList__c, ' +
//				'ISIN_Code__r.Strike__c, ISIN_Code__r.Strike_level__c, ISIN_Code__r.Capital_Protection_Level__c, ' +
//				'ISIN_Code__r.Upside_Participation_Level__c, ISIN_Code__r.Cap__c, ISIN_Code__r.Credit_Reference__c, ' +
//				'ISIN_Code__r.Initial_Fixing_Date__c, ISIN_Code__r.Issue_Date__c, ISIN_Code__r.Final_Fixing_Date__c, ' +
//				'ISIN_Code__r.Redemption_Date__c, ISIN_Code__r.Coupon_type__c, ' +
//				'ISIN_Code__r.Recovery_type__c, ISIN_Code__r.Settlement_Type__c, ISIN_Code__r.Floating_Underlying__r.Name__c, ' +
//				'ISIN_Code__r.Coupon_p_a__c, ISIN_Code__r.Coupon_trigger__c,ISIN_Code__r.Call_type__c, ' +
//				'ISIN_Code__r.Frequency__c, ISIN_Code__r.First_call_in__c, ISIN_Code__r.Autocall_trigger__c, '+
//				'ISIN_Code__r.Barrier_type__c, ISIN_Code__r.Barrier_level__c, ISIN_Code__r.Bonus_Level__c, '+
//				'ISIN_Code__r.Name, Account_Name__r.Name, Account_Name__r.Id, Account_Name__r.ConfirmationEmailsList__c, ISIN_Code__r.Coupon_Type_cln2__c, ' +
//				'ISIN_Code__r.Stop_Loss__c, ISIN_Code__r.Leverage__c, ISIN_Code__r.Spread_Coupon_p_a__c, ISIN_Code__r.Reference_Rate__c, ISIN_Code__r.Initial_Leverage__c,' +
//				'Sales_Rep__r.Name, Sales_Rep__r.Email, Sales_Rep__r.Phone, ISIN_Code__r.Credit_Reference__r.Name__c,'  +
//				'Sales_Account__r.Name, Sales_Account__r.Email__c, Sales_Account__r.Phone, Account_Counterparty__r.ConfirmationEmailsList__c, ' +
//				'(Select id,Account__r.ConfirmationEmailsList__c, Margin__c, Account__c FROM TradeAccountAssignees__r WHERE Account_Type__c =\''+  String.escapeSingleQuotes(Constants.TRADEACCOUNTASSIGNE_ACCONT_TYPE_INTRODUCER) +'\' )' +
//				'FROM Trade__c ' +
//				'WHERE Id =\''+ String.escapeSingleQuotes(tradeId) +'\' ' +
//				'LIMIT 1';
//
//		List<Trade__c> trades = Database.query(queryString);
//
//		return trades;
//	}
//
//
//	public static List<Trade__c> getTradesByAccount(Id clientId) {
//		return  DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Size__c, CurrencyIsoCode, ISIN_Code__c, '+
//						'ISIN_Code__r.Issuer__r.Id, ISIN_Code__r.Issuer__r.Name, ' +
//						'ISIN_Code__r.Px_Last__c, ISIN_Code__r.Closest_Observation_Date__c, ISIN_Code__r.RecordTypeId ' +
//						'FROM Trade__c ' +
//						'WHERE Account_Name__c = \''+ String.escapeSingleQuotes(clientId) +'\' ' +
//						'AND ISIN_Code__r.IsActive = true ' +
//						'AND Trade_type__c = \'' + Constants.TRADE_TYPE_PICKLIST_BUY +'\' '+
//						'LIMIT 50000'
//		);
//	}
//
//	/*
//	 * @history: [COM-66] 18.10.18 Anna Makhovskaya: Added field "ISIN_Code__r.NextObservation__c" to query
//	 * */
//	public static List<Trade__c> getTrades() {
//		return  DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Size__c, CurrencyIsoCode, ISIN_Code__c, ISIN_Code__r.RecordType.DeveloperName, '+
//						'ISIN_Code__r.Issuer__r.Id, ISIN_Code__r.Issuer__r.Name, ISIN_Code__r.NextObservation__c, ' +
//						'ISIN_Code__r.Px_Last__c, ISIN_Code__r.Closest_Observation_Date__c, ISIN_Code__r.RecordTypeId  ' +
//						'FROM Trade__c ' +
//						'WHERE  ISIN_Code__r.IsActive = true ' +
//						'AND Trade_type__c = \'' + Constants.TRADE_TYPE_PICKLIST_BUY +'\' '+
//						'LIMIT 50000'
//		);
//	}
//
//
//
//	public static List<User> getAccountByContactCommunity(Id currentUserId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT AccountId ' +
//						'FROM User ' +
//						'WHERE Id = \''+ String.escapeSingleQuotes(currentUserId) +'\' ' +
//						'LIMIT 1'
//		);
//	}
//
//	public static List<Observation__c> getObservationsByMapProductIdAndType(Map<Id, Product2> product, String type) {
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromSObjectMap(product);
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Product__c, Coupon_trigger__c, Coupon_Value__c, ' +
//						'Autocall_trigger__c, Call_rate__c ' +
//						'FROM Observation__c '+
//						'WHERE Product__c IN ' + stringWithIdList + ' AND Type__c = \''+ String.escapeSingleQuotes(type) +'\''
//		);
//	}
//
//
//	public static List<ProductUnderlyingAssignee__c> getProductUnderlyingAssigneeByUnderlyingsId(Set<Id> underlyingsIdSet) {
//		String stringList = DataAccessorHelper.createStringListWithIdFromIdSet(underlyingsIdSet);
//
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id,  Strike__c, Performance__c, Underlying__c '+
//						'FROM ProductUnderlyingAssignee__c '+
//						'WHERE Underlying__r.Id IN ' + stringList +
//						'LIMIT 50000'
//		);
//	}
//
//	//INT-96+120 Aleksandr Shcherbanyuk
//
//	public static List<Product2> getProductWithProductUnderlyingAssigneeByProductMap(Map<Id, SObject> productMap) {
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromSObjectMap(productMap);
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, IsActive, Multichance__c, Underlying_type__c, ' +
//						'(SELECT Id FROM ProductUnderlyingAssignees__r) ' +
//						'FROM Product2 ' +
//						'WHERE Id IN ' + stringWithIdList +
//						'LIMIT 50000'
//		);
//	}
//
//
//	/*
//	 * @Author: Andriy Lokotosh
//	 * @Created Date: 2/10/2018
//	 * @Params: productIds
//	 * @Description:  get ProductUnderlyingAssignees__r and Observations from product set
//	 * @History: created
//	 */
//
//	public static List<Product2> getProductWithChilds(Set<Id> productIds){
//		return [SELECT Id, IsActive, Name, NextObservation__c, Multichance__c, Underlying_type__c, RecordType.DeveloperName, (SELECT Id FROM ProductUnderlyingAssignees__r), (Select id, Date__c, Type__c, Payment_date__c FROM Observations__r) FROM Product2 WHERE Id IN : productIds];
//	}
//
//	//INT-125 Aleksandr Shcherbanyuk
//	public static List<Product2> getProductWithProductUnderlyingAssigneeAndBasketTypeMultichance(Set<ID> productIdSet) {
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromIdSet(productIdSet);
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Multichance__c, ' +
//						'(SELECT Id FROM ProductUnderlyingAssignees__r) ' +
//						'FROM Product2 ' +
//						'WHERE Id IN ' + stringWithIdList +
//						'AND Underlying_type__c = \'' + Constants.UNDERLYINGTYPE_MULTICHANCE_PICKLIST_API_NAME + '\' ' +
//						'LIMIT 50000'
//		);
//	}
//
//	public static List<Product2> getProductWithProductUnderlyingAssigneeByProductId(Id productId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, IsActive, ' +
//						'(SELECT Id FROM ProductUnderlyingAssignees__r) ' +
//						'FROM Product2 ' +
//						'WHERE Id =\''+ String.escapeSingleQuotes(productId) +'\' ' +
//						'LIMIT 1'
//		);
//	}
//
//	//INT-81 Andrii Kolotii
//	public static List<Trade__c> getAccountForTrade(Id tradeId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Account_Name__c FROM Trade__c WHERE  Id = \''+ String.escapeSingleQuotes(tradeId) +'\' LIMIT 1'
//		);
//	}
//
//	public static List<Contact> getContactsByAccount(Id idAccount) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Name ' +
//						'FROM Contact ' +
//						'WHERE AccountId = \''+ String.escapeSingleQuotes(idAccount) +'\' ' +
//						'LIMIT 50000'
//		);
//	}
//
//	public static Map<Id, Contact> getContactsByAccountMap(Id idAccount) {
//		return new Map<Id, Contact>( (List<Contact>) DataAccessorHelper.getDataFromOrg(
//				'SELECT Id, Name, LastName, FirstName, Account.Name, AccountId ' +
//						'FROM Contact ' +
//						'WHERE AccountId = \''+ String.escapeSingleQuotes(idAccount) +'\' ' +
//						'LIMIT 50000'
//		));
//	}
//
//	//    public static List<TradeSelectedContact__c> getTradeSelectedContact(Id tradeId) {
//	//        return DataAccessorHelper.getDataFromOrg(
//	//            'SELECT  Contact__c ' +
//	//            'FROM TradeSelectedContact__c ' +
//	//            'WHERE Trade__c = \''+ String.escapeSingleQuotes(tradeId) +'\' ' +
//	//            'LIMIT 50000'
//	//        );
//	//    }
//	//
//	//     public static List<TradeSelectedContact__c> getTradeSelectedContactIds(Id tradeId, Id contactId) {
//	//        return DataAccessorHelper.getDataFromOrg(
//	//            'SELECT  Id ' +
//	//            'FROM TradeSelectedContact__c ' +
//	//            'WHERE Trade__c = \''+ String.escapeSingleQuotes(tradeId) +'\' AND Contact__c =  \''+ String.escapeSingleQuotes(contactId) +'\'' +
//	//            'LIMIT 1'
//	//        );
//	//    }
//
//	public static List<Product2> getProductWithProductUnderlyingAssigneesByProductId(Id productId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Name, Product_subtype__c, Bonus_Level__c, Payoff__c, CurrencyIsoCode, Barrier_level__c, ' +
//						'Underlying_type__c, Multichance__c, Redemption_currency__c, Strike_level__c, Barrier_type__c, Coupon_type__c, Coupon_trigger__c, ' +
//						'First_call_in__c, Autocall_trigger__c, Call_rate__c, IsActive, Capital_Protection_Level__c, ' +
//						'Cap__c, Upside_Participation_Level__c, RecordType.DeveloperName, Barrier_activated__c, Downside_leverage__c, ' +
//						'(SELECT Id, Performance__c, Underlying__r.Low__c, Underlying__r.Name, Underlying__r.Spot__c, Strike__c,Weighting__c, Name FROM ProductUnderlyingAssignees__r), ' +
//						'(SELECT Id, Account_Name__c FROM Trades__r), '+
//						'(SELECT Id, Paid__c, Date__c, Type__c, Product__c, Payment_date__c, Coupon_trigger__c, Coupon_Value__c, Autocall_trigger__c, ' +
//						'Final_payment_date__c, Obsv_number__c, CurrencyIsoCode, Next_Observation__c, Call_rate__c ' +
//						'FROM Observations__r) ' +
//						'FROM Product2 WHERE Id = \''+ String.escapeSingleQuotes(productId) +'\' ' +
//						'LIMIT 1'
//		);
//
//	}
//
	public static Profile[] getProfileByName(String profileName) {
		return DataAccessorHelper.getDataFromOrg(
						'SELECT Id, Name ' +
						'FROM Profile ' +
						'WHERE Name = \'' + String.escapeSingleQuotes(profileName) + '\' ' +
						'LIMIT 1'
		);
	}
//
	/*
	 * @author: Dmytro Lambru
	 * @date: 25.10.2018
	 * @description: Get Profile record by ID
	 * @param: productId - Profile ID
	 * @ticket: INT-261
	 */
	public static Profile[] getProfileById(Id profileId) {
		return DataAccessorHelper.getDataFromOrg(
						'SELECT Name ' +
						'FROM Profile ' +
						'WHERE Id = \'' + String.escapeSingleQuotes(profileId) + '\' ' +
						'LIMIT 1'
		);
	}
//
//	public static Trade__c[] getTradesByAccountIdsAndProfileId(Map<Id, Trade__c> tradeMap, Id profileId) {
//		String stringWithIdTrades = DataAccessorHelper.createStringListWithIdFromSObjectMap(tradeMap);
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Sales_Rep__c, Sales_Rep__r.ProfileId ' +
//						'FROM Trade__c ' +
//						'WHERE  Id IN ' + stringWithIdTrades + ' ' +
//						'AND Sales_Rep__r.ProfileId = \''+ String.escapeSingleQuotes(profileId) +'\' ' +
//						'LIMIT 50000'
//		);
//	}
//
//	public static Trade__Share[] getTradeShareByParentIdAndUserId(Trade__c[] trades, Id[] ownerIds) {
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromSObjectList(trades);
//		String stringOwnerIds = DataAccessorHelper.createStringListWithIdFromIdSet( new Set<Id>(ownerIds));
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id FROM Trade__Share WHERE ParentId IN ' + stringWithIdList + ' ' +
//						'AND UserOrGroupId IN ' + stringOwnerIds + ' ' +
//						'LIMIT 50000'
//		);
//
//	}
//
//	public static Trade__Share[] getObservationTradeShareByTradeIdsAndUserIds(Set<Id> tradeIds, Set<Id> userIds) {
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromIdSet(tradeIds);
//		String stringOwnerIds = DataAccessorHelper.createStringListWithIdFromIdSet(userIds);
//		return DataAccessorHelper.getDataFromOrg(
//				'SELECT Id FROM Trade__Share WHERE ParentId IN ' + stringWithIdList + ' ' +
//						'AND UserOrGroupId IN ' + stringOwnerIds + 'AND  RowCause =' + '\'' +Schema.Trade__Share.RowCause.SelectedForCommunity__c  + '\' ' +
//						'LIMIT 50000'
//		);
//
//	}
//
//	public static List<TradeContactAssignee__c> getTradeContactListByTradeId(Id tradeId){
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Trade__c, Contact__c, Contact__r.Name, Trade__r.Account_Name__c,  Contact__r.Confirmations_emails__c,  Contact__r.Email,  Related_To__c ' +
//						'FROM TradeContactAssignee__c ' +
//						'WHERE Trade__c = \''+ String.escapeSingleQuotes(tradeId) +'\' ' +
//						'LIMIT 50000'
//		);
//	}
//
//	public static List<AggregateResult> getCountExistsContactByTradeId(Id tradeId, Id contactId, Boolean isConfirmation){
//
//		String type = isConfirmation ? 'Confirmation' : 'Observation';
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT COUNT(Id) recordsCount ' +
//						'FROM TradeContactAssignee__c ' +
//						'WHERE Related_To__c =  \'' + type +  '\' AND Trade__c = \''+ String.escapeSingleQuotes(tradeId) +'\'  AND Contact__c = \''+ String.escapeSingleQuotes(contactId) +'\' '
//		);
//	}
//
//	public static List<TradeContactAssignee__c> getTradeContactListByTradeIdAndContactId(Id tradeId, Id contactId, Id objectId){
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, Trade__r.Name, Trade__c, Contact__c, Contact__r.Name,  Contact__r.Confirmations_emails__c,  Contact__r.Email ' +
//						'FROM TradeContactAssignee__c ' +
//						'WHERE Trade__c = \''+ String.escapeSingleQuotes(tradeId) +'\'  AND Contact__c = \''+ String.escapeSingleQuotes(contactId) +'\'  AND id = \''+ String.escapeSingleQuotes(objectId) +'\' ' +
//						'LIMIT 50000'
//		);
//	}
//
//	public static List<Contact> getContactRecordTypeAccountByContactId(Id contactId) {
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Account.RecordTypeId ' +
//						'FROM Contact ' +
//						'WHERE Id = \''+ String.escapeSingleQuotes(contactId) +'\'  '+
//						'LIMIT 1'
//		);
//	}
//
//	/*
//	 * @description: return list tradeShareRecord for observation contact associated with trade and users
//	 * @params: List<Id> userIds - list of user's ids
//	 * 			Id tradeId - trade Id
//	 * @history: [INT-352] Makhovskaya Anna - refactoring, getting the result through getDataFromOrg
//	 * */
//	public static Trade__Share[] getTradeShareByParentIdAndUserContactIds(Id tradeId,  List<Id> userIds) {
//
//		if(!userIds.isEmpty()) {
//			String stringWithUserIdList = DataAccessorHelper.createStringListWithIdFromIdSet(userIds);
//
//			return DataAccessorHelper.getDataFromOrg('SELECT Id, UserOrGroupId, ParentId ' +
//					'FROM Trade__Share ' +
//					'WHERE ParentId = \'' + String.escapeSingleQuotes(tradeId) + '\'   AND UserOrGroupId  IN  ' + stringWithUserIdList + ' AND  RowCause =' + '\'' +Schema.Trade__Share.RowCause.SelectedForCommunity__c  + '\' ' +
//					'LIMIT 50000');
//
//		}else{
//			return new List<Trade__Share>();
//		}
//	}
//
//
	/*
	 * @description: return list active community users associated with transmitted contacts
	 * @param: Set<Id> contacts - set of contact's ids
	 * @history: [INT-352] Makhovskaya Anna - added check for empty set, getting the result through getDataFromOrg
	 * */
	public static List<User> contactsAvailableInCommunity(Set<Id> contacts){

		if(!contacts.isEmpty()) {
			Profile communProfile = DataAccessor.getProfileByName(Constants.PROFILE_NAME_COSTOMER_COMMUNITY_PLUS_USER)[0];

			String stringWithContactsIdSet = DataAccessorHelper.createStringListWithIdFromIdSet(contacts);

			return DataAccessorHelper.getDataFromOrg('SELECT Id, ContactId '+
					'FROM User '+
					'WHERE ContactId IN '+ stringWithContactsIdSet +' AND IsActive = true AND ProfileId = \''+ String.escapeSingleQuotes(communProfile.Id) +'\'  '+
					'LIMIT 50000');
		}else {
			return new List<User>();
		}
	}
//
//
//	public static List<User> getUserByContactId(Id contactId){
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id ' +
//						'FROM User ' +
//						'WHERE ContactId  = \''+ String.escapeSingleQuotes(contactId) +'\' ' +
//						'LIMIT 5000'
//		);
//	}
//
//	public static List<Trade__c> getOwnerIdTrade(Id tradeId){
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Account_Name__r.OwnerId  ' +
//						'FROM Trade__c ' +
//						' WHERE Id =  \''+ String.escapeSingleQuotes(tradeId) +'\' ' +
//						'LIMIT 5000'
//		);
//	}
//
//	/*
//	 * @author: Anna Mahovskaya
//	 * @history: [COM-48] Dmytro Lambru 10.10.18: Added "Trade_Date__c" field to the query
//	 *           [COM-50] Dmytro Lambru 10.10.18: Added "ISIN_Code__r.Product_subtype__c" field to the query
//	 *           [COM-66] Anna Makhovskaya 18.10.18: Added "ISIN_Code__r.NextObservation__c" field to the query
//	 *           [COM-67] Anna Makhovskaya 18.10.18: Added "(SELECT Contact__r.Margin_visibility__c  FROM  TradeContactAssignees__r)" subquery
//	 *           [COM-98] Anna Makhovskaya 9.11.18: Added "Client_Margin__c" field to the query
//	 *           [COM-84] Dmytro Lambru 22.11.18: Added "ISIN_Code__r.Maturity__c" and "ISIN_Code__r.Issuer__r.Name" field to the query
//	 *           [COM-107] Makhovskaja Anna 3.1.2019: Added new param - tradesIdSet -set of trades ID for which the user has access
//	 *           [COM-123] Makhovskaja Anna 6.3.2019: Added field Final_Fixing_Date to the query
//	 *           [COM-139] Makhovskaja Anna 12.3.2019: now select All types of trades and added Trade_type__c field to the query
//	 *           [INT-548] Makhovskaja Anna 17.4.2019: Added field ISIN_Code__r.Barrier_activated__c to the query
//	 */
//	public static List<Trade__c> getTradesForMyProductsPage(List<Id>  nextObservationIds, Id productRecordTypeId, Set<Id> tradesIdSet ) {
//		String stringWithTradesIdSet = DataAccessorHelper.createStringListWithIdFromIdSet(tradesIdSet);
//		String query = 'SELECT Id, Name, Trade_Date__c, Size__c, Price_client__c, Price_Final_Client__c, Client_Margin__c, '+
//				'ISIN_Code__c, ISIN_Code__r.Product_subtype__c, ISIN_Code__r.IsActive, ISIN_Code__r.Name,  ISIN_Code__r.CurrencyIsoCode, ISIN_Code__r.Maturity__c, ISIN_Code__r.Final_Fixing_Date__c, ISIN_Code__r.Barrier_activated__c, '+
//				'ISIN_Code__r.Px_Last__c, ISIN_Code__r.Closest_Observation_Date__c, ISIN_Code__r.Underlying_type__c, ISIN_Code__r.NextObservation__c, ISIN_Code__r.Issuer__r.Name, Trade_type__c,'+
//				'(SELECT Contact__r.Margin_visibility__c  FROM  TradeContactAssignees__r) '+
//				'FROM Trade__c ' +
//				'WHERE Id IN '+stringWithTradesIdSet;
//		if(nextObservationIds != null){
//			String stringWithIdList = DataAccessorHelper.createStringListWithIdFromIdSet( new Set<Id>(nextObservationIds));
//			query += ' AND ISIN_Code__c IN '+stringWithIdList+ ' AND ISIN_Code__r.IsActive=true ';
//		}else if(productRecordTypeId != null) {
//			query += ' AND  ISIN_Code__r.RecordTypeId = \''+ String.escapeSingleQuotes(productRecordTypeId) +'\'  AND ISIN_Code__r.IsActive=true ' ;
//		}
//		query += ' LIMIT 50000';
//
//		return  DataAccessorHelper.getDataFromOrg(query);
//	}
//
//	/* NOT IN USE, BUILD FIX */
//	public static List<Trade__c> getTradesPortfolio(List<Id>  nextObservationIds, Id productRecordTypeId, Set<Id> tradesIdSet ) {
//		String stringWithTradesIdSet = DataAccessorHelper.createStringListWithIdFromIdSet(tradesIdSet);
//		String query = 'SELECT Id, Name, Trade_Date__c, Size__c, Price_client__c, Price_Final_Client__c, Client_Margin__c, '+
//				'ISIN_Code__c, ISIN_Code__r.Product_subtype__c, ISIN_Code__r.IsActive, ISIN_Code__r.Name,  ISIN_Code__r.CurrencyIsoCode, ISIN_Code__r.Maturity__c, ISIN_Code__r.Final_Fixing_Date__c, '+
//				'ISIN_Code__r.Px_Last__c, ISIN_Code__r.Closest_Observation_Date__c, ISIN_Code__r.Underlying_type__c, ISIN_Code__r.NextObservation__c, ISIN_Code__r.Issuer__r.Name, Trade_type__c,'+
//				'(SELECT Contact__r.Margin_visibility__c  FROM  TradeContactAssignees__r) '+
//				'FROM Trade__c ' +
//				'WHERE Id IN '+stringWithTradesIdSet;
//		if(nextObservationIds != null){
//			String stringWithIdList = DataAccessorHelper.createStringListWithIdFromIdSet( new Set<Id>(nextObservationIds));
//			query += ' AND ISIN_Code__c IN '+stringWithIdList+ ' AND ISIN_Code__r.IsActive=true ';
//		}else if(productRecordTypeId != null) {
//			query += ' AND  ISIN_Code__r.RecordTypeId = \''+ String.escapeSingleQuotes(productRecordTypeId) +'\'  AND ISIN_Code__r.IsActive=true ' ;
//		}
//		query += ' LIMIT 50000';
//
//		return  DataAccessorHelper.getDataFromOrg(query);
//	}
//
//
//	public static List<Trade__c> getTradesByNames(String[] tradesNames) {
//		String stringWithNamesList = DataAccessorHelper.createStringListWithNameFromListName(tradesNames);
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Name FROM Trade__c WHERE Name IN ' + stringWithNamesList
//		);
//	}
//
//	/*COM-46 Anna Makhovskaya*/
//	public static List<Observation__c> getInfoInvestmentSectionFoCommunity(String productId){
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Type__c, Date__c, Payment_date__c, '+
//
//						'Product__r.Strike__c, Product__r.Barrier_type__c, '+
//						'Product__r.Barrier_level__c, Product__r.Capital_Protection_Level__c, Product__r.Recovery_type__c, Product__r.Settlement_Type__c, '+
//						'Product__r.RecordTypeId, Product__r.Product_subtype__c, '+
//
//						'Product__r.Call_type__c, Product__r.Autocall_trigger__c, Product__r.Call_rate__c, Product__r.First_call_in__c, '+
//						'Autocall_trigger__c, Call_rate__c, Final_payment_date__c, '+
//
//						'Product__r.Coupon_Type_cln2__c, Product__r.Frequency__c, Product__r.Coupon_p_a__c, Product__r.Coupon_in_fine__c, '+
//						'Product__r.Coupon_type__c, Product__r.Coupon_trigger__c,  Product__r.Floating_Underlying__r.Name, Product__r.Floating_Underlying__r.Name__c, '+
//						'Coupon_Value__c, Coupon_trigger__c, Coupon_In_Fine__c,Paid__c '+
//
//						'FROM Observation__c '+
//						'WHERE Product__c = \''+String.escapeSingleQuotes(productId)+'\' '+
//						'LIMIT 50000');
//	}
//
//	/* @author: Anna Makhovskaya
//	 * @ticket: [COM-51]
//	 * @history: [COM-96] Dmytro Lambru 04.12.18 - Added field 'RecordType.DeveloperName'
//	 * 			 [COM-124] Anna Makhovskaya 27.03.19 - Added field 'Barrier_activated__c'
//	 * */
//	public static List<Product2> getProductInfoForCommunity(String productId){
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Name, RecordTypeId, Product_subtype__c, IsActive, RecordType.Name, '+
//						'RecordType.DeveloperName, Barrier_level__c, '+
//						'Issuer__r.Name, CurrencyIsoCode, Currency__c, Delivery_type__c, Payoff__c, Px_Last__c, '+
//						'Alternative_Currency__c,Converted__c,Redemption_currency__c, Coupon_in_fine__c, '+
//						'Maturity__c, Initial_Fixing_Date__c, Issue_Date__c, Final_Fixing_Date__c, Redemption_Date__c, '+
//						'Maturity_weeks__c, '+
//						'Underlying_type__c, '+
//						'Strike__c, Strike_level__c, Upside_Participation_Level__c, Cap__c, Capital_Protection_Level__c, '+
//						'Coupon_p_a__c, Coupon_type__c, Coupon_Type_cln2__c,  Floating_Underlying__r.Name__c, '+
//						'Frequency__c, Recovery_type__c, Settlement_Type__c, '+
//						'Issue_price__c, Downside_leverage__c, Barrier_type__c,Initial_Leverage__c, Stop_Loss__c,Bonus_Level__c, Barrier_activated__c, '+
//						'Leverage__c, Spread_Coupon_p_a__c, Reference_Rate__c, '+
//						'Credit__c, Credit_Reference__r.Name__c,  '+
//						'Coupon_trigger__c, '+
//						'Call_type__c, First_call_in__c, Autocall_trigger__c, Call_rate__c, '+
//						'(SELECT Id FROM Trades__r LIMIT 1) '+
//						'FROM Product2 '+
//						'WHERE Id = \''+String.escapeSingleQuotes(productId)+'\' '+
//						'LIMIT 1');
//	}
//
//	/*INT-180 Anna Makhovskaya*/
//	public static List<AIS_Solutions_Log__c> getAisSolutionLogs(String typeLog, String status, String priority, String timeLine, DateTime startDateVal, DateTime stopDateVal){
//
//		String query = 'SELECT Classes__c, Comment__c, Line__c, Message__c, Method__c, Priority__c, Status__c, Type__c, CreatedDate, Body__c  '+
//				'FROM AIS_Solutions_Log__c '+
//				'WHERE Type__c = \''+String.escapeSingleQuotes(typeLog)+'\' ';
// 		if(status != '') {
//			query += ' AND Status__c = \''+String.escapeSingleQuotes(status)+'\' ';
//		}
//		if(priority != '') {
//			query += ' AND Priority__c = \''+String.escapeSingleQuotes(priority)+'\' ';
//		}
//		if(timeLine == 'Today') {
//			query += ' AND CreatedDate = TODAY ';
//		}else if(timeLine == 'Week'){
//			query += ' AND CreatedDate >= LAST_WEEK ';
//		}else if(timeLine == 'Month'){
//			query += ' AND CreatedDate >= LAST_MONTH ';
//		}
//		if(startDateVal != null && stopDateVal != null){
//			query += ' AND CreatedDate >= '+startDateVal.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'')+
//					 ' AND CreatedDate <= '+stopDateVal.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'')+' ';
//		}
//		query += 'ORDER BY CreatedDate DESC LIMIT 50000';
//		System.debug(query);
//		return  DataAccessorHelper.getDataFromOrg(query);
//	}
//
//	/*INT-180 Anna Makhovskaya*/
//	public static List<AIS_Solutions_Log__c> getLogItem(Id logId){
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT  Classes__c, Comment__c, Line__c, Message__c, Method__c, Priority__c, Status__c, Type__c, CreatedDate, Body__c '+
//						'FROM AIS_Solutions_Log__c '+
//						'WHERE Id = \''+String.escapeSingleQuotes(logId)+'\' '+
//						'LIMIT 1');
//	}
//
//	/*COM-95 Anna Makhovskaya*/
//	public static List<ContentDocumentLink> getContentDocumentIdPdf(Id productId){
//		return DataAccessorHelper.getDataFromOrg(
//				'SELECT ContentDocumentId '+
//						'FROM ContentDocumentLink '+
//						'WHERE LinkedEntityId=\''+String.escapeSingleQuotes(productId)+'\' AND ContentDocument.FileType=\'PDF\' AND Visibility = \'AllUsers\' '+
//						'LIMIT 1');
//
//	}
//
//	/*COM-95 Anna Makhovskaya*/
//	public static List<ContentVersion> getFileExtensionsFromContentVersion(Set<Id> contentDocumentIdList){
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromIdSet(contentDocumentIdList);
//		return DataAccessorHelper.getDataFromOrg(
//				'SELECT ContentDocumentId, FileExtension '+
//				'FROM ContentVersion '+
//				'WHERE ContentDocumentId IN ' + stringWithIdList +
//				' LIMIT 50000'
//		);
//	}
//
//	/*COM-95 Anna Makhovskaya*/
//	public static List<ContentDocumentLink> getContentDocumentLinkByListId(Set<Id> updateRecordIdList) {
//		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromIdSet(updateRecordIdList);
//		return DataAccessorHelper.getDataFromOrg(
//				'SELECT Id, Visibility, ShareType '+
//				'FROM ContentDocumentLink '+
//				'WHERE Id IN ' + stringWithIdList +
//				' LIMIT 50000'
//		);
//	}
//
//	/*COM-97 Anna Makhovskaya*/
//	public static List<User> getContactIdByUserId(Id userId){
//		return DataAccessorHelper.getDataFromOrg(
//		'SELECT ContactId, isActive FROM User WHERE Id = \''+String.escapeSingleQuotes(userId)+'\' LIMIT 50000');
//	}
//
//	/*COM-97 Anna Makhovskaya*/
//	public static List<Trade__Share>  getTradeShareByUsersAndRowCause(List<Id> userIdList, List<String> rowCauseList){
//		String stringWithIdUserList =  DataAccessorHelper.createStringListWithIdFromIdSet( new Set<Id>(userIdList));
//		String stringWithIdRowCauseList = DataAccessorHelper.createStringListWithNameFromListName(rowCauseList);
//		return DataAccessorHelper.getDataFromOrg(
//						'SELECT Id, RowCause, ParentId, UserOrGroupId '+
//								'FROM Trade__Share '+
//								'WHERE UserOrGroupId IN ' + stringWithIdUserList + ' AND RowCause IN '+ stringWithIdRowCauseList +
//								' LIMIT 50000');
//	}
//
//	/*COM-94 Anna Makhovskaya
//	 * @history: [COM-129] amakhovskaya 7.03.19 - added isActive field in query*/
//	public static Map<Id, Product2> getProductUnderlyingMapForCalculatePerformance (Set<Id> productsIdSet){
//		Map<Id, Product2> result = new Map<Id, Product2>();
//		String stringWithProductsIdSet = DataAccessorHelper.createStringListWithIdFromIdSet(productsIdSet);
//		Map<Id, SObject> sObjectMap = DataAccessorHelper.getDataMapFromOrg(
//						'SELECT Id, Barrier_level__c, Barrier_activated__c, 	Strike_level__c, RecordTypeId, RecordType.Name, RecordType.DeveloperName, Name, NextObservation__c, Call_type__c,' +
//						' Barrier_type__c, Strike__c, Product_subtype__c, Issuer__r.Name, Coupon_type__c, First_call_in__c, isActive, '+
//						' Underlying_type__c, Multichance__c, (SELECT Underlying__r.Name__c, Underlying__r.Name, Performance__c, Weighting__c  FROM ProductUnderlyingAssignees__r),' +
//						'(SELECT Id, Type__c, Coupon_trigger__c, Autocall_trigger__c,Payment_date__c, Date__c, Obsv_number__c FROM Observations__r)'+
//						' FROM Product2' +
//						' WHERE  Id IN '+ stringWithProductsIdSet +
//						' LIMIT 50000'
//		);
//		if(!sObjectMap.isEmpty()){
//			for (Id key: sObjectMap.keySet()) {
//				Product2 product = (Product2)sObjectMap.get(key);
//				result.put(key, product);
//			}
//		}
//		return result;
//	}
//
//	/*INT-304  Anna Makhovskaya*/
//	public static User getUserInfoById (Id userId) {
//		return [SELECT User.Id, User.FirstName, User.LastName, User.Profile.Name, User.UserRole.Name, User.Manager.Name
//				FROM User ,User.profile, User.UserRole
//				WHERE Id = :userId
//				LIMIT 1];
//	}
//
//
//	/*
//	 * @author: Makhovskaya Anna for {INT-352] 16/01/2019
//     * @description: get all direct and indirect contacts associated with account
//     * @param: String accountId - account's id
//    */
//	public static List<AccountContactRelation> getAllContactsAssociatedWithAccount(String accountId){
//		return DataAccessorHelper.getDataFromOrg('SELECT  ContactId ' +
//				'FROM AccountContactRelation ' +
//				'WHERE AccountId = \'' + String.escapeSingleQuotes(accountId) + '\' '+
//				'LIMIT 50000');
//	}

}