@isTest
public class TestRestrictContactByName {

    public static testmethod void RestrictContactByName_test(){
        
        List<Contact> conList = new List<Contact>();
        for(integer i=0;i<3;i++){
            Contact con = new Contact(LastName = 'INVALIDNAME');
            conList.add(con);
        }
        test.startTest();
        try{
        insert conList;
        }catch(Exception ex){
            system.assertEquals(ex.getMessage().contains('Last'), true);
        }
        test.stopTest();
    }
}