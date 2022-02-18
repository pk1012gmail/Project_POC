@isTest
public class TestVerifyDate {

    public static testmethod void CheckDates_test(){
        
        Date dToday = Date.today();
        Date date1 = dToday.addDays(10);
        Date date2 = dToday.addDays(40);
        test.startTest();
        Date dateRes = VerifyDate.CheckDates(dToday, date1);
        Date dateRes2 = VerifyDate.CheckDates(dToday, date2);
        system.assertEquals(dToday.addDays(10), dateRes);
        system.assertNotEquals(dToday.addDays(40), dateRes2);
        test.stopTest();
        
    }
}