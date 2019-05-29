/* @name: Util_LookupController
 * @test: Util_LookupControllerTest
 * @author: Dmytro Lambru
 * @date: 22.05.19
 * @description: Controller for 'utilLookup' LWC
 */
public with sharing class Util_LookupController {
    private static LightningResult result = new LightningResult();

	@AuraEnabled(cacheable=true)
	public static LightningResult lookup(String stringToSearch) {

		if (false) {
			return result.setError(401);
		}

		return result.setResult( JSON.serialize(true) );
	}
}
