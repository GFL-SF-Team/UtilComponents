/*
 * Test Class: Utils_PermissionCheckingServiceCtrlTest
 * @author: Dmytro Lambru
 * @ticket: INT-288
 * @date: 18.11.2018
 * @history: [INT-316] Dmytro Lambru 30.11.18 - changed keywords
 */
@IsTest
private class Utils_PermissionCheckingServiceCtrlTest {

	@IsTest
	static void testCheckProfiles() {
		String[] profileKeyWordList = new String[]{'readonly', 'admin'};
		LightningResult result = Utils_PermissionCheckingServiceCtrl.checkProfiles(profileKeyWordList);
		Map<String, Boolean> jsonResult = (Map<String, Boolean>)System.JSON.deserialize(result.data, Map<String, Boolean>.class);

		System.assertEquals(TRUE,
							result.success,
						'Success must be TRUE');

		System.assertEquals(TRUE,
							jsonResult.get('isAdmin'),
						'isAdmin must be TRUE');

		System.assertEquals(FALSE,
							jsonResult.get('isReadonly'),
						'isReadonly must be FALSE');
	}

	@IsTest
	static void testCheckProfiles_Error400() {
		String[] profileKeyWordList = new String[]{};

		LightningResult result = Utils_PermissionCheckingServiceCtrl.checkProfiles(profileKeyWordList);

		System.assertEquals(FALSE,
							result.success,
						'Success must be FALSE');

		System.assertEquals(400,
							result.code,
						'code must be 400');
	}
}