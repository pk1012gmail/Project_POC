<aura:application >
    <aura:handler type="event" event="c.AppEvent" action="onclick"/>
    <lightning:button onclick="{c.onClickApp}" name="appClick" value="{c.appEvent}">click</lightning:button>
</aura:application>