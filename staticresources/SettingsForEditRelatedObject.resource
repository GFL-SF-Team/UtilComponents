<objectSettingsForRelatedEditorComponent>
<script type="text/javascript" charset="utf-8" id="zm-extension"/>
<object name="Trade__c">
<relatedObject name="TradeAccountAssignee__c" label="Custodian Bank">
<relatedObjectSetting>
<fieldsInRelatedObject>
<field>Name</field>
<field>Id</field>
</fieldsInRelatedObject>
<relatedObject>
<field>Account__r</field>
</relatedObject>
<junctionObject>
<field>TradeAccountAssignee__c</field>
</junctionObject>
<junctionObjectField>
<field>Id</field>
<field>Notional_Split__c</field>
<field>Checked__c</field>
</junctionObjectField>
<fieldRelatedToCurrentObject>
<field>Trade__c</field>
</fieldRelatedToCurrentObject>
<fieldRelatedToRelatedObject>
<field>Account__c</field>
</fieldRelatedToRelatedObject>
<componentLabel>
<field>Custodian Bank</field>
</componentLabel>
<additionalFields>
<field name="Account_Type__c">Custodian</field>
</additionalFields>
<checkDuplicate>
<field>true</field>
</checkDuplicate>
<showResultFilter>
<field name="Account__r.RecordType.DeveloperName">Custodian</field>
</showResultFilter>
</relatedObjectSetting>
<searchObjectSetting>
<fieldsForSearch>
<field>Name</field>
</fieldsForSearch>
<showResult>
<field>Name</field>
</showResult>
<objectName>
<field>Account</field>
</objectName>
<showFindLimit>
<field>4</field>
</showFindLimit>
<prefix>
<field/>
</prefix>
<relatedFilter>
<field name="RecordTypeName">Custodian</field>
</relatedFilter>
</searchObjectSetting>
<fieldsForShowSetting>
<field>
<field name="name">Name</field>
<field name="type">String</field>
<field name="label">Custodian Bank</field>
<field name="format">text</field>
<field name="relatedObject">Account__r</field>
<field name="show">show</field>
</field>
<field>
<field name="name">Notional_Split__c</field>
<field name="type">Decimal</field>
<field name="label">Notional Split</field>
<field name="format">###,##0</field>
<field name="relatedObject"/>
<field name="show">show</field>
</field>
<field>
<field name="name">Checked__c</field>
<field name="type">Checkbox</field>
<field name="label">Order Confirmed</field>
<field name="format"/>
<field name="relatedObject"/>
<field name="show">show</field>
</field>
<field>
<field name="name">Id</field>
<field name="type">String</field>
<field name="label">relatedObjectId</field>
<field name="format">text</field>
<field name="relatedObject">Account__r</field>
<field name="show"/>
</field>
</fieldsForShowSetting>
<fieldsForEditSetting>
<field>Notional_Split__c</field>
<field>Checked__c</field>
</fieldsForEditSetting>
</relatedObject>
</object>
<object name="Price_Request__c">
<relatedObject name="PriceRequestIssuerAssignee__c" label="Add issuer">
<relatedObjectSetting>
<fieldsInRelatedObject>
<field>Name</field>
<field>Id</field>
</fieldsInRelatedObject>
<relatedObject>
<field>Account__r</field>
</relatedObject>
<junctionObject>
<field>PriceRequestIssuerAssignee__c</field>
</junctionObject>
<junctionObjectField>
<field>Id</field>
</junctionObjectField>
<fieldRelatedToCurrentObject>
<field>Price_Request__c</field>
</fieldRelatedToCurrentObject>
<fieldRelatedToRelatedObject>
<field>Account__c</field>
</fieldRelatedToRelatedObject>
<componentLabel>
<field>Add issuers</field>
</componentLabel>
<checkDuplicate>
<field>true</field>
</checkDuplicate>
<showResultFilter>
<field name="Account__r.RecordType.DeveloperName">Issuer</field>
</showResultFilter>
</relatedObjectSetting>
<searchObjectSetting>
<fieldsForSearch>
<field>Name</field>
</fieldsForSearch>
<showResult>
<field>Name</field>
</showResult>
<objectName>
<field>Account</field>
</objectName>
<showFindLimit>
<field>4</field>
</showFindLimit>
<prefix>
<field/>
</prefix>
<relatedFilter>
<field name="RecordTypeName">Issuer</field>
</relatedFilter>
</searchObjectSetting>
<fieldsForShowSetting>
<field>
<field name="name">Name</field>
<field name="type">String</field>
<field name="label">Issuer</field>
<field name="format">text</field>
<field name="relatedObject">Account__r</field>
<field name="show">show</field>
</field>
<field>
<field name="name">Id</field>
<field name="type">String</field>
<field name="label">relatedObjectId</field>
<field name="format">text</field>
<field name="relatedObject">Account__r</field>
<field name="show"/>
</field>
</fieldsForShowSetting>
<fieldsForEditSetting> </fieldsForEditSetting>
</relatedObject>
<relatedObject name="PriceRequestUnderlyingAssignee__c" label="Add Underlying">
<relatedObjectSetting>
<fieldsInRelatedObject>
<field>Name__c</field>
<field>Spot__c</field>
<field>Name</field>
<field>Type__c</field>
<field>Id</field>
</fieldsInRelatedObject>
<relatedObject>
<field>Underlying__r</field>
</relatedObject>
<junctionObject>
<field>PriceRequestUnderlyingAssignee__c</field>
</junctionObject>
<junctionObjectField>
<field>Id</field>
</junctionObjectField>
<fieldRelatedToCurrentObject>
<field>Price_Request__c</field>
</fieldRelatedToCurrentObject>
<fieldRelatedToRelatedObject>
<field>Underlying__c</field>
</fieldRelatedToRelatedObject>
<componentLabel>
<field>Add Underlying</field>
</componentLabel>
<checkDuplicate>
<field>true</field>
</checkDuplicate>
<showResultFilter>
<field name=""/>
</showResultFilter>
</relatedObjectSetting>
<searchObjectSetting>
<fieldsForSearch>
<field>Name</field>
<field>Name__c</field>
</fieldsForSearch>
<showResult>
<field>Name__c</field>
<field>Name</field>
</showResult>
<objectName>
<field>Underlying__c</field>
</objectName>
<showFindLimit>
<field>4</field>
</showFindLimit>
<prefix>
<field>CODE:</field>
</prefix>
<relatedFilter>
<field name="RecordTypeName"/>
</relatedFilter>
</searchObjectSetting>
<fieldsForShowSetting>
<field>
<field name="name">Name__c</field>
<field name="type">String</field>
<field name="label">Underlying</field>
<field name="format">text</field>
<field name="relatedObject">Underlying__r</field>
<field name="show">show</field>
</field>
<field>
<field name="name">Spot__c</field>
<field name="type">Decimal</field>
<field name="label">Spot</field>
<field name="format">0.00</field>
<field name="relatedObject">Underlying__r</field>
<field name="show">show</field>
</field>
<field>
<field name="name">Name</field>
<field name="type">String</field>
<field name="label">Currency Code</field>
<field name="format">text</field>
<field name="relatedObject">Underlying__r</field>
<field name="show">show</field>
</field>
<field>
<field name="name">Type__c</field>
<field name="type">String</field>
<field name="label">Type</field>
<field name="format">text</field>
<field name="relatedObject">Underlying__r</field>
<field name="show">show</field>
</field>
<field>
<field name="name">Id</field>
<field name="type">String</field>
<field name="label">relatedObjectId</field>
<field name="format">text</field>
<field name="relatedObject">Underlying__r</field>
<field name="show"/>
</field>
</fieldsForShowSetting>
<fieldsForEditSetting> </fieldsForEditSetting>
</relatedObject>
</object>
<object name="Product2">
<relatedObject name="ProductUnderlyingAssignee__c" label="Underlying">
<relatedObjectSetting>
<fieldsInRelatedObject>
<field>Spot__c</field>
<field>Name__c</field>
</fieldsInRelatedObject>
<relatedObject>
<field>Underlying__r</field>
</relatedObject>
<junctionObject>
<field>ProductUnderlyingAssignee__c</field>
</junctionObject>
<junctionObjectField>
<field>Id</field>
<field>Strike__c</field>
<field>Performance__c</field>
</junctionObjectField>
<fieldRelatedToCurrentObject>
<field>Product__c</field>
</fieldRelatedToCurrentObject>
<fieldRelatedToRelatedObject>
<field>Underlying__c</field>
</fieldRelatedToRelatedObject>
<componentLabel>
<field>Underlying</field>
</componentLabel>
<checkDuplicate>
<field>true</field>
</checkDuplicate>
</relatedObjectSetting>
<searchObjectSetting>
<fieldsForSearch>
<field>Name</field>
<field>Name__c</field>
</fieldsForSearch>
<showResult>
<field>Name__c</field>
</showResult>
<objectName>
<field>Underlying__c</field>
</objectName>
<showFindLimit>
<field>4</field>
</showFindLimit>
<prefix>
<field/>
</prefix>
<relatedFilter>
<field name="RecordTypeName"/>
</relatedFilter>
</searchObjectSetting>
<fieldsForShowSetting>
<field>
<field name="name">Spot__c</field>
<field name="type">Decimal</field>
<field name="label">Spot</field>
<field name="format">0.00</field>
<field name="relatedObject">Underlying__r</field>
<field name="show"/>
</field>
<field>
<field name="name">Performance__c</field>
<field name="type">Decimal</field>
<field name="label">Performance</field>
<field name="format">0.00</field>
<field name="relatedObject"/>
<field name="show">show</field>
</field>
<field>
<field name="name">Strike__c</field>
<field name="type">Decimal</field>
<field name="label">Strike</field>
<field name="format">0.00</field>
<field name="relatedObject"/>
<field name="show">show</field>
</field>
<field>
<field name="name">Name__c</field>
<field name="type">String</field>
<field name="label">Name</field>
<field name="format">text</field>
<field name="relatedObject">Underlying__r</field>
<field name="show"/>
</field>
</fieldsForShowSetting>
<fieldsForEditSetting>
<field>Strike__c</field>
</fieldsForEditSetting>
</relatedObject>
</object>
</objectSettingsForRelatedEditorComponent>