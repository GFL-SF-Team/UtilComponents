public with sharing class DataAccessor {
	public static final String PROFILE_NAME_COSTOMER_COMMUNITY_PLUS_USER = 'Customer Community Plus User';

	/*
     * @description: Get information on the user
     * @parameter:
	 * 	userId [String] - user id
    */
	public static User getUserInfoById (Id userId) {

		return (User)DataAccessorHelper.getObjectItemFromOrg(
						'SELECT User.Id, User.FirstName, User.LastName, User.Profile.Name, User.UserRole.Name, User.Manager.Name ' +
						'FROM User, User.profile, User.UserRole '+
						'WHERE Id = \''+ String.escapeSingleQuotes(userId) + '\' ' +
						'LIMIT 1'
		);
	}


	/*
     * @description: Returns the user associated with the contact
     * @parameter:
	 * 	contactId [String] - contact id
	 */
	public static User getUserByContactId(Id contactId){

		return (User)DataAccessorHelper.getObjectItemFromOrg(
						'SELECT Id ' +
						'FROM User ' +
						'WHERE ContactId  = \''+ String.escapeSingleQuotes(contactId) +'\' ' +
						'LIMIT 1'
		);
	}

	/*
     * @description: Returns the user associated with the account (contact account)
     * @parameter:
	 * 	userId [Id] - user id
	 */
	public static User getAccountForContactCommunity(Id userId) {

		return (User)DataAccessorHelper.getObjectItemFromOrg(
						'SELECT AccountId ' +
						'FROM User ' +
						'WHERE Id = \''+ String.escapeSingleQuotes(userId) +'\' ' +
						'LIMIT 1'
		);
	}

	/*
	* @description: Get contact information by user
	* @parameter:
	* 	userId [Id] - user id
	*/
	public static User getContactInfoByUserId(Id userId){

		return (User)DataAccessorHelper.getObjectItemFromOrg(
						'SELECT ContactId, isActive '+
						'FROM User '+
						'WHERE Id = \''+String.escapeSingleQuotes(userId)+'\' '+
						'LIMIT 1'
		);
	}


	/*
     * @description: Get all direct and indirect contacts associated with account
     * @parameter:
	 * 	accountId [String] - account id
	 *
	 * PS: Make sure that you enabled Allow users to relate a contact to multiple company checkbox in Account Settings
    */
	public static List<AccountContactRelation> getAllContactsAssociatedWithAccount(String accountId){

		return DataAccessorHelper.getDataFromOrg('SELECT  ContactId ' +
				'FROM AccountContactRelation ' +
				'WHERE AccountId = \'' + String.escapeSingleQuotes(accountId) + '\' '+
				'LIMIT 50000');
	}


	/*
     * @description: Get information on account contacts
     * @parameter:
	 * 	userId [String] - account id
    */
	public static Map<Id, Contact> getContactsByAccounId(Id idAccount) {

		return new Map<Id, Contact>((List<Contact>) DataAccessorHelper.getDataFromOrg(
						'SELECT Id, Name, LastName, FirstName, Account.Name, AccountId ' +
						'FROM Contact ' +
						'WHERE AccountId = \''+ String.escapeSingleQuotes(idAccount) +'\' ' +
						'LIMIT 50000'
		));
	}

	/*
     * @description: Get the record type of account entry associated with the contact
     * @parameter:
	 * 	idAccount [Id] - account id
    */
	public static Contact getRecordTypeAccountByContactId(Id contactId) {

		return (Contact)DataAccessorHelper.getObjectItemFromOrg(
						'SELECT Account.RecordTypeId ' +
						'FROM Contact ' +
						'WHERE Id = \''+ String.escapeSingleQuotes(contactId) +'\'  '+
						'LIMIT 1'
		);
	}


	/*
	 * @description: Get list active community users associated with transmitted contacts
	 * @parameter:
	 * 	contactsIdsSet [Set<Id>] - set of contact's ids
	 * */
	public static List<User> contactsAvailableInCommunity(Set<Id> contactsIdsSet){

		if(!contactsIdsSet.isEmpty()) {
			Profile communProfile = DataAccessor.getProfileInfoByIdOrName(PROFILE_NAME_COSTOMER_COMMUNITY_PLUS_USER);

			String stringWithContactsIdSet = DataAccessorHelper.createStringListWithIdFromIdSet(contactsIdsSet);

			return DataAccessorHelper.getDataFromOrg('SELECT Id, ContactId '+
					'FROM User '+
					'WHERE ContactId IN '+ stringWithContactsIdSet +' AND IsActive = true AND ProfileId = \''+ String.escapeSingleQuotes(communProfile.Id) +'\'  '+
					'LIMIT 50000');
		}else {
			return new List<User>();
		}
	}


	/*
	 * @description: Get profile information
	 * @parameter:
	 * 	profileNameOrId [String] - name or id  profile
	 * */
	public static Profile getProfileInfoByIdOrName(String profileNameOrId) {

		return (Profile)DataAccessorHelper.getObjectItemFromOrg(
						'SELECT Id, Name ' +
						'FROM Profile ' +
						'WHERE Name = \'' + String.escapeSingleQuotes(profileNameOrId) + '\' OR Id = \'' + String.escapeSingleQuotes(profileNameOrId) +
						'LIMIT 1'
		);
	}

	//********************************************* Work with Document ***************************************************//
	/**/
	public static ContentDocumentLink getContentDocumentIdPdf(Id recordId){

		return (ContentDocumentLink)DataAccessorHelper.getObjectItemFromOrg(
						'SELECT ContentDocumentId '+
						'FROM ContentDocumentLink '+
						'WHERE LinkedEntityId=\''+String.escapeSingleQuotes(recordId)+'\' AND ContentDocument.FileType=\'PDF\' AND Visibility = \'AllUsers\' '+
						'LIMIT 1');

	}

	/**/
	public static List<ContentVersion> getFileExtensionsFromContentVersion(Set<Id> contentDocumentIdList){

		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromIdSet(contentDocumentIdList);

		return DataAccessorHelper.getDataFromOrg(
						'SELECT ContentDocumentId, FileExtension '+
						'FROM ContentVersion '+
						'WHERE ContentDocumentId IN ' + stringWithIdList +
						' LIMIT 50000'
		);
	}

	/**/
	public static List<ContentDocumentLink> getContentDocumentLinkByListId(Set<Id> recordIdList) {

		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromIdSet(recordIdList);

		return DataAccessorHelper.getDataFromOrg(
						'SELECT Id, Visibility, ShareType '+
						'FROM ContentDocumentLink '+
						'WHERE Id IN ' + stringWithIdList +
						' LIMIT 50000'
		);
	}

	//********************************************* Work with Log ***************************************************//
	/*
	 * @description: Get information about logs by conditions
	 * @parameters:
	 * 	typeLog [String] - type og log (INFO, ERROR, BATCH)
	 * 	status [String] - problem solving state (New, Watching, Resolved)
	 * 	priority [String] - problem priority (Low, Medium,  High)
	 * 	timeLine [String] - How long are logs interested in? (Today, Week, Month)
	 * 	startDateVal [DateTime] - start log period
	 * 	stopDateVal [DateTime] - end log period
	 * */
	public static List<Solutions_Log__c> getSolutionLogs(String typeLog, String status, String priority, String timeLine, DateTime startDateVal, DateTime stopDateVal){

		String query = 'SELECT Classes__c, Comment__c, Line__c, Message__c, Method__c, Priority__c, Status__c, Type__c, CreatedDate, Body__c  '+
				'FROM Solutions_Log__c '+
				'WHERE Type__c = \''+String.escapeSingleQuotes(typeLog)+'\' ';

		if(status != '') {
			query += ' AND Status__c = \''+String.escapeSingleQuotes(status)+'\' ';
		}

		if(priority != '') {
			query += ' AND Priority__c = \''+String.escapeSingleQuotes(priority)+'\' ';
		}

		if(timeLine == 'Today') {
			query += ' AND CreatedDate = TODAY ';
		}else if(timeLine == 'Week'){
			query += ' AND CreatedDate >= LAST_WEEK ';
		}else if(timeLine == 'Month'){
			query += ' AND CreatedDate >= LAST_MONTH ';
		}

		if(startDateVal != null && stopDateVal != null){
			query += ' AND CreatedDate >= '+startDateVal.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'')+
					' AND CreatedDate <= '+stopDateVal.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'')+' ';
		}

		query += 'ORDER BY CreatedDate DESC LIMIT 50000';

		return  DataAccessorHelper.getDataFromOrg(query);
	}


	/*
	 * @description: Get information about log item
	 @parameter:
	 * 	logId [Id] - log id
	 * */
	public static Solutions_Log__c getLogItem(Id logId){

		return (Solutions_Log__c)DataAccessorHelper.getObjectItemFromOrg(
						'SELECT  Classes__c, Comment__c, Line__c, Message__c, Method__c, Priority__c, Status__c, Type__c, CreatedDate, Body__c '+
						'FROM Solutions_Log__c '+
						'WHERE Id = \''+String.escapeSingleQuotes(logId)+'\' '+
						'LIMIT 1');
	}



	//********************************************* Work with Share (examples)***************************************************//
	/*
	 public static List<Trade__Share>  getTradeShareByUsersAndRowCause(List<Id> userIdList, List<String> rowCauseList){
		String stringWithIdUserList =  DataAccessorHelper.createStringListWithIdFromIdSet( new Set<Id>(userIdList));
		String stringWithIdRowCauseList = DataAccessorHelper.createStringListWithNameFromListName(rowCauseList);
		return DataAccessorHelper.getDataFromOrg(
						'SELECT Id, RowCause, ParentId, UserOrGroupId '+
								'FROM Trade__Share '+
								'WHERE UserOrGroupId IN ' + stringWithIdUserList + ' AND RowCause IN '+ stringWithIdRowCauseList +
								' LIMIT 50000');
	}
	*/

	/*
	 * @description: return list tradeShareRecord for observation contact associated with trade and users
	 * @parameters:
	 * 	userIds [List<Id>]- list of user's ids
	 * 	tradeId [Id]- trade Id
	 * */
	/*
	 * public static Trade__Share[] getTradeShareByParentIdAndUserContactIds(Id tradeId,  List<Id> userIds) {

		if(!userIds.isEmpty()) {
			String stringWithUserIdList = DataAccessorHelper.createStringListWithIdFromIdSet(userIds);

			return DataAccessorHelper.getDataFromOrg('SELECT Id, UserOrGroupId, ParentId ' +
					'FROM Trade__Share ' +
					'WHERE ParentId = \'' + String.escapeSingleQuotes(tradeId) + '\'   AND UserOrGroupId  IN  ' + stringWithUserIdList + ' AND  RowCause =' + '\'' +Schema.Trade__Share.RowCause.SelectedForCommunity__c  + '\' ' +
					'LIMIT 50000');

		}else{
			return new List<Trade__Share>();
		}
	}
	*/

	/*
	public static Trade__Share[] getObservationTradeShareByTradeIdsAndUserIds(Set<Id> tradeIds, Set<Id> userIds) {
		String stringWithIdList = DataAccessorHelper.createStringListWithIdFromIdSet(tradeIds);
		String stringOwnerIds = DataAccessorHelper.createStringListWithIdFromIdSet(userIds);
		return DataAccessorHelper.getDataFromOrg(
				'SELECT Id FROM Trade__Share WHERE ParentId IN ' + stringWithIdList + ' ' +
						'AND UserOrGroupId IN ' + stringOwnerIds + 'AND  RowCause =' + '\'' +Schema.Trade__Share.RowCause.SelectedForCommunity__c  + '\' ' +
						'LIMIT 50000'
		);

	}
*/
}