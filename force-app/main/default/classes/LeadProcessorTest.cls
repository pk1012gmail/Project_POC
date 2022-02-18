@isTest
public class LeadProcessorTest {

    public static testmethod void leadBatchTest(){
        List<Lead> leadList = new List<Lead>();
        for(Integer i=0;i<200;i++){
            Lead l = new Lead();
            //l.Name = 'test'+i;
            l.LastName = 'test' + i;
            l.Company = 'company';
            leadList.add(l);
        }
        insert leadList;
        test.startTest();
        LeadProcessor ba = new LeadProcessor();
        database.executeBatch(ba);
        test.stopTest();
    }
}