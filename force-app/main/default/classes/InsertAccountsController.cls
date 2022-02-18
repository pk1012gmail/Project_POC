public class InsertAccountsController {
    public Account acc;
    
    public List<Account> accountsToBeUpserted{get;set;}
    
    public InsertAccountsController() {    
    	accountsToBeUpserted=new  List<Account>();
    	acc=new Account(); 
        accountsToBeUpserted.add(acc);
    }
    
    public void addNewAccountRow(){
    	Account a=new Account(); 
        accountsToBeUpserted.add(a);
    }
   
    
    
    public PageReference save() { 
    	try{
	        //system.debug('act name:' + acc.name + ' = ' + acc.accountNumber);
	        upsert accountsToBeUpserted;
	        return null;
    	}catch(exception e){
    		System.debug('Exception : ' + e.getMessage());
			System.debug('Cause: ' + e.getCause());
			System.debug('Line number: ' + e.getLineNumber());
			System.debug('Stack trace: ' + e.getStackTraceString());
			ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Error,e.getMessage()));
			return null;
    	}
    	
    
    }
}