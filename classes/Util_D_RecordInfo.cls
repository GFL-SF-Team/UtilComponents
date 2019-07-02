/* @name: Util_D_RecordInfo
 * @test: Util_LookupTest
 * @author: Dmytro Lambru
 * @date: 22.05.19
 * @description: Data class for 'Util_LookupController'
 */
public class Util_D_RecordInfo {
    
    public Id recordId;
    public SObject record;
    public FieldToShowInfo[] fieldToShowInfoList;

    public class FieldToShowInfo {

        public String fieldLabel;
        public String fieldName;
        public Object fieldValue;
        public Boolean isFieldLabelHidden;
    }
}
