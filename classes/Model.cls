public class Model {
    public virtual class ListOption {
        @AuraEnabled public String label {get;set;}
		@AuraEnabled public String value {get;set;}
        @AuraEnabled public Boolean selected {get;set;}
        
        public ListOption(String label, String value, Boolean selected){
            this.label = label;
            this.value = value;
            this.selected = selected;
        }
    }

    public virtual class ProductRecordTypeWrapper{
        @AuraEnabled public String name {get;set;}
        @AuraEnabled public String apiName {get;set;}
        @AuraEnabled public String id {get;set;}

        @AuraEnabled public List<String> subTypes {get;set;}

        public ProductRecordTypeWrapper(String name, String apiName, String id, List<String> subTypes){
            this.name = name;
            this.apiName = name;
            this.id = id;
            this.subTypes = subTypes;
        }

    }

    public class PathStep {
        /* should be refactored to use stepName instead */

        @AuraEnabled public String pathName {get; set;}
        @AuraEnabled public String pathValue {get; set;}
        @AuraEnabled public Boolean isComplete {get; set;} {isComplete = false;}
        @AuraEnabled public Boolean isActive {get; set;} {isActive = false;}

        @AuraEnabled public String stepName {get; set;}
        @AuraEnabled public String stepValue {get; set;}
        @AuraEnabled public Integer stepIndex {get; set;}



        public PathStep(String pathName, String pathValue, Integer stepIndex) {
            this.pathName = pathName;
            this.pathValue = pathValue;
            this.stepIndex = stepIndex;
        }

    }

    public virtual class ApproveItemInfoWrapper {
        @AuraEnabled public Id processWorkItemId {get; set;}
        @AuraEnabled public Id approveItemId {get; set;}
        @AuraEnabled public String approveItemName {get; set;}
        @AuraEnabled public List<String> approversList {get; set;} { approversList = new List<String>(); }
        @AuraEnabled public String approversStr {get; set;}
        @AuraEnabled public Boolean accessToApproval {get; set;} {accessToApproval = false;}

        public ApproveItemInfoWrapper(Id processWorkItemId, Id approveItemId, String approveItemName){
            this.processWorkItemId = processWorkItemId;
            this.approveItemId = approveItemId;
            this.approveItemName = approveItemName;
        }
    }

    public virtual class UserInfoWrapper {
        @AuraEnabled public Id userId {get; set;}
        @AuraEnabled public String firstName {get; set;}
        @AuraEnabled public String lastName {get; set;}
        @AuraEnabled public String profileName {get; set;}
        @AuraEnabled public String userRoleName {get; set;} {userRoleName = null;}
        @AuraEnabled public String managerName {get; set;} {managerName = null;}
        @AuraEnabled public Boolean isAllRecordsVisible {get; set;} {isAllRecordsVisible = null;}


        public UserInfoWrapper (Id userId, String firstName, String lastName, String profileName){
            this.userId = userId;
            this.firstName = firstName;
            this.lastName = lastName;
            this.profileName = profileName;
        }
    }

    /*
     * @author: Dmytro Lambru
     * @ticket: [INT-373]
     * @date: 01.04.2019
     * @description: Description for the table column
     */
    public virtual class TableColumnInfo {
        public String fieldKey {get; set;}
        public String label {get; set;}
        public String suffix {get; set;}
        public Boolean isClickable {get; set;}

        public TableColumnInfo(String label, String fieldKey, String suffix, Boolean isClickable) {
            this.fieldKey = fieldKey;
            this.label = label;
            this.isClickable = isClickable;
            this.suffix = suffix;
        }
    }
}