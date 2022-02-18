({
	packItem : function(component, event, helper) {
        var ci = component.get("v.item",true);
        ci.packed__c = true;
		component.set("v.item",ci);
        var btn = event.getSource();
        btn.set("v.disabled",true);//Disable the button
	}
})