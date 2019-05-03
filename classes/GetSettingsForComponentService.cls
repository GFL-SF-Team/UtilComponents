public with sharing class GetSettingsForComponentService {

    public static RelatedObjectWrapper relatedObjectWrapper = new RelatedObjectWrapper();
    public static SearchObjectWrapper searchObjectWrapper = new SearchObjectWrapper();
    public static FieldsForShowWrapper fieldsForShowWrapper = new FieldsForShowWrapper();
    public static FieldsForEditWrapper fieldsForEditWrapper = new FieldsForEditWrapper();

    public static List<Map<String,String>> getRelatedObjectSettingsAviliableToEdit(String objectName){

        List<Map<String,String>> fieldsParams = new List<Map<String,String>>();
        StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'SettingsForEditRelatedObject' LIMIT 1];
        String settingsForComponent = sr.Body.toString();

        Dom.Document XMLSettings = new Dom.Document();
        XMLSettings.load(settingsForComponent);

        Dom.XMLNode rootElement = XMLSettings.getRootElement();
        List<Dom.XMLNode> childElementList = rootElement.getChildElements();

        for(Dom.XMLNode childObject : childElementList){
            if(childObject.getAttributeValue('name',null) == objectName){
                for(Dom.XMLNode relatedObject : childObject.getChildElements()){
                    Map<String,String> params = new Map<String,String>();
                    params.put('name',relatedObject.getAttributeValue('name',null));
                    params.put('label',relatedObject.getAttributeValue('label',null));
                    fieldsParams.add(params);
                }
            }
        }
        return fieldsParams;
    }

    public static Map<String,Object> initSettingsForComponent(String objectName, String relatedObjectName){
        StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'SettingsForEditRelatedObject' LIMIT 1];
        String settingsForComponent = sr.Body.toString();

        Dom.Document XMLSettings = new Dom.Document();
        XMLSettings.load(settingsForComponent);

        Dom.XMLNode rootElement = XMLSettings.getRootElement();
        List<Dom.XMLNode> childElementList = rootElement.getChildElements();

        for(Dom.XMLNode childObject : childElementList){
            if(childObject.getAttributeValue('name',null) == objectName){
                for(Dom.XMLNode settings : childObject.getChildElements()){
                    if(settings.getAttributeValue('name',null) == relatedObjectName){

                        Dom.XmlNode relatedObjectSettings = settings.getChildElement('relatedObjectSetting', null);
                        Dom.XmlNode searchObjectSetting = settings.getChildElement('searchObjectSetting', null);
                        Dom.XmlNode fieldsForShowSetting = settings.getChildElement('fieldsForShowSetting', null);
                        Dom.XmlNode fieldsForEditSetting = settings.getChildElement('fieldsForEditSetting', null);

                        for(Dom.XmlNode fieldInRelatedObject : relatedObjectSettings.getChildElement('fieldsInRelatedObject', null).getChildElements()){
                            relatedObjectWrapper.fieldsInRelatedObject.add(fieldInRelatedObject.getText());
                        }
                        relatedObjectWrapper.relatedObject = relatedObjectSettings.getChildElement('relatedObject', null)
                                .getChildElement('field', null).getText();
                        relatedObjectWrapper.junctionObject = relatedObjectSettings.getChildElement('junctionObject', null)
                                .getChildElement('field', null).getText();
                        String checkDuplicateStringValue = relatedObjectSettings.getChildElement('checkDuplicate', null)
                                .getChildElement('field', null).getText();
                        relatedObjectWrapper.checkDuplicate = Boolean.valueOf(checkDuplicateStringValue);
                        for(Dom.XmlNode fieldInJunctionObject : relatedObjectSettings.getChildElement('junctionObjectField', null).getChildElements()){
                            relatedObjectWrapper.junctionObjectField.add(fieldInJunctionObject.getText());
                        }
                        for(Dom.XmlNode filterFieldsInJunctionObject : relatedObjectSettings.getChildElement('showResultFilter', null).getChildElements()){
                            if(relatedObjectWrapper.filterFields.get(filterFieldsInJunctionObject.getAttribute('name', null)) == null){
                                relatedObjectWrapper.filterFields.put(filterFieldsInJunctionObject.getAttribute(
                                        'name',null),new List<String> {filterFieldsInJunctionObject.getText()});
                            }else{
                                relatedObjectWrapper.filterFields.get(filterFieldsInJunctionObject.getAttribute('name', null)).add(filterFieldsInJunctionObject.getText());
                            }
                        }
                        relatedObjectWrapper.fieldRelatedToCurrentObject = relatedObjectSettings.getChildElement('fieldRelatedToCurrentObject', null)
                                .getChildElement('field', null).getText();
                        relatedObjectWrapper.fieldRelatedToRelatedObject = relatedObjectSettings.getChildElement('fieldRelatedToRelatedObject', null)
                                .getChildElement('field', null).getText();
                        relatedObjectWrapper.componentLabel = relatedObjectSettings.getChildElement('componentLabel', null)
                                .getChildElement('field', null).getText();

                        if(relatedObjectSettings.getChildElement('additionalFields', null) != null){

                            for(Dom.XmlNode additionalField : relatedObjectSettings.getChildElement('additionalFields', null).getChildElements()){
                                if(additionalField != null){
                                    relatedObjectWrapper.additionalFields.put(additionalField.getAttribute('name', null),additionalField.getText());
                                }
                            }

                        }

                        for(Dom.XmlNode fieldForSearch : searchObjectSetting.getChildElement('fieldsForSearch', null).getChildElements()){
                            searchObjectWrapper.fieldsForSearch.add(fieldForSearch.getText());
                        }

                        for(Dom.XmlNode relatedFilterField : searchObjectSetting.getChildElement('relatedFilter', null).getChildElements()){
                             
                            if(relatedFilterField.getText() != ''){
                                searchObjectWrapper.relatedFilter.add(relatedFilterField.getText());
                            }
                        }

                        for(Dom.XmlNode fieldForShow : searchObjectSetting.getChildElement('showResult', null).getChildElements()){
                            searchObjectWrapper.showResult.add(fieldForShow.getText());
                        }
                        searchObjectWrapper.prefix = searchObjectSetting.getChildElement('prefix', null)
                                .getChildElement('field', null).getText();
                        searchObjectWrapper.objectName = searchObjectSetting.getChildElement('objectName', null)
                                .getChildElement('field', null).getText();
                        searchObjectWrapper.showFindLimit = Integer.valueof(searchObjectSetting.getChildElement('showFindLimit', null)
                                .getChildElement('field', null).getText());

                        for(Dom.XmlNode fildForShow : fieldsForShowSetting.getChildElements()){
                            String fieldName;
                            Map<String, String> fieldsParam = new Map<String, String>();
                            for(Dom.XmlNode fieldParam : fildForShow.getChildElements()){
                                fieldsParam.put(fieldParam.getAttributeValue('name',null),fieldParam.getText());
                                if(fieldParam.getAttributeValue('name',null) == 'name'){
                                    fieldName = fieldParam.getText();
                                    fieldsForShowWrapper.fields.add(fieldName);
                                }
                            }
                            fieldsForShowWrapper.fieldsForShow.put(fieldName,fieldsParam);
                        }

                        for(Dom.XmlNode fieldForEdit : fieldsForEditSetting.getChildElements()){
                            fieldsForEditWrapper.fieldsForEdit.add(fieldForEdit.getText());
                        }

                    }
                }
            }
        }

        Map<String,Object> resultMap = new Map<String,Object>();
        resultMap.put('relatedObjectWrapper',relatedObjectWrapper);
        resultMap.put('searchObjectWrapper',searchObjectWrapper);
        resultMap.put('fieldsForShowWrapper',fieldsForShowWrapper);
        resultMap.put('fieldsForEditWrapper',fieldsForEditWrapper);
        return resultMap;
    }

    public class RelatedObjectWrapper {
        public List<String> fieldsInRelatedObject = new List<String>();
        public String relatedObject;
        public String junctionObject;
        public List<String> junctionObjectField = new List<String>();
        public Map<String, List<String>> filterFields = new Map<String, List<String>>();
        public String fieldRelatedToCurrentObject;
        public String fieldRelatedToRelatedObject;
        public String componentLabel;
        public Map<String,String> additionalFields = new Map<String,String>();
        public Boolean checkDuplicate;
    }

    public class SearchObjectWrapper {
        public List<String> fieldsForSearch = new List<String>();
        public List<String> showResult = new List<String>();
        public List<String> relatedFilter = new List<String>();
        public String objectName;
        public String prefix;
        public Integer showFindLimit;
    }

    public class FieldsForEditWrapper {
        public List<String> fieldsForEdit = new List<String>();
    }

    public class FieldsForShowWrapper {
        public Map<String, Map<String, String>> fieldsForShow = new Map<String, Map<String, String>>();
        public List<String> fields = new List<String>();
    }
}