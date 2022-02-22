@isTest
public class AccountProcessorTest {

    public Static testMethod void countContacts_test(){
        List<Account> AccList= new List<Account>();
        List<Contact> conList= new List<Contact>();
        for(Integer i=0;i<3;i++){
            Account acc = new Account();
            acc.Name = 'Acc' + i;
            AccList.add(acc);
        }
        insert AccList;
        List<Id> accIDList = new List<Id>();
        for(Account acc : [SELECT id from Account]){
            accIDList.add(acc.id);
        }
        for(Integer i=0;i<3;i++){
            Contact con = new contact();
            con.LastName = 'Test'+i;
            con.FirstName = 'con' + i;
            con.AccountId = accIDList[i];
            conList.add(con);
        }
        for(Integer i=0;i<3;i++){
            Contact con = new contact();
            con.LastName = 'Test1'+i;
            con.FirstName = 'con' + i;
            con.AccountId = accIDList[i];
            conList.add(con);
        }
        insert conList;
    
    test.startTest();
        AccountProcessor.countContacts(accIDList);
        system.assertEquals(3,accIDList.size());
        test.stopTest();
    }
}