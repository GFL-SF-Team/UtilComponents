public with sharing class Util_D_RecordInfo {
    
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
