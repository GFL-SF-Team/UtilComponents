public inherited sharing class Util_LookupHelper {
    
    public static Util_D_RecordInfo[] searchRecords(String stringToSearch, Util_D_SearchConfig searchConfig) {
        String queryString = generateQueryString(stringToSearch, searchConfig);

        System.debug(queryString);
        
        SObject[] resultRecordList = Database.query(queryString);
        
        return processResultRecords(resultRecordList, searchConfig);
    }

    public static String generateQueryString(String stringToSearch, Util_D_SearchConfig searchConfig) {
		stringToSearch = String.escapeSingleQuotes(stringToSearch);

		String queryString = 'SELECT ';

		// add fields
		queryString += String.join(searchConfig.fieldForQueryList, ',') + ' ';

		// add target object
		queryString += 'FROM ' + searchConfig.objectName + ' ';

		// add WHERE
		queryString += 'WHERE ';
		queryString += generateWhereClauseWithFilterCriterion(searchConfig);
		queryString += generateWhereClauseWithLike(stringToSearch, searchConfig) + ' ';

		// add ORDER BY
		queryString += generateOrderByClause(searchConfig) + ' ';

        // add LIMIT
        queryString += 'LIMIT ' + searchConfig.numberOfRecords;

		return queryString;
	}

	public static String generateWhereClauseWithFilterCriterion(Util_D_SearchConfig searchConfig) {
		String whereClauseString = '';

		if (searchConfig.fieldForFilterCriterionList != null) {

			for (Util_D_SearchConfig.FieldForFilterCriterion fieldInfo : searchConfig.fieldForFilterCriterionList) {
				
				if (fieldInfo.typeOfValue == 'String') fieldInfo.value = '\'' + fieldInfo.value + '\'';

				whereClauseString += fieldInfo.fieldName + ' ' + fieldInfo.condition + ' ' + fieldInfo.value + ' ';
				whereClauseString += 'AND ';
			}
		}

		return whereClauseString;
	}

	public static String generateWhereClauseWithLike(String stringToSearch, Util_D_SearchConfig searchConfig) {
		String whereClauseString = '(';

		for (Integer i = 0, length = searchConfig.fieldForSearchList.size(); i < length; i++) {

			if (i != 0) whereClauseString += 'OR ';

			whereClauseString += searchConfig.fieldForSearchList[i] + ' LIKE \'%' + stringToSearch + '%\' ';
		}

    	whereClauseString += ')';

		return whereClauseString;
	}

	public static String generateOrderByClause(Util_D_SearchConfig searchConfig) {
	String orderByClauseString = '';

		if (
			searchConfig.fieldForOrderList != NULL
			&& !searchConfig.fieldForOrderList.isEmpty()
		) {
			orderByClauseString = 'ORDER BY ' + String.join(searchConfig.fieldForOrderList, ',');
		}

		return orderByClauseString;
	}

	public static Util_D_RecordInfo[] processResultRecords(SObject[] resultRecordList, Util_D_SearchConfig searchConfig) {
		Schema.DescribeSObjectResult objectDescribe = Schema.describeSObjects(new String[]{searchConfig.objectName})[0];
		Util_D_RecordInfo[] recordInfoList = new Util_D_RecordInfo[]{};

		for (SObject record : resultRecordList) {
			Util_D_RecordInfo recordInfo = new Util_D_RecordInfo();

			recordInfo.recordId = record.Id;
			recordInfo.record = record;
			recordInfo.fieldToShowInfoList = generateFieldsToShow(record, searchConfig, objectDescribe);

			// if the displayed fields for the user are empty due to access, there is no point in adding a 'recordInfo'
			if (!recordInfo.fieldToShowInfoList.isEmpty()) {
				recordInfoList.add(recordInfo);
			}
		}

		return recordInfoList;
	}

	public static Util_D_RecordInfo.FieldToShowInfo[] generateFieldsToShow(SObject record, Util_D_SearchConfig searchConfig, Schema.DescribeSObjectResult objectDescribe) {
		Util_D_RecordInfo.FieldToShowInfo[] fieldToShowInfoList = new Util_D_RecordInfo.FieldToShowInfo[]{};
			
		for (Util_D_SearchConfig.FieldToShow fieldToShow : searchConfig.fieldToShowList) {
			
			// if user has access to the field
			if (record.isSet(fieldToShow.fieldName)) {
				Util_D_RecordInfo.FieldToShowInfo fieldToShowInfo = new Util_D_RecordInfo.FieldToShowInfo();

				fieldToShowInfo.fieldLabel = getFieldLabel(record, fieldToShow, objectDescribe);
				fieldToShowInfo.fieldName = fieldToShow.fieldName;
				fieldToShowInfo.fieldValue = record.get(fieldToShow.fieldName);
				fieldToShowInfo.isFieldLabelHidden = fieldToShow.isFieldLabelHidden;
				
				fieldToShowInfoList.add(fieldToShowInfo);
			}
		}
			
		return fieldToShowInfoList;
	}
	
	public static String getFieldLabel(SObject record, Util_D_SearchConfig.FieldToShow fieldToShow, Schema.DescribeSObjectResult objectDescribe) {
		String fieldLabel;

		if (!fieldToShow.isFieldLabelHidden) {
			fieldLabel = fieldToShow.fieldLabel;

			if (fieldLabel == null) {
				// get label from SObject describe
				fieldLabel = Utils.getFieldLabelFormSObject(objectDescribe, fieldToShow.fieldName);
			}
		}

		return fieldLabel;
	}
}
