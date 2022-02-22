trigger AccountAddressTrigger on Account (before insert, before update) {

    for(Account acc : trigger.new) {
        if(!String.isBlank(acc.BillingPostalCode) && acc.Match_Billing_Address__c) {
            acc.ShippingPostalCode = acc.BillingPostalCode;
        }
    }
}