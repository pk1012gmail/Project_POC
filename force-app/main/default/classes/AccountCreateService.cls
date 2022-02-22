@RestResource(urlMapping='/AccountCreateService/*')
global class AccountCreateService {
      
    @HttpGet
    global static List<AccountWrapper> doGet() {
    	List<AccountWrapper> lstAccountWrapper=new List<AccountWrapper>();
    	 RestRequest request = RestContext.request;
        String custId= request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
    	List<Account> lstAcc=[Select id,Custom_Id__c,Name,Phone 
    							from account where Custom_Id__c=:custId];
    	if(!lstAcc.isEmpty()){ 
	    	for(Account a:lstAcc){
	    		AccountWrapper acc=new AccountWrapper(a);
	    		system.debug(acc);
	    		system.debug( a);
	    		lstAccountWrapper.add(acc);
	    	}
    	}
    	system.debug(lstAccountWrapper);
    	system.debug(JSON.serialize(lstAccountWrapper));
    	return lstAccountWrapper;
    }
  
  	@HttpPost
    global static list<id> insertAccount(List<AccountWrapper> accWrapperList) {
        try{
	        List<Account> lstAccountToInsert=new List<Account>();
	        List<id> accIds=new List<id>();
	        for(AccountWrapper a:accWrapperList){
	        	Account acc=new Account(Name=a.name,phone=a.phone,Custom_Id__c=a.custId);
	        	lstAccountToInsert.add(acc);
	        }
	        Database.SaveResult[] saveResult=Database.insert(lstAccountToInsert,false);
	        // Iterate through each returned result
			for (Database.SaveResult sr : saveResult) {
			    if (sr.isSuccess()) {
			        // Operation was successful, so get the ID of the record that was processed
			        System.debug('Successfully inserted account. Account ID: ' + sr.getId());
			        accIds.add(sr.getId());
			    }
			    else {
			        // Operation failed, so get all errors                
			        for(Database.Error err : sr.getErrors()) {
			            System.debug('The following error has occurred.');                    
			            System.debug(err.getStatusCode() + ': ' + err.getMessage());
			            System.debug('Account fields that affected this error: ' + err.getFields());
			        }
			    }
			}
			return accIds;
        }catch(exception e){
			System.debug('Exception : ' + e.getMessage());
			System.debug('Cause: ' + e.getCause());
			System.debug('Line number: ' + e.getLineNumber());
			System.debug('Stack trace: ' + e.getStackTraceString());
			return null;
		}
    }
    
    
    global class AccountWrapper{
    	string name {get;set;}
    	string phone{get;set;}
    	string custId{get;set;}
    	global AccountWrapper(Account a){
    		name=a.name;
    		phone=a.phone;
    		custId=a.Custom_Id__c;
    	}
    	global AccountWrapper(string name,string phone, string custId){
    		this.name=name;
    		this.phone=phone;
    		this.custId=custId;
    	}
    }

}