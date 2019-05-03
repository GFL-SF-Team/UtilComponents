/**
 * Created on 5/29/2018.
 * @history Andrii Kolotii 03.26.19 move specific constants for observation emails to Generate Template For Observation Constants class
 */

public class Constants {
    public static final String PRODUCT_API_NAME = 'Product2';
    public static final String TRADE_API_NAME = 'Trade__c';
    /* Error text */
    //For validation of trigger dates based on frequency
    public static final Map<String,String> ERROR_BY_PRODUCT_FREQUENCY = new Map<String,String>{
        'weekly' => 'The difference between \'Initial Fixing Date\' and \'Final Fixing Date\' must be at least 7 days and  not blank',
        'monthly' => 'The difference between \'Initial Fixing Date\' and \'Final Fixing Date\' must be at least 1 months and  not blank',
        'quarterly' => 'The difference between \'Initial Fixing Date\' and \'Final Fixing Date\' must be at least 3 months and  not blank',
        'semiAnnually' => 'The difference between \'Initial Fixing Date\' and \'Final Fixing Date\' must be at least 6 months and  not blank',
        'annually' => 'The difference between \'Initial Fixing Date\' and \'Final Fixing Date\' must be at least 12 months and  not blank',
        'atMaturity' => 'The difference between \'Initial Fixing Date\' and \'Final Fixing Date\' must be at least the value in the \'Maturity\' field and not blank.'
    };
    public static final String ERROR_BY_PRODUCT_REDEMPTION_DATE = '\'Redemption Date\' must be greater than \'Final Fixing Date\' and not blank';
    public static final String ERROR_BY_PRODUCT_BASKETTYPE_MULTICHANCE_NULL = '\'Multichance\' should be 0. The product has 0 or 1 Underlying';
    public static final String ERROR_BY_PRODUCT_BASKETTYPE_MULTICHANCE_NOTNULL = '\'Multichance\' must be greater than 0. The product has 2 or more Underlyings';
    public static final String ERROR_BY_PRODUCT_BASKETTYPE_MULTICHANCE_NOTMORE = '\'Multichance\' should not be equal or be greater than the number of Underlyings';
    //For trigger Currency change Error
    public static final String ERROR_BY_PRODUCT_CURRENCY_CHANGED = 'There is a Trade associated with this product. Please delete it and re-create once the currency is updated';
    //For product trigger Error Activete Product
    public static final String ERROR_BY_PRODUCT_IS_ACTIVE = 'Product can\'t be active without Underlying(s)!';
    // For Send Treda Email Error
    public static final String CLIENT_NAME_EMPTY = 'Please specify client name.';
    public static final String CONTACT_WITH_ADMIN = 'Something wrong, Contact the Administrator';
    public static final String NO_PERMISSION_CONTACT_WITH_ADMIN = 'You don\'t have permissions, contact with Administrator';
    //For Trade Trigger Error
    public static final String TRADE_ERORR_FORMAT_TRADE_NAME = 'Wrong Trade Code format. Expecting \'TRA\' or full format as {TRA - YYYY - ####} (#- some digit).';
    public static final String TRADE_ERORR_FORMAT_TRADE_NAME_EXT = 'Wrong Trade Code format. Expecting \'EXT\' or full format as {EXT - YYYY - ####} (#- some digit).';
    public static final String TRADE_ERORR_FORMAT_TRADE_NAME_EXT_AND_TRA = 'Wrong Trade Code format. Expecting format as {abc - YYYY - ####} (abc - TRA or EXT, #- some digit).';
    public static final String TRADE_ERORR_CHANGED_TRADE_NAME = 'Error. You can\'t modify trade code. Only up to 0600';
    public static final String TRADE_ERORR_DUPLICATE_TRADE_NAME = 'Error. Duplicate Trade Code.';
    public static final String TRADE_ERORR_WRONG_TRADE_NUMBER = 'Error. Wrong Trade Name - Number.';
    public static final String TRADE_ERORR_WRONG_TRADE_YEAR = 'Error. Wrong Trade Name - Wrong year number.';
    public static final String TRADE_ERROR_TRADE_YEAR_GREATER_THEN_2019 = 'Error. Wrong Trade Name - You can\'t manually enter year greater then or equals to 2019.';
    public static final String TRADE_ERROR_FUTURE_TRADE_YEAR = 'Error. Wrong Trade Name - year can\'t be future date.';
    public static final String TRADE_ERROR_LESS_THEN_2018_YEAR = 'Error. Wrong Trade Name - year can\'t be less then 2018.';
    public static final String TRADE_ERORR_TRADE_NAME = 'Error. Fill in required fields - Name, Size and Client Name.';
    public static final String TRADE_ERORR_TRADE_CHECK_HANDLED_BY_AIS = 'Please check "Trade not handled by AIS" checkbox before you proceed';
    //Common errors
    public static final String DUPLICATE_ERROR = 'Duplicate Record';
    public static final String ADD_ERROR = 'Add error';
    public static final String SYSTEM_ERROR = 'System error';
    public static final String QUERY_PROBLEM_ERROR = 'Some query problem';
    //Errors for Product and Underlying
    public static final String ERROR_ADD_MORE_UNDERLYINGS = 'You can\'t add more than one Underlyings for this product.';
    public static final String ERROR_ADD_UNDERLYINGS_TO_DUAL_CURRENCY = 'You can add only Underlyings \'EURUSD\' for this product.';

    /* For L_PriceRequestSendEmail */
    public static final String AIS_BAHAMAS_OPERATIONS = 'AIS Bahamas operations';
    public static final String AIS_GENEVA_OPERATIONS = 'AIS Geneva operations';
    public static final String AIS_BAHAMAS = 'AIS Bahamas';
    public static final String TM_SEND_EMAIL_PRICE_REQUEST = 'TM_Send_email_price_request';
    
    /* For ProductTrigger */
    //PAYMENT DATE - interval in days
    public static final Integer PAYMENT_DATE_INTERVAL = 7;

    // Fields
    public static final String FREQUENCY_FIELD_API_NAME = 'Frequency__c';
    public static final String TYPE_FIELD_API_NAME = 'Type__c';
    public static final String PRODUCTSUBTYPE_FIELD_API_NAME = 'Product_subtype__c';
    public static final String PRODUC_CURRENCY_FIELD_API_NAME = 'CurrencyIsoCode';
    public static final String PRODUCT_RECORDTYPEID_FIELD_API_NAME = 'RecordTypeId';
    public static final String PRODUCT_COUPONTYPE_FIELD_API_NAME = 'Coupon_type__c';

    /* Picklist API names */
    /* Observation__c - Object */
    public static final String TYPE_COUPON_PICKLIST_API_NAME = 'Coupon';
    public static final String TYPE_CALLABILITY_PICKLIST_API_NAME = 'Callability';
    public static final String TYPE_MATURITY_PICKLIST_API_NAME = 'Maturity';
    public static final String TYPE_INTEREST_PICKLIST_API_NAME = 'Interest';
    /* Product2 - Object */
    public static final String FREQUENCY_NA_PICKLIST_API_NAME = 'N/A';
    public static final String FREQUENCY_WEEKLY_PICKLIST_API_NAME = 'Weekly';
    public static final String FREQUENCY_MONTHLY_PICKLIST_API_NAME = 'Monthly';
    public static final String FREQUENCY_QUARTERLY_PICKLIST_API_NAME = 'Quarterly';
    public static final String FREQUENCY_SEMIANNUALLY_PICKLIST_API_NAME = 'Semi Annually';
    public static final String FREQUENCY_ANNUALLY_PICKLIST_API_NAME = 'Annually';
    public static final String FREQUENCY_ATMATURITY_PICKLIST_API_NAME = 'At maturity';
    //Product2.Coupon_Type_cln2__c picklist values
    public static final String COUPON_TYPE_CLN_FLO_PICKLIST_API_NAME = 'FLO';
    public static final String COUPON_TYPE_CLN_FIX_PICKLIST_API_NAME = 'FIX';
    //Product2.Recovery_type__c picklist values
    public static final String RECOVERYTYPE_MARKETRECOVERY_PICKLIST_API_NAME = 'Market recovery';

    //Product fields
    public static final String PRODUCT_SETTLEMENT_TYPE = 'Settlement_Type__c';
    public static final String PRODUCT_ACCOMPLISH_STEPS_API_NAME = 'AccomplishProductSteps__c';
    //Product subtype
    public static final String PRODUCTSUBTYPE_REVERSECONVERTIBLE_PICKLIST_API_NAME = 'Reverse Convertible';
    public static final String PRODUCTSUBTYPE_REVERSE_CONVERTIBLE_AUTOCALL_PICKLIST_API_NAME = 'Reverse Convertible Autocall';
    public static final String PRODUCTSUBTYPE_REVERSE_CONVERTIBLE_SOFTCALL_PICKLIST_API_NAME = 'Reverse Convertible Softcall';
    public static final String PRODUCTSUBTYPE_BARRIERREVERSECONVERTIBLE_PICKLIST_API_NAME = 'Barrier Reverse Convertible';
    public static final String PRODUCTSUBTYPE_DISCOUNTCERTIFICATE_PICKLIST_API_NAME = 'Discount Certificate';
    public static final String PRODUCTSUBTYPE_BARRIERDISCOUNTCERTIFICATE_PICKLIST_API_NAME = 'Barrier Discount Certificate';
    public static final String PRODUCTSUBTYPE_CLASSICAUTOCALL_PICKLIST_API_NAME = 'Classic Autocall';
    public static final String PRODUCTSUBTYPE_CLASSICSOFTCALL_PICKLIST_API_NAME = 'Classic Softcall';
    public static final String PRODUCTSUBTYPE_PHOENIXAUTOCALL_PICKLIST_API_NAME = 'Phoenix Autocall';
    public static final String PRODUCTSUBTYPE_PHOENIXSOFTCALL_PICKLIST_API_NAME = 'Phoenix Softcall';
    public static final String PRODUCTSUBTYPE_TWINWINAUTOCALL_PICKLIST_API_NAME = 'Twin-Win Autocall';
    public static final String PRODUCTSUBTYPE_TWINWINSOFTCALL_PICKLIST_API_NAME = 'Twin-Win Softcall';
    public static final String PRODUCTSUBTYPE_CLN_PICKLIST_API_NAME = 'CLN';
    public static final String PRODUCTSUBTYPE_WARRANT_PICKLIST_API_NAME = 'Warrant';
    public static final String PRODUCTSUBTYPE_MINI_FUTURE_PICKLIST_API_NAME = 'Mini-Future';
    public static final String PRODUCTSUBTYPE_OTHER_PICKLIST_API_NAME = 'Other';
    public static final String PRODUCTSUBTYPE_STABILITY_NOTE_PICKLIST_API_NAME = 'Stability Note';
    public static final String PRODUCTSUBTYPE_CAPITAL_PROTECTION_WITH_PARTICIPATION_PICKLIST_API_NAME = 'Capital Protection with Participation';
    public static final String PRODUCTSUBTYPE_CAPITAL_PROTECTION_WITH_COUPON_PICKLIST_API_NAME = 'Capital Protection with Coupon';

    public static final String PRODUCTSUBTYPE_TWINWIN_CERTIFICATE_PICKLIST_API_NAME = 'Twin-Win Certificate';
    public static final String PRODUCTSUBTYP_TRACKER_CERTIFICATE_PICKLIST_API_NAME = 'Tracker Certificate';
    public static final String PRODUCTSUBTYP_OUTPERFORMANCE_CERTIFICATE_PICKLIST_API_NAME = 'Outperformance Certificate';
    public static final String PRODUCTSUBTYP_BONUS_CERTIFICATE_PICKLIST_API_NAME = 'Bonus Certificate';
    public static final String PRODUCTSUBTYP_BONUSOUTPERFORMANCE_CERTIFICATE_PICKLIST_API_NAME = 'Bonus Outperformance Certificate';

    public static final String PRODUCTSUBTYPE_MULTIPERFORMANCE_AUTOCALL_PICKLIST_API_NAME = 'Multiperformance Autocall';
    public static final String PRODUCTSUBTYPE_MULTIPERFORMANCE_SOFTCALL_PICKLIST_API_NAME = 'Multiperformance Softcall';
    public static final String PRODUCTSUBTYPE_DUALCURRENCYNOTE_PICKLIST_API_NAME = 'Dual Currency Note';

    //Product Interest type picklist
    public static final String PRODUCT_PARTICIPATION_INTEREST_TYPE_PICKLIST_API_NAME = 'Participation';
    public static final String PRODUCT_COUPON_INTEREST_TYPE_PICKLIST_API_NAME = 'Coupon';
    //Product 'Barrier_type__c' picklist
    public static final String BARRIERTYPE_EUROPEAN_PICKLIST_API_NAME = 'European';
    public static final String BARRIERTYPE_AMERICAN_PICKLIST_API_NAME = 'American';
    public static final String BARRIERTYPE_DAILYCLOSE_PICKLIST_API_NAME = 'Daily close';
    public static final String BARRIERTYPE_LOWSTRIKE_PICKLIST_API_NAME = 'Low strike';
    public static final String BARRIERTYPE_DISTANCE2_PICKLIST_API_NAME = 'Distance 2';
    public static final String BARRIERTYPE_NONE_PICKLIST_API_NAME = 'None';



    //Currency
    public static final String EUR = 'EUR';
    public static final String USD = 'USD';
    public static final String EURUSD = 'EURUSD';


    //Product Coupon Type
    public static final String COUPONTYPE_CONDITIONALWITHMEMORY_PICKLIST_API_NAME = 'Conditional with memory';
    public static final String COUPONTYPE_CONDITIONALWITHOUTMEMORY_PICKLIST_API_NAME = 'Conditional without memory';
    public static final String COUPONTYPE_GUARANTEED_PICKLIST_API_NAME = 'Guaranteed';
    public static final String COUPONTYPE_NOCOUPON_PICKLIST_API_NAME = 'No coupon';
    //Account
    public static final String ACCOUNTSTATUS_ACTIVE_PICKLIST_API_NAME = 'Active';
    public static final String ACCOUNT_PROFESSIONAL_RELATIONSHP_PICKLIST_API_NAME = 'Broker';

    //Product Call Type
    public static final String CALLTYPE_AUTOCALL_PICKLIST_API_NAME = 'Autocall';
    public static final String CALLTYPE_SOFTCALL_PICKLIST_API_NAME = 'Softcall';
    public static final String CALLTYPE_NONCALL_PICKLIST_API_NAME = 'Non call';
    //Field Label - 'Basket type' | API Name - 'Underlying_type__c'
    public static final String UNDERLYINGTYPE_SINGLE_PICKLIST_API_NAME = 'Single';
    public static final String UNDERLYINGTYPE_SINGLE_BEARISH_PICKLIST_API_NAME = 'Single (bearish)';
    public static final String UNDERLYINGTYPE_LOW_STRIKE_PICKLIST_API_NAME = 'Low strike';
    public static final String UNDERLYINGTYPE_WORSTOF_PICKLIST_API_NAME = 'Worst of';
	public static final String UNDERLYINGTYPE_BESTOF_PICKLIST_API_NAME = 'Best of';
	public static final String UNDERLYINGTYPE_BESTOF_BEARISH_PICKLIST_API_NAME = 'Best of (bearish)';
	public static final String UNDERLYINGTYPE_BASKET_PICKLIST_API_NAME = 'Basket';
	public static final String UNDERLYINGTYPE_MULTICHANCE_PICKLIST_API_NAME = 'Multichance';
	public static final String UNDERLYINGTYPE_MULTIPERFORMANCE_PICKLIST_API_NAME = 'Multiperformance (Sum of performance)';
    //Field Label - Delivery | API Name - Delivery_type__c
    public static final String DELIVERYTYPE_CASH_PICKLIST_API_NAME = 'Cash';
    public static final String DELIVERYTYPE_PHYSICAL_PICKLIST_API_NAME = 'Physical';

    /* Underlying__c - Object */
    //picklist field values
    public static final String TYPE_CORP_PICKLIST_API_NAME = 'Corp';

    //Mail history Types
    public static final String EMAIL_HISTORY_TYPE_CLIENT = 'Client';
    public static final String EMAIL_HISTORY_TYPE_ISSUER = 'Issuer';
    public static final String EMAIL_HISTORY_TYPE_INTRODUCER = 'Introducer';
    public static final String EMAIL_HISTORY_TYPE_COUNTERPARTY = 'Counterparty';

    //Confirmation email error
    public static final String TRADE_NO_HAVE_INTRODUCER = 'Trade do not have Introducer(s)';
    public static final String CONTACT_ASSIGNEE_TYPE_CONFIRMATION = 'Confirmation';
    public static final String CONTACT_ASSIGNEE_TYPE_OBSERVATION = 'Observation';
//    public static final String CONTACT_ASSIGNEE_TYPE_OBSERVATION = 'Trade do not have Introducer(s)';


    /* Record Types */
    //Account
    //public static final String ACCOUNT_AIS_RECORDTYPE_API_NAME = 'Account_AIS';
    public static final String ACCOUNT_ISSUER_RECORDTYPE_API_NAME = 'Issuer';
    public static final String ACCOUNT_CUSTODIAN_RECORDTYPE_API_NAME = 'Custodian';
    public static final String ACCOUNT_CUSTODIAN_TYPE_API_NAME = 'Custodian';
    public static final String ACCOUNT_INDIVIDUAL_CLIENT_RECORDTYPE_API_NAME = 'Individual_Client';
    public static final String ACCOUNT_INDIVIDUAL_CLIENT_TYPE_API_NAME = 'Individual Client';
    public static final String ACCOUNT_INSTITUTIONAL_CLIENT_RECORDTYPE_API_NAME = 'Institutional_Client';
    public static final String ACCOUNT_INSTITUTIONAL_CLIENT_TYPE_API_NAME = 'Institutional Client';
    public static final String ACCOUNT_PROFESSIONAL_RELATIONSHP_API_NAME = 'Account_Professional_Relationship';
    //Product2
    public static final String PRODUCT_CAPITAL_PROTECTION_ACTIVE_RECORDTYPE_NAME = 'Capital Protection Active';

    public static final String PRODUCT_EXPRESSCERTIFICATE_RECORDTYPE_API_NAME = 'Express_Certificate';
    public static final String PRODUCT_DUALCURRENCYNOTE_RECORDTYPE_API_NAME = 'Dual_Currency_Note';
    public static final String PRODUCT_YIELDENHANCEMENT_RECORDTYPE_API_NAME = 'Yield_Enhancement';
    public static final String PRODUCT_CAPITALPROTECTION_RECORDTYPE_API_NAME = 'Capital_Protection';
    public static final String PRODUCT_PARTICIPATION_RECORDTYPE_API_NAME = 'Participation';
    public static final String PRODUCT_CREDIT_RECORDTYPE_API_NAME = 'Credit';
    public static final String PRODUCT_LEVERAGE_RECORDTYPE_API_NAME = 'Leverage';
    public static final String PRODUCT_OTHER_RECORDTYPE_API_NAME = 'Other';
    public static final String PRODUCT_STABILITY_NOTE_RECORDTYPE_API_NAME = 'Stability_Note';
	//Price request
	public static final String PRICEREQUEST_YIELDENHANCEMENT_RECORDTYPE_API_NAME = 'Yiled_Enhancement';
    /* Subtypes for Email Template Price_Request__c */
    public static final List<String> SYBTYPE_FOR_CAPITAL_PROTECTION =
        new List<String> {'Capital Protection with Participation', 'Capital Protection with Coupon'};
    public static final List<String> SYBTUPE_FOR_CREDIT = 
        new List<String> {'CLN'};
    public static final List<String> SYBTUPE_FOR_DUAL_CURRENCY_NOTE = 
        new List<String> {'Dual Currency Note'};
    public static final List<String> SYBTUPE_FOR_EXPRESS_CERTIFICATE = 
        new List<String> {'Classic Autocall', 'Classic Softcall', 'Phoenix Autocall',
            'Phoenix Softcall', 'Reverse Convertible Autocall', 'Reverse Convertible Autocall',
            'Multiperformance Autocall', 'Multiperformance Softcall', 'Multiperformance Softcall',
            'Twin-Win Autocall'};
    public static final List<String> SYBTUPE_FOR_PARTICIPATION = 
        new List<String> {'Tracker Certificate', 'Outperformance Certificate', 'Bonus Certificate',
            'Bonus Outperformance Certificate', 'Twin-Win Certificate'};
    public static final List<String> SYBTUPE_FOR_YIELD_ENHANCEMENT_T1 = 
        new List<String> {'Discount Certificate', 'Reverse Convertible'};
    public static final List<String> SYBTUPE_FOR_YIELD_ENHANCEMENT_T2 = 
        new List<String> {'Barrier Discount Certificate', 'Barrier Reverse Convertible'};
    //Start INT 255 Aleksand Sherbanyuk 10/17/18
    public static final List<String> SYBTUPE_FOR_STABILITY_NOTE =
        new List<String> {'Stability Note'};
    //End INT 255 Aleksand Sherbanyuk 10/17/18
    /* For Community */
    public static final List<Integer> RECORD_FOR_PAGE = new List<Integer> {5,10,25,30};

    //[COM-50] Dmytro Lambru 10.10.18: Added map with "Product_subtype__c" field
    //[COM-95] Anna Makhovskaya 13/11/2018 added map for upload Pdf file on AIS Product Page
    public static final List<Map<String,String>> FIELDS_FOR_CREDIT =
        new List<Map<String,String>>  { new Map<String,String> {'name'=>'Name', 'clicable'=>'true', 'suffix'=>''},
            new Map<String,String> {'name'=>'Product_subtype__c', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Maturity__c', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'CurrencyIsoCode', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Underlyings', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Coupon_p_a__c', 'clicable'=>'', 'suffix'=>'%'},
            new Map<String,String> {'name'=>'Frequency__c', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Recovery_type__c', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'UploadPdf', 'clicable'=>'', 'suffix'=>''}
            };

    //[COM-50] Dmytro Lambru 11.10.18: Added "Product Subtype" label
    public static final List<String> LABELS_FOR_CREDIT =
        new List<String>  { 'ISIN', 'Product Subtype', 'Maturity', 'Currency', 'Underlyings', 'Coupon', 'Observations',
            'Recovery'};
    public static final List<String> CREDIT_RECORD_TYPES = 
        new List<String>  {'Credit'};
            
    //[COM-83] Anna Makhovskaya 6/11/2018 added params for sorting AIS Product Page
    //[COM-95] Anna Makhovskaya 13/11/2018 added map for upload Pdf file on AIS Product Page
    public static final List<Map<String,String>> LABELS_FOR_CREDIT_SORT  =
    new List<Map<String,String>> {
            new Map<String, String> {'tableLabel'=>'ISIN', 'idColumn'=>'Name', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Product Subtype', 'idColumn'=>'Product_subtype__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Maturity', 'idColumn'=>'Maturity__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Currency', 'idColumn'=>'CurrencyIsoCode', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Underlyings', 'idColumn'=>'Underlyings', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Coupon', 'idColumn'=>'Coupon_p_a__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Observations', 'idColumn'=>'Frequency__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Recovery', 'idColumn'=>'Recovery_type__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'', 'idColumn'=>'UploadPdf', 'isDescSort' => 'true'}
     };         

    //[COM-50] Dmytro Lambru 10.10.18: Added map with "Product_subtype__c" field
    //[COM-95] Anna Makhovskaya 13/11/2018 added map for upload Pdf file on AIS Product Page
    public static final List<Map<String,String>> FIELDS_FOR_PARTICIPATION  =
        new List<Map<String,String>>  { new Map<String,String> {'name'=>'Name', 'clicable'=>'true', 'suffix'=>''},
            new Map<String,String> {'name'=>'Product_subtype__c', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Maturity__c', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'CurrencyIsoCode', 'clicable'=>'', 'suffix'=>''}, 
            new Map<String,String> {'name'=>'Underlyings', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Upside_Participation_Level__c', 'clicable'=>'', 'suffix'=>'%'},
            new Map<String,String> {'name'=>'Barrier_level__c', 'clicable'=>'', 'suffix'=>'%'},
            new Map<String,String> {'name'=>'Cap__c', 'clicable'=>'', 'suffix'=>'%'},
            new Map<String,String> {'name'=>'Performance', 'clicable'=>'', 'suffix'=>'%'},
            new Map<String,String> {'name'=>'UploadPdf', 'clicable'=>'', 'suffix'=>''}
            };

    //[COM-50] Dmytro Lambru 11.10.18: Added "Product Subtype" label
    public static final List<String> LABELS_FOR_PARTICIPATION =
        new List<String>  { 'ISIN', 'Product Subtype', 'Maturity', 'Currency', 'Underlyings', 'Participation', 'Barrier', 'Cap',
         'Reference Level'};
    public static final List<String> PARTICIPATION_RECORD_TYPES =         
        new List<String>  {'Capital_Protection', 'Participation'};
            
    //[COM-83] Anna Makhovskaya 6/11/2018 added params for sorting AIS Product Page
    //[COM-95] Anna Makhovskaya 13/11/2018 added map for upload Pdf file on AIS Product Page
    public static final List<Map<String,String>> LABELS_FOR_PARTICIPATION_SORT  =
    new List<Map<String,String>> {
            new Map<String, String> {'tableLabel'=>'ISIN', 'idColumn'=>'Name', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Product Subtype', 'idColumn'=>'Product_subtype__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Maturity', 'idColumn'=>'Maturity__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Currency', 'idColumn'=>'CurrencyIsoCode', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Underlyings', 'idColumn'=>'Underlyings', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Participation', 'idColumn'=>'Upside_Participation_Level__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Barrier', 'idColumn'=>'Barrier_level__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Cap', 'idColumn'=>'Cap__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Reference Level', 'idColumn'=>'Performance', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'', 'idColumn'=>'UploadPdf', 'isDescSort' => 'true'}
     };        

    //[COM-50] Dmytro Lambru 10.10.18: Added map with "Product_subtype__c" field
    //[COM-95] Anna Makhovskaya 13/11/2018 added map for upload Pdf file on AIS Product Page
    public static final List<Map<String,String>> FIELDS_FOR_YIELD_ENHANCEMENT  =
        new List<Map<String,String>>  { new Map<String,String> {'name'=>'Name', 'clicable'=>'true', 'suffix'=>''},
            new Map<String,String> {'name'=>'Product_subtype__c', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Maturity__c', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'CurrencyIsoCode', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Underlyings', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Coupon_p_a__c', 'clicable'=>'', 'suffix'=>'%'},
            new Map<String,String> {'name'=>'Frequency__c', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Barrier_level__c', 'clicable'=>'', 'suffix'=>'%'},
            new Map<String,String> {'name'=>'Barrier_type__c', 'clicable'=>'', 'suffix'=>''},
            new Map<String,String> {'name'=>'Autocall_trigger__c', 'clicable'=>'', 'suffix'=>'%'},
            new Map<String,String> {'name'=>'Performance', 'clicable'=>'', 'suffix'=>'%'},
            new Map<String,String> {'name'=>'UploadPdf', 'clicable'=>'', 'suffix'=>''}
            };

    //[COM-50] Dmytro Lambru 11.10.18: Added "Product Subtype" label
    public static final List<String> LABELS_FOR_YIELD_ENHANCEMENT =
        new List<String>  { 'ISIN', 'Product Subtype', 'Maturity', 'Currency', 'Underlyings', 'Coupon', 'Observations', 'Barrier',
         'Barrier Type', 'Autocall trigger', 'Reference Level'};

    //[COM-83] Anna Makhovskaya 6/11/2018 added params for sorting AIS Product Page
    //[COM-95] Anna Makhovskaya 13/11/2018 added map for upload Pdf file on AIS Product Page
    public static final List<Map<String,String>>  LABELS_FOR_YIELD_ENHANCEMENT_SORT  =
    new List<Map<String,String>> {
            new Map<String, String> {'tableLabel'=>'ISIN', 'idColumn'=>'Name', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Product Subtype', 'idColumn'=>'Product_subtype__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Maturity', 'idColumn'=>'Maturity__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Currency', 'idColumn'=>'CurrencyIsoCode', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Underlyings', 'idColumn'=>'Underlyings', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Coupon', 'idColumn'=>'Coupon_p_a__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Observations', 'idColumn'=>'Frequency__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Barrier', 'idColumn'=>'Barrier_level__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Barrier Type', 'idColumn'=>'Barrier_type__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Autocall trigger', 'idColumn'=>'Autocall_trigger__c', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'Reference Level', 'idColumn'=>'Performance', 'isDescSort' => 'true'},
            new Map<String, String> {'tableLabel'=>'', 'idColumn'=>'UploadPdf', 'isDescSort' => 'true'}
     };

    public static final List<String> YIELD_ENHANCEMENT_RECORD_TYPES =
        new List<String>  {'Yield_Enhancement', 'Express_Certificate'};
        //Flag for record Types
        //Used in community(AIS PRoducts), When we will add new tab or edit tab, we need add/edit constant
    public static final String YIELD_ENHANCEMENT_FLAG = 'Yield Enhancement';
    public static final String PARTICIPATION_FLAG = 'Participation';
    public static final String CREDIT_FLAG = 'Credit';
    public static final String LEVERAGE_FLAG = 'Leverage';
    public static final String EXPRESS_CERTIFICATE_FLAG = 'Express Certificate';
    public static final String CAPITAL_PROTECTION_FLAG = 'Capital Protection';
    public static final String DUAL_CURRENCY_NOTE_FLAG = 'Dual Currency Note';
    public static final String OTHER_FLAG = 'Other';
    public static final String STABILITY_NOTE_FLAG = 'Stability Note';

    
    //Contact Record Type Name
    public static final String CONTACT_OF_AIS_RECORDTYPE_API_NAME = 'Contact_of_AIS';
    public static final String EMAIL_OPERATION_AIS = 'operations@aisfg.com';
    public static final String EMAIL_SETTINGS_QUALIFIED_API_NAME= 'SendBccCopy';
    public static final String TRADE_EMAIL_SETTINGS_QUALIFIED_API_NAME= 'SendCcCopy';
    public static final String SETTING_BCC_EMAIL_COPY_NAME= 'bccEmail';
    public static final String SETTING_CC_EMAIL_COPY_NAME= 'ccEmail';
    public static final Integer MAX_PDF_ATTACHMENT_SIZE_FOR_OBSERVATION_EMAIL= 3000000;


    //similar trade template placeholder
    public static final String HEADER_LOGO_PLACEHOLDER = '{!HeaderLogo}';
    public static final String HEADER_BACKGROUND_PLACEHOLDER = '{!HeaderBackgroundImg}';

    //Templates
    public static final String FACEBOOK_ADDRESS = 'https://www.facebook.com/AIS-Financial-Group-155230131537612';
    public static final String MAIL_TO_ADDRESS = 'mailto:info@ais.solutions';
    public static final String MAIL_TO_CONFIRMATION_ADDRESS = 'operations@aisfg.com';
    public static final String LINKEDIN_ADDRESS = 'https://www.linkedin.com/company/10563085/';
    public static final String GENEVA_OFFICE_PHONE = '+41 22 552 57 21';
    public static final String NASSAU_OFFICE_PHONE = '+1 242 362 6071';

    public static final String HEADER_BACKGROUND_IMG_API_NAME = 'Header Background Imeg';
    public static final String HEADER_LOGO_IMG_API_NAME = 'Header Logo Img';
    public static final String FACEBOOK_ICON_API_NAME = 'Facebook Icon';
    public static final String MAIL_ICON_API_NAME = 'Mail Icon';
    public static final String LINKEDIN_ICON_API_NAME = 'Linkedin Icon';


    public static final String TRADE_EMAIL_ISIN = 'ISIN';
    public static final String TRADE_EMAIL_SUBTYPE = 'subtypeType';
    public static final String TRADE_EMAIL_UNDERLYINGS = 'underlyings';
    public static final String TRADE_EMAIL_AMOUNT = 'amount';
    public static final String TRADE_EMAIL_CURRENCY = 'currency';
    public static final String TRADE_EMAIL_ISSUER_PRICE = 'isssuePrice';
    public static final String TRADE_EMAIL_ISSUER_DISTRIBUTION_FEES = 'distributionFees';
    public static final String TRADE_EMAIL_ISSUER = 'issuer';
    public static final String TRADE_EMAIL_STRIKE = 'strike';
    public static final String TRADE_EMAIL_PROTECIONLVL = 'protectionLevel';
    public static final String TRADE_EMAIL_PACTICIPATION = 'participation';
    public static final String TRADE_EMAIL_CAP = 'cap';
    public static final String TRADE_EMAIL_CREDIT_RISC = 'creditRisk';
    public static final String TRADE_EMAIL_TRADE_DATE = 'tradeDate';
    public static final String TRADE_EMAIL_INITIAL_FIXING_DATE = 'initialFixingDate';
    public static final String TRADE_EMAIL_INITIAL_ISSUE_DATE = 'initialIssueDate';
    public static final String TRADE_EMAIL_FINAL_FIXING_DATE = 'finalFixingDate';
    public static final String TRADE_EMAIL_REDEMPTION_DATE = 'redemptionDate';
    public static final String TRADE_EMAIL_SALES_NAME= 'salesName';
    public static final String TRADE_EMAIL_SALES_PHONE= 'salesPhone';
    public static final String TRADE_EMAIL_SALES_EMAIL= 'salesEmail';
    public static final String TRADE_EMAIL_COUPONPA = 'couponPA';
    public static final String TRADE_EMAIL_FREQUENCY = 'frequency';
    public static final String TRADE_EMAIL_COUPON_TRIGGER = 'сouponTrigger';
    public static final String TRADE_EMAIL_CALL_TYPE = 'сallType';
    public static final String TRADE_EMAIL_AUTOCALL_FREQUENCY = 'autocallFrequency';
    public static final String TRADE_EMAIL_AUTOCALL_TRIGGER = 'autocallTrigger';
    public static final String TRADE_EMAIL_BARRIER_TYPE = 'barrierType';
    public static final String TRADE_EMAIL_BARRIERLVL = 'barrierLevel';
    public static final String TRADE_EMAIL_SETTLEMENT_TYPE = 'settlementType';
    public static final String TRADE_EMAIL_RECOVERY_TYPE = 'recoveryType';
    public static final String TRADE_EMAIL_FLOATING_PART = 'floatingPart';
    public static final String TRADE_EMAIL_COUPON_TYPE_CLN = 'couponTypeCln';
    public static final String TRADE_EMAIL_COUPON_TYPE = 'couponType';
    public static final String TRADE_EMAIL_BONUS = 'bonus';
	public static final String TRADE_EMAIL_LEVERAGE = 'leverage';
	public static final String TRADE_EMAIL_SPREAD_COUPON = 'spreadCouponPA';
	public static final String TRADE_EMAIL_REFERENCE_RATE = 'referenceRate';
	public static final String TRADE_EMAIL_INITIAL_LEVERAGE = 'initialLeverage';
	public static final String TRADE_EMAIL_STOP_LOSS = 'stopLoss';


    //trade Email template
    public static final String LOGO_FOR_TRADE_TEMPLATE = 'LogoForTradeEmailTemplate';
    //Trade Current Number
    public static final Integer TRADE_CUSTOM_NUMBER_LIMIT = 600;
    public static final String CUSTOM_SETTING_NUMBER_PART = 'Number';
    //Trade Type Picklist
    public static final String TRADE_TYPE_PICKLIST_BUY = 'Buy';
	public static final String TRADE_TYPE_PICKLIST_SELL = 'Sell';
    //Trade Name
    public static final String TRADE_CODE_TRA = 'TRA';
    public static final String TRADE_CODE_EXT = 'EXT';
    //Trade AccomplishR Trade Step
    public static final String TRADE_ACCOMPLISHTRADESTEPS = 'AccomplishTradeSteps__c';

    public static final Map<String, Map<String,String>> DATE_FIELDS_FOR_TRADE_TEMPLATE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_TRADE_DATE => new Map<String,String> {'placeholder'=>'TradeDate', 'visiblePlaceholder'=>'TradeDateShow'},
        TRADE_EMAIL_INITIAL_FIXING_DATE => new Map<String,String> {'placeholder'=>'InitialFixingDate', 'visiblePlaceholder'=>'InitialFixingDateShow'},
        TRADE_EMAIL_INITIAL_ISSUE_DATE => new Map<String,String> {'placeholder'=>'InitialIssueDate', 'visiblePlaceholder'=>'InitialIssueDateShow'},
        TRADE_EMAIL_FINAL_FIXING_DATE => new Map<String,String> {'placeholder'=>'FinalFixingDate', 'visiblePlaceholder'=>'FinalFixingDateShow'},
        TRADE_EMAIL_REDEMPTION_DATE => new Map<String,String> {'placeholder'=>'RedemptionDate', 'visiblePlaceholder'=>'RedemptionDateShow'}
    };

    public static final Map<String, Map<String,String>> SALES_FIELDS_FOR_TRADE_TEMPLATE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_SALES_NAME => new Map<String,String> {'placeholder'=>'SalesName', 'visiblePlaceholder'=>'SalesNameShow'},
        TRADE_EMAIL_SALES_PHONE => new Map<String,String> {'placeholder'=>'SalesPhone', 'visiblePlaceholder'=>'SalesPhoneShow'},
        TRADE_EMAIL_SALES_EMAIL => new Map<String,String> {'placeholder'=>'SalesEmail', 'visiblePlaceholder'=>'SalesEmailShow'}
    };

    public static final Map<String, Map<String,String>> INFO_FIELDS_FOR_TRADE_TEMPLATE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_UNDERLYINGS =>new Map<String,String> {'placeholder'=>'Underlyings', 'visiblePlaceholder'=>'UnderlyingsShow'},
        TRADE_EMAIL_AMOUNT => new Map<String,String> {'placeholder'=>'Amount', 'visiblePlaceholder'=>'AmountShow'},
        TRADE_EMAIL_CURRENCY => new Map<String,String> {'placeholder'=>'Currency', 'visiblePlaceholder'=>'CurrencyShow'},
        TRADE_EMAIL_ISSUER_PRICE => new Map<String,String> {'placeholder'=>'IssuePrice', 'visiblePlaceholder'=>'IssuePriceShow'},
        TRADE_EMAIL_ISSUER_DISTRIBUTION_FEES => new Map<String,String> {'placeholder'=>'DistributionFees', 'visiblePlaceholder'=>'DistributionFeesShow'},
        TRADE_EMAIL_ISSUER => new Map<String,String> {'placeholder'=>'Issuer', 'visiblePlaceholder'=>'IssuerShow'}
    };

    public static final Map<String, Map<String,String>> FIELDS_FOR_CAPITALPROTECTION_TRADE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_SUBTYPE => new Map<String,String> {'placeholder'=>'ProductSubtype', 'visiblePlaceholder'=>'ProductSubtypeShow'},
        TRADE_EMAIL_ISIN => new Map<String,String> {'placeholder'=>'ISIN', 'visiblePlaceholder'=>'ISINShow'},
        TRADE_EMAIL_STRIKE => new Map<String,String> {'placeholder'=>'Strike', 'visiblePlaceholder'=>'StrikeShow'},
        TRADE_EMAIL_PROTECIONLVL => new Map<String,String> {'placeholder'=>'ProtectionLevel', 'visiblePlaceholder'=>'ProtectionLevelShow'},
        TRADE_EMAIL_PACTICIPATION => new Map<String,String> {'placeholder'=>'Participation', 'visiblePlaceholder'=>'ParticipationShow'},
        TRADE_EMAIL_CAP => new Map<String,String> {'placeholder'=>'Cap', 'visiblePlaceholder'=>'CapShow'},
        TRADE_EMAIL_CREDIT_RISC => new Map<String,String> {'placeholder'=>'CreditRisk', 'visiblePlaceholder'=>'CreditRiskShow'}
    };
    public static final String TEMPLATE_FOR_CAPITALPROTECTION_TRADE = 'Capital_Protection_Trade';

    public static final Map<String, Map<String,String>> FIELDS_FOR_DUALCURRENCYTNOTE_TRADE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_SUBTYPE => new Map<String,String> {'placeholder'=>'ProductSubtype', 'visiblePlaceholder'=>'ProductSubtypeShow'},
        TRADE_EMAIL_ISIN => new Map<String,String> {'placeholder'=>'ISIN', 'visiblePlaceholder'=>'ISINShow'},
        TRADE_EMAIL_STRIKE => new Map<String,String> {'placeholder'=>'Strike', 'visiblePlaceholder'=>'StrikeShow'},
        TRADE_EMAIL_COUPONPA => new Map<String,String> {'placeholder'=>'CouponPA', 'visiblePlaceholder'=>'CouponPAShow'}
    };
    public static final String TEMPLATE_FOR_DUALCURRENCYTNOTE_TRADE = 'Dual_Currency_Note_Trade';
    
    public static final Map<String, Map<String,String>> FIELDS_FOR_EXPRESSCERTIFICATE_TRADE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_SUBTYPE => new Map<String,String> {'placeholder'=>'ProductSubtype', 'visiblePlaceholder'=>'ProductSubtypeShow'},
        TRADE_EMAIL_ISIN => new Map<String,String> {'placeholder'=>'ISIN', 'visiblePlaceholder'=>'ISINShow'},
        TRADE_EMAIL_STRIKE => new Map<String,String> {'placeholder'=>'Strike', 'visiblePlaceholder'=>'StrikeShow'},
        TRADE_EMAIL_COUPONPA => new Map<String,String> {'placeholder'=>'CouponPA', 'visiblePlaceholder'=>'CouponPAShow'},
        TRADE_EMAIL_FREQUENCY => new Map<String,String> {'placeholder'=>'Frequency', 'visiblePlaceholder'=>'FrequencyShow'},
        TRADE_EMAIL_COUPON_TRIGGER => new Map<String,String> {'placeholder'=>'CouponTrigger', 'visiblePlaceholder'=>'CouponTriggerShow'},
        TRADE_EMAIL_CALL_TYPE => new Map<String,String> {'placeholder'=>'CallType', 'visiblePlaceholder'=>'CallTypeShow'},
        TRADE_EMAIL_AUTOCALL_FREQUENCY => new Map<String,String> {'placeholder'=>'AutocallFrequency', 'visiblePlaceholder'=>'AutocallFrequencyShow'},
        TRADE_EMAIL_AUTOCALL_TRIGGER => new Map<String,String> {'placeholder'=>'AutocallTrigger', 'visiblePlaceholder'=>'AutocallTriggerShow'},
        TRADE_EMAIL_BARRIER_TYPE => new Map<String,String> {'placeholder'=>'BarrierType', 'visiblePlaceholder'=>'BarrierTypeShow'},
        TRADE_EMAIL_BARRIERLVL => new Map<String,String> {'placeholder'=>'BarrierLevel', 'visiblePlaceholder'=>'BarrierLevelShow'}
    };
    public static final String TEMPLATE_FOR_EXPRESSCERTIFICATE_TRADE = 'Express_Certificate_Trade';

    public static final Map<String, Map<String,String>> FIELDS_FOR_PARTICIPATION_TRADE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_SUBTYPE => new Map<String,String> {'placeholder'=>'ProductSubtype', 'visiblePlaceholder'=>'ProductSubtypeShow'},
        TRADE_EMAIL_ISIN => new Map<String,String> {'placeholder'=>'ISIN', 'visiblePlaceholder'=>'ISINShow'},
        TRADE_EMAIL_STRIKE => new Map<String,String> {'placeholder'=>'Strike', 'visiblePlaceholder'=>'StrikeShow'},
        TRADE_EMAIL_PACTICIPATION => new Map<String,String> {'placeholder'=>'Participation', 'visiblePlaceholder'=>'ParticipationShow'},
        TRADE_EMAIL_CAP => new Map<String,String> {'placeholder'=>'Cap', 'visiblePlaceholder'=>'CapShow'},
        TRADE_EMAIL_BONUS => new Map<String,String> {'placeholder'=>'Bonus', 'visiblePlaceholder'=>'BonusShow'},
        TRADE_EMAIL_BARRIER_TYPE => new Map<String,String> {'placeholder'=>'BarrierType', 'visiblePlaceholder'=>'BarrierTypeShow'},
        TRADE_EMAIL_BARRIERLVL => new Map<String,String> {'placeholder'=>'BarrierLevel', 'visiblePlaceholder'=>'BarrierLevelShow'}
    };
    public static final String TEMPLATE_FOR_PARTICIPATION_TRADE = 'Participation_Trade';

    public static final Map<String, Map<String,String>> FIELDS_FOR_CREDIT_TRADE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_SUBTYPE => new Map<String,String> {'placeholder'=>'ProductSubtype', 'visiblePlaceholder'=>'ProductSubtypeShow'},
        TRADE_EMAIL_ISIN => new Map<String,String> {'placeholder'=>'ISIN', 'visiblePlaceholder'=>'ISINShow'},
        TRADE_EMAIL_COUPON_TYPE => new Map<String,String> {'placeholder'=>'CouponType', 'visiblePlaceholder'=>'CouponTypeShow'},
        TRADE_EMAIL_COUPON_TYPE_CLN => new Map<String,String> {'placeholder'=>'CouponTypeCln', 'visiblePlaceholder'=>'CouponTypeClnShow'},
        TRADE_EMAIL_FLOATING_PART => new Map<String,String> {'placeholder'=>'FloatingPart', 'visiblePlaceholder'=>'FloatingPartShow'},
        TRADE_EMAIL_COUPONPA => new Map<String,String> {'placeholder'=>'CouponPA', 'visiblePlaceholder'=>'CouponPAShow'},
        TRADE_EMAIL_FREQUENCY => new Map<String,String> {'placeholder'=>'Frequency', 'visiblePlaceholder'=>'FrequencyShow'},
        TRADE_EMAIL_RECOVERY_TYPE => new Map<String,String> {'placeholder'=>'RecoveryType', 'visiblePlaceholder'=>'RecoveryTypeShow'},
        TRADE_EMAIL_SETTLEMENT_TYPE => new Map<String,String> {'placeholder'=>'SettlementType', 'visiblePlaceholder'=>'SettlementTypeShow'}
    };
    public static final String TEMPLATE_FOR_CREDIT_TRADE = 'Credit_Trade';


    public static final Map<String, Map<String,String>> FIELDS_FOR_YIELD_ENHANCEMENT_TRADE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_SUBTYPE => new Map<String,String> {'placeholder'=>'ProductSubtype', 'visiblePlaceholder'=>'ProductSubtypeShow'},
        TRADE_EMAIL_ISIN => new Map<String,String> {'placeholder'=>'ISIN', 'visiblePlaceholder'=>'ISINShow'},
        TRADE_EMAIL_COUPONPA => new Map<String,String> {'placeholder'=>'CouponPA', 'visiblePlaceholder'=>'CouponPAShow'},
        TRADE_EMAIL_FREQUENCY => new Map<String,String> {'placeholder'=>'Frequency', 'visiblePlaceholder'=>'FrequencyShow'},
        TRADE_EMAIL_COUPON_TRIGGER => new Map<String,String> {'placeholder'=>'CouponTrigger', 'visiblePlaceholder'=>'CouponTriggerShow'},
        TRADE_EMAIL_BARRIER_TYPE => new Map<String,String> {'placeholder'=>'BarrierType', 'visiblePlaceholder'=>'BarrierTypeShow'},
        TRADE_EMAIL_BARRIERLVL => new Map<String,String> {'placeholder'=>'BarrierLevel', 'visiblePlaceholder'=>'BarrierLevelShow'}

    };
    public static final String TEMPLATE_FOR_YIELD_ENHANCEMENT_TRADE = 'Yield_Enhancement_Trade';


    public static final Map<String, Map<String,String>> FIELDS_FOR_OTHER_TRADE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_ISIN => new Map<String,String> {'placeholder'=>'ISIN', 'visiblePlaceholder'=>'ISINShow'}
    };

    public static final String TEMPLATE_FOR_OTHER_TRADE = 'Other_Trade';

	public static final Map<String, Map<String,String>> FIELDS_FOR_LEVERAGE_TRADE = new Map<String, Map<String,String>> {
		TRADE_EMAIL_ISIN => new Map<String,String> {'placeholder'=>'ISIN', 'visiblePlaceholder'=>'ISINShow'},
        TRADE_EMAIL_SUBTYPE => new Map<String,String> {'placeholder'=>'ProductSubtype', 'visiblePlaceholder'=>'ProductSubtypeShow'},
		TRADE_EMAIL_STRIKE => new Map<String,String> {'placeholder'=>'Strike', 'visiblePlaceholder'=>'StrikeShow'},
		TRADE_EMAIL_INITIAL_LEVERAGE => new Map<String,String> {'placeholder'=>'InitialLeverage', 'visiblePlaceholder'=>'InitialLeverageShow'},
		TRADE_EMAIL_STOP_LOSS => new Map<String,String> {'placeholder'=>'StopLoss', 'visiblePlaceholder'=>'StopLossShow'}
	};

	public static final String TEMPLATE_FOR_LEVERAGE_TRADE = 'Leverage_Trade';

    public static final Map<String, Map<String,String>> FIELDS_FOR_STABILITY_NOTE_TRADE = new Map<String, Map<String,String>> {
        TRADE_EMAIL_ISIN => new Map<String,String> {'placeholder'=>'ISIN', 'visiblePlaceholder'=>'ISINShow'},
        TRADE_EMAIL_SUBTYPE => new Map<String,String> {'placeholder'=>'ProductSubtype', 'visiblePlaceholder'=>'ProductSubtypeShow'},
        TRADE_EMAIL_STRIKE => new Map<String,String> {'placeholder'=>'Strike', 'visiblePlaceholder'=>'StrikeShow'},
        TRADE_EMAIL_LEVERAGE => new Map<String,String> {'placeholder'=>'Leverage', 'visiblePlaceholder'=>'LeverageShow'},
        TRADE_EMAIL_SPREAD_COUPON => new Map<String,String> {'placeholder'=>'SpreadCouponPA', 'visiblePlaceholder'=>'SpreadCouponPAShow'},
        TRADE_EMAIL_REFERENCE_RATE => new Map<String,String> {'placeholder'=>'ReferenceRate', 'visiblePlaceholder'=>'ReferenceRateShow'}
    };

    public static final String TEMPLATE_FOR_STABILITY_NOTE_TRADE = 'Stability_Note_Trade';

    // email attachment size
    public static final Long MAX_ATTACHMENT_SIZE = 250000; // size in byte - 18mb

    //observation email
    public static final String LOGO_FOR_OBSERVATION_TEMPLATE = 'LogoForObservationEmailTemplate';

    public static final String IMG_URL = 'ImgUrl';
    public static final String CURRENT_YEAR = 'CurrentYear';
    public static final String TRADE_CONFIRMATION_SUBJECT_PART = 'Trade done - ';
    public static final String TRADE_CONFIRMATION_UNDERLYING_SEPARATOR = ' / ';


    //Public Groups names
    public static final String PUBLIC_GROUP_SALES = 'Sales_Group';
    public static final String PUBLIC_GROUP_ADMIN = 'Admin_Group';

    //Role Names
    public static final String ROLE_NAME_SALES = 'Sales';
    public static final String ROLE_NAME_CEO = 'CEO';

    //Profiles Names
    public static final String PROFILE_NAME_SALES = 'Sales';
    public static final String PROFILE_NAME_ADMIN = 'System Administrator';
    public static final String PROFILE_NAME_ADMIN_READ_ONLY = 'Admin Read Only';
    public static final String PROFILE_NAME_COSTOMER_COMMUNITY_PLUS_USER = 'Customer Community Plus User';
    //Shares Object Access Levels
    public static final String SHARE_ACCESS_LEVEL_READ = 'Read';
    public static final String SHARE_ACCESS_LEVEL_EDIT = 'Edit';
    public static final String SHARE_ACCESS_LEVEL_DELETE = 'Delete';
    public static final String SHARE_ACCESS_LEVEL_CREATE = 'Create';
    public static final String SHARE_ACCESS_LEVEL_ALL = 'All';

	//Regular expressions
	public static final String REGEX_TRADE_NAME_YEAR = '^(2[0-9]{3})$';

    //TradeAccountAssignee Object
    public static final String TRADEACCOUNTASSIGNE_ACCONT_TYPE_INTRODUCER = 'Introducer';
    public static final String TRADEACCOUNTASSIGNE_ACCONT_TYPE_BROKER = 'Broker';
    public static final String TRADEACCOUNTASSIGNE_ACCONT_TYPE_CUSTODIAN = 'Custodian';


    //TradeAccountAssignee Error
    public static final String TRADEACCOUNTASSIGNE_ERROR_DUPLICATE_ACCOUNT = 'Duplicate Account! This account has already been added!';

    //Add Observation Form (INT 193 ascherbanyuk)
    //find contain string
    public static final String CONTAIN_STRING_SOFTCALL = 'softcall';
    public static final String CONTAIN_STRING_REVERSE_CONV_AUTOCALL = 'reverse convertible autocall';
    //Table lable
    //(Start INT 232 Aleksandr Shcherbanyuk)
    public static final String TABLE_LABLE_PRODUCTNAME = 'ISIN';
    public static final String TABLE_LABLE_SUBTYPE = 'Subtype';
    public static final String TABLE_LABLE_ISSUER = 'Issuer';
    public static final String TABLE_LABLE_INITIALFIXINGDATE = 'Initial Fixing Date';
    public static final String TABLE_LABLE_MATURITY_MONTHS = 'Maturity (Months)';
    public static final String TABLE_LABLE_CURRENCY_CODE = 'Currency Code';
	public static final String TABLE_LABLE_TRADE_CODE = 'Trade Code';
	public static final String TABLE_LABLE_CLIENT_NAME = 'Client Name';
	public static final String TABLE_LABLE_SIZE = 'Size';
	public static final String TABLE_LABLE_TRADES_SIZE = 'Trades Size';
	public static final String TABLE_LABLE_AIS_MARGIN = 'AIS Margin';
	public static final String TABLE_LABLE_CLIENT_MARGIN = 'Client Margin';
	public static final String TABLE_LABLE_NEXT_OBSERVATION = 'Next Observation';
    //Button name
    public static final String BTN_NAME_NAME = 'name';
    public static final String BTN_NAME_INITDATE = 'initDate';
    public static final String BTN_NAME_ISSUERNAME = 'issuerName';
    public static final String BTN_NAME_SUBTYPE = 'subtype';
    public static final String BTN_NAME_MATURITY_MONTHS = 'maturityMonth';
    public static final String BTN_NAME_CURRENCY_CODE = 'currencyCode';
    public static final String BTN_NAME_TRADE_CODE = 'tradeCode';
    public static final String BTN_NAME_CLIENT_NAME = 'clientName';
    public static final String BTN_NAME_SIZE = 'size';
    public static final String BTN_NAME_TRADES_SIZE = 'totalTradeSize';
    public static final String BTN_NAME_AIS_MARGIN = 'aisMargin';
    public static final String BTN_NAME_CLIENT_MARGIN = 'clientMargin';
    public static final String BTN_NAME_NEXT_OBSERVATION = 'nextObservation';

    public static final Map<String,String> MY_PRODUCTS_PAGE_SORT_MAP = new Map<String,String> {
    BTN_NAME_NAME => 'Name',
    BTN_NAME_SUBTYPE => 'Product_subtype__c',
    BTN_NAME_ISSUERNAME => 'Issuer__r.Name',
    BTN_NAME_INITDATE => 'Initial_Fixing_Date__c',
    BTN_NAME_MATURITY_MONTHS => 'Maturity__c',
    BTN_NAME_CURRENCY_CODE => 'Currency__c',
    BTN_NAME_NEXT_OBSERVATION => 'NextObservation__c'
    };

    //End (INT 232 Aleksandr Shcherbanyuk)
    //Input Label
    public static final String INPUT_LABEL_OBSERVATION_DATE = 'Observation Date:';
    public static final String INPUT_LABEL_PAYMENT_DATE = 'Payment Date:';
    public static final String INPUT_LABEL_AUTOCALL_TRIGGER = 'Autocall Trigger:';
    public static final String INPUT_LABEL_CALL_RATE = 'Call Rate:';
    public static final String INPUT_LABEL_CALLABILITY_PAYMENT_DATE = 'Callability Payment Date:';
    public static final String INPUT_LABEL_COUPON_PAYMENT_DATE = 'Coupon Payment Date:';
    public static final String INPUT_LABEL_COUPON_TRIGGER = 'Coupon Trigger:';
    public static final String INPUT_LABEL_COUPON = 'Coupon:';
    public static final String INPUT_LABEL_PAYMENT = 'Payment:';
    public static final String INPUT_LABEL_COUPON_IN_FINE = 'Coupon in Fine:';
    public static final String INPUT_LABEL_CAPITAL_PROTECTION_LEVEL = 'Capital Protection Level:';
    public static final String INPUT_LABEL_RECOVERY_TYPE = 'Recovery Type:';
    public static final String INPUT_LABEL_SETTLEMENT_TYPE = 'Settlement Type:';
    public static final String INPUT_LABEL_STRIKE = 'Strike:';
    public static final String INPUT_LABEL_BARRIER_TYPE = 'Barrier Type:';
    public static final String INPUT_LABEL_BARRIER_LEVEL = 'Barrier Level:';
    public static final String INPUT_LABEL_CALL_TYPE = 'Call Type:';
    public static final String INPUT_LABEL_NUMBER_RECORD = '#';
    public static final String INPUT_LABEL_COUPON_TYPE_CLN = 'Coupon Type cln:';
    public static final String INPUT_LABEL_OBSERVATION_FREQUENCY = 'Observation frequency:';
    public static final String INPUT_LABEL_COUPON_PA = 'Coupon p.a.:';
    public static final String INPUT_LABEL_COUPON_TYPE = 'Coupon Type:';
    public static final String INPUT_LABEL_COUPON_PER_OBSERVATION = 'Coupon Per Observation:';
    public static final String INPUT_LABEL_UNDERLYING = 'Underlying:';


    //Input Type
    public static final String INPUT_TYPE_DECIMAL = 'Decimal';
    public static final String INPUT_TYPE_DATE = 'Date';
    public static final String INPUT_TYPE_CHECKBOX = 'Checkbox';
    public static final String INPUT_TYPE_STRING = 'String';

    public static final String COUPON_TYPE_CLN_APINAME_FLOATING = 'FLO';

    public static final Map<String, String> PRODUCT_SETTLEMENT_TYPE_MAP = new Map<String,String> {
    'EUR' => 'European',
    'AME' => 'American'
    };

    public static final Map<String, String> PRODUCT_COUPON_TYPE_CLN_MAP = new Map<String,String> {
    'FIX' => 'Fix',
    'FLO' => 'Floating'
    };

    //Chater Notification
    public static final String NOTIFICATION_TITLE = 'title';
    public static final String NOTIFICATION_BODY_PART = 'bodyPart';
    public static final String MATURITY_NOTIFICATION_BODY_PART = '"</b> arrives into Maturity Today';
    public static final String CALLABILITY_NOTIFICATION_BODY_PART = '"</b> had a Softcall observation Today';
    public static final String MATURITY_NOTIFICATION_TITLE = ' Maturity Today';
    public static final String CALLABILITY_NOTIFICATION_TITLE = ' Callability Today';

    //INT-207/280/281 Aleksandr Shcherbanyuk 11/01/18 Start
    public static final String[] CUSTOM_NOTIFIER_TYPE = new String[]{
        'error', 'success', 'warning', 'info'
    };
    public static final String[] CUSTOM_NOTIFIER_TITLE = new String[]{
        'Trade Setup Not Finished'
    };
    public static final String[] CUSTOM_NOTIFIER_MESSAGE = new String[]{
        '‌You need to accomplish required steps before this Trade will be activated for usage.'
    };
    public static final String[] CUSTOM_NOTIFIER_BUTTONNAME = new String[]{
        'Review', 'Ok'
    };

    //Trade Object
    public static final Map<String, String> TRADE_ACCOMPLISH_TRADE_STEPS_APINAME = new Map<String, String> {
        'contacts' => 'Add Contacts', 'custodians' => 'Add Custodians', 'modify' => 'Modification', 'submitted' => 'Submitted', 'approved' => 'Approved'
    };
    //Error Trade Steps
    public static final String TRADE_STEPS_ERROR_EQUALS_SIZE_AND_SPLITS = 'Sum of all custodian’s notional splits must be equal size of the trade';
    public static final String TRADE_STEPS_ERROR_ADD_CONTACT = 'Verification failed. At least one Observation contact should be added.';
    //TradeContactAssignee__c
    public static final String[] TRADECONTACTASSIGNEE_RELATED_TO_API_NAME = new String[]{'Confirmation', 'Observation'};
    //Trade Approvel Process
    public static final String TRADE_APPROVAL_COMMENT = 'New request for Trade Approve.';
    public static final String TRADE_APPROVAL_PROCCESS_UNIQUE_NAME = 'Trade_Approval_Process';
    //ProcessInstance Object
    public static final String PROCESS_INSTANCE_STATUS_PENDING = 'Pending';
    public static final String PROCESS_INSTANCE_STATUS_APPROVED = 'Approved';
    public static final String PROCESS_INSTANCE_STATUS_REJECTED = 'Rejected';
    public static final String APPROVAL_PROCESS_ERROR = 'Approval process error, contact the Administrator';
    public static final String APPROVAL_ERROR_APPROVAL_EXIST = 'This record is currently in an approval process. A record can be in only one approval process at a time.';


    //INT-207/280/281 Aleksandr Shcherbanyuk 11/01/18 End

    //COM-97 Anna Makhovskaya
    public static final String ROWCAUSE_FOR_TRADE_CLIENT_CONTACT = 'RelatedClientContactToTradeForCommunity__c';
    public static final String ROWCAUSE_FOR_TRADE_INTRODUCER_CONTACT = 'RelatedIntrodContactToTradeForCommunity__c';
    public static final String ROWCAUSE_FOR_TRADE_OBSERVATION_CONTACT = 'SelectedForCommunity__c';

    public static final String SUCCESS_COLOR_THEME = 'slds-theme--success';
    public static final String ERROR_COLOR_THEME = 'slds-theme--error';

    // Delimiter for SpecificOrganizations reg exp
    public static final String METADATA_DELIMITER_REG_EXP = '\\|';

}