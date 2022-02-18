({
	onClickApp : function(component, event, helper) {
		var evt = event.target.getSOurce();
        var attribute = evt.getAttribute("v.appAttribute");
        component.setParam(attribute, "Clicked");
        evt.fire();
	}
})