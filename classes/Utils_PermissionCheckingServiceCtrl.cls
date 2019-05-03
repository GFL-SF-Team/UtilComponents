/* Class: Utils_PermissionCheckingServiceCtrl
 * Test Class: Utils_PermissionCheckingServiceCtrlTest
 * @author: Dmytro Lambru
 * @ticket: [INT-288]
 * @date: 17.11.2018
 * @description: Controller for 'Utils_PermissionCheckingService' Lightning component
 * @history: [INT-316] Dmytro Lambru 30.11.18 - Changed logic to check profile from list of profiles for each keyword.
 * 												Changed keyword 'sales' and 'administrator' on 'readonly' and 'admin'.
 * 												Added new keyword 'admin_readonly'.
 */
public without sharing class Utils_PermissionCheckingServiceCtrl {
	/* Do not change existing keywords! Only add new ones if necessary. Lower case only. */
	private static final Map<String, String[]> keyWordToProfileListApiNameMap = new Map<String, String[]> {
		'readonly' => new String[]{ Constants.PROFILE_NAME_SALES, Constants.PROFILE_NAME_ADMIN_READ_ONLY },
		'admin_readonly' => new String[]{ Constants.PROFILE_NAME_ADMIN_READ_ONLY },
		'admin' => new String[]{ Constants.PROFILE_NAME_ADMIN }
	};

	/*
	 * @description: Retrieving data for the chart - Map<Line name, points on the chart with timestamp and percent value>
	 * @test: Utils_PermissionCheckingServiceCtrlTest.testCheckProfiles(), .testCheckProfiles_Error400()
	 * @param: profileKeyWordList - list with keywords for 'keyWordToProfileApiNameMap'
	 * @return: LightningResult.data - JSON string with checked profiles by keyword from 'keyWordToProfileApiNameMap' e.g. {"isAdministrator": true,"isReadonly": false}
	 */
	@AuraEnabled
	public static LightningResult checkProfiles(String[] profileKeyWordList) {
		LightningResult result = new LightningResult();

		if (profileKeyWordList.isEmpty()) {
			return result.setError('ProfileList is empty!', 400);
		}

		Map<String, Boolean> profileToCheckResultMap = new Map<String, Boolean>();

		/* current user profile */
		Profile userProfile = DataAccessor.getProfileById(UserInfo.getProfileId())[0];

		/* check profiles */
		for (String profileKeyWord : profileKeyWordList) {
			String[] profileApiNameList = keyWordToProfileListApiNameMap.get(profileKeyWord);

			Boolean checkResult = FALSE;
			for (String profileApiName : profileApiNameList) {
				if (userProfile.Name == profileApiName) {
					checkResult = TRUE;
					break;
				}
			}

			/* add to keyword 'is' e.g. 'isAdministrator' or 'isReadonly' and put check result */
			String convertedString = Utills.firstCharacterToUppercase(profileKeyWord);
			profileToCheckResultMap.put('is' + convertedString, checkResult);
		}

		return result.setResult( JSON.serialize(profileToCheckResultMap) );
	}
}