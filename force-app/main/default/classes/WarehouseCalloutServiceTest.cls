@isTest
private class WarehouseCalloutServiceTest {
  // implement your mock callout test here
    private static testmethod void testrunWarehouseEquipmentSync(){
        WarehouseCalloutServiceMock fakeResponse = new WarehouseCalloutServiceMock();
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        //public static testmethod void testCallout() {
        // Set mock callout class 
        WarehouseCalloutService.runWarehouseEquipmentSync();
        List<Product2> products = [SELECT Id from Product2];
        
        Test.stopTest();
    }
    private static testmethod void testrunWarehouseEquipmentSyncSch(){
        WarehouseCalloutServiceMock fakeResponse = new WarehouseCalloutServiceMock();
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        //public static testmethod void testCallout() {
        // Set mock callout class 
         WarehouseSyncSchedule sh1 = new WarehouseSyncSchedule();
        String sch = '0 0 23 * * ?'; 
        system.schedule('ScheduleApexClassTest', sch, sh1);
        Test.stopTest();
    }
    private static testmethod void maintTest(){
        Product2 p = new Product2();
        p.Lifespan_Months__c = 12;
        p.Name = 'Test Eqip';
        insert p;
        Vehicle__c v= new Vehicle__c();
        v.Name = 'test vehicle';
        insert v;
        Case c = new Case();
        c.Status = 'open';
        c.Type = 'Repair';
        c.Vehicle__c = v.Id;
        c.Equipment__c = p.Id;
        insert c;
        Test.startTest();
        c.Status = 'Closed';
        update c;
        Test.stopTest();
    }
}