@isTest
public class AddPrimaryContactTest {

    Public Static testmethod void testQueueable(){
        List<Account> aList = new List<Account>();
        for(Integer i=0;i<50;i++){
            Account acc = new Account();
            acc.Name='test'+i;
            acc.BillingState = 'NY';
            aList.add(acc);
        }
        for(Integer i=0;i<50;i++){
            Account acc = new Account();
            acc.Name='test'+i;
            acc.BillingState = 'CA';
            aList.add(acc);
        }
        insert aList;
        Contact con = new Contact(lastName='test');
        AddPrimaryContact updater = new AddPrimaryContact(con,'CA');
        // startTest/stopTest block to force async processes to run
        
        Test.startTest();        
        System.enqueueJob(updater);
                Test.stopTest();    
        List<COntact> conList = [SELECT Id FROM COntact where contact.Account.BillingState='CA'];
        system.assertEquals(50, conList.size());
    }
}