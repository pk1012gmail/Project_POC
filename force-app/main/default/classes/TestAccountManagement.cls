/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest (seealldata=false)
private class TestAccountManagement {
	
	@testsetup
	static void setUpData(){
		List<Account> lstAccount= new List<Account>();
		Account a =new Account(Name='test account 1', custom_id__c='test account 1');
		lstAccount.add(a);
		Account b =new Account(Name='test account 2', custom_id__c='test account 1');
		lstAccount.add(b);
		Account c =new Account(Name='test account 3', custom_id__c='test account 3');
		lstAccount.add(c);
		
		insert lstAccount;
	}

    static testMethod void myUnitTestAccountManagement() {
        List<Account> lstAccount= new List<Account>();
        List<AccountCreateService.AccountWrapper> lstAccountWrapper= new List<AccountCreateService.AccountWrapper>();
        for(Integer i=0 ;i <200;i++)
        {
            Account acc = new Account();
            acc.Name ='Name'+i;
            acc.custom_id__c='Name'+i;
            lstAccount.add(acc);
            lstAccountWrapper.add(new AccountCreateService.AccountWrapper(acc));
        }
        
        insert lstAccount;
        List<id> lstids=AccountCreateService.insertAccount(lstAccountWrapper);   
        //system.assertEquals(200,lstids.size()); 
        InsertAccountsController ctl=new InsertAccountsController();
        ctl.addNewAccountRow();
        ctl.accountsToBeUpserted=lstAccount;
        ctl.accountsToBeUpserted.add(new Account(Name='test account 1', custom_id__c='test account 1'));
        ctl.accountsToBeUpserted.add(new Account(Name='test account 1', custom_id__c='test account 1'));
        ctl.save();
        //List<id> lstids=AccountCreateService.insertAccount(lstAccountWrapper);
        Test.startTest();

            UniqueAccountsBatch obj = new UniqueAccountsBatch();
            DataBase.executeBatch(obj); 
        
        Test.stopTest();
    }
    
    
    static testMethod void myUnitTestAccountManagement1() {
        UniqueAccountBatchSetting__c lastBatchRun
    		=UniqueAccountBatchSetting__c.getValues('UniqueAccountBatchLastRun');
    	
    	if(lastBatchRun==null)
    		lastBatchRun=new UniqueAccountBatchSetting__c(Name='UniqueAccountBatchLastRun');
    	
    	lastBatchRun.value__c=string.valueof(Datetime.now().addDays(-1));
    	upsert lastBatchRun;
    	
    	try{
	    	Account a =new Account(Name='test account 1', custom_id__c='test account 1');
			insert a;
    	}catch(exception e){
    		system.debug(e);
    	}
        Test.startTest();

            UniqueAccountsBatch obj = new UniqueAccountsBatch();
            DataBase.executeBatch(obj,100); 
        
        Test.stopTest();
    }
}