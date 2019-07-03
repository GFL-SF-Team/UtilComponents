/* @name: Util_LookupTest
 * @author: Dmytro Lambru
 * @date: 02.07.19
 * @description: Test class for 'Util_LookupController'
 */
@IsTest
class Util_LookupTest {

    @TestSetup
    static void makeData() {
        Account[] accountList = new Account[]{};

        for (Integer i = 0; i < 10; i++) {
            Account account = new Account(
                Name = 'Account Name ' + i,
                Site = 'account.site'
            );

            accountList.add(account);
        }

        insert accountList;
    }

    @IsTest
    static void testLookup() {
        String stringToSearch = 'ac';
        String searchConfigJson = '{"objectName":"Account", "numberOfRecords":7, "fieldForQueryList":["Name","Phone","Type","Site"],"fieldForSearchList":["Name","Site"],"fieldForOrderList":["Name"],"fieldForFilterCriterionList": [{"fieldName":"Site", "condition":"=", "value":"account.site", "typeOfValue":"String"}],"fieldToShowList":[{"fieldName":"Name","isFieldLabelHidden":true},{"fieldLabel":"Phone number","fieldName":"Phone","isFieldLabelHidden":false},{"fieldName":"Name","isFieldLabelHidden":false}]}';

        LightningResult response = Util_LookupController.lookup(stringToSearch, searchConfigJson);

        System.assert(true, response.success);
        System.assertEquals(null, response.code);

        Util_D_RecordInfo[] recordInfoList = Util_D_RecordInfo.parse(response.data);

        System.assertEquals(7, recordInfoList.size(), 'Record count is not true');
    }    
}
