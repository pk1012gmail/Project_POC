@isTest
public class DailyLeadProcessorTest {
public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    public static testmethod void testScheduler(){
        
        List<Lead> leads = new List<Lead>();
        for(Integer i=0;i<200;i++){
            Lead l = new Lead();
            l.LastName = 'lead' + i;
            l.Company = 'Company';
            leads.add(l);
        }
        insert leads;
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',CRON_EXP, new DailyLeadProcessor()); 
test.stopTest();        
    }
}