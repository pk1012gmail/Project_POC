public class UniqueAccountsBatch implements Database.Batchable<sobject>, Database.stateful{
    
    map<string, integer> custIdCountMap;
    
    public UniqueAccountsBatch(){
    	custIdCountMap=new map<string, integer>();
    }
     
    public Database.QueryLocator start(Database.batchablecontext bc){
    	
    	UniqueAccountBatchSetting__c lastBatchRun
    		=UniqueAccountBatchSetting__c.getValues('UniqueAccountBatchLastRun');
		string query;
		
		if(lastBatchRun!=null && string.isnotblank(lastBatchRun.value__c)){
			Datetime fromTime=Datetime.valueof(lastBatchRun.value__c);
			query='Select id,Custom_Id__c from account where createddate>=:fromTime' + (Test.isRunningTest()?' LIMIT 10':'');  
		}
		else
			query='Select id,Custom_Id__c from account order by createddate desc LIMIT ' + (Test.isRunningTest()?'  10':'100000');  	  	
    	return Database.getQueryLocator(query);
    }
    
    public void execute(Database.batchablecontext bc, List<Account> scope){
    	for(Account a:scope){
    		if(string.isNotBlank(a.Custom_Id__c) && custIdCountMap.containsKey(a.Custom_Id__c)){
	    		integer countCustId=custIdCountMap.get(a.Custom_Id__c);
	    		countCustId++;
	    		custIdCountMap.put(a.Custom_Id__c,countCustId);
	    	} 
	    	else if(string.isNotBlank(a.Custom_Id__c)){
	    		custIdCountMap.put(a.Custom_Id__c,1);	    		
	    	}
    	}
    }
    
    public void finish(Database.batchablecontext bc){
    	UniqueAccountBatchSetting__c lastBatchRun
    		=UniqueAccountBatchSetting__c.getValues('UniqueAccountBatchLastRun');
    	
    	if(lastBatchRun==null)
    		lastBatchRun=new UniqueAccountBatchSetting__c(Name='UniqueAccountBatchLastRun');
    	
    	lastBatchRun.value__c=string.valueof(Datetime.now());
    	upsert lastBatchRun;
    	string[] toAddress=new string[]{};
    	UniqueAccountBatchSetting__c accountBatchEmailRecepients
    		=UniqueAccountBatchSetting__c.getValues('UniqueAccountBatchEmailRecepients');
    	
    	if(accountBatchEmailRecepients!=null && string.isNotBlank(accountBatchEmailRecepients.value__c)){
    		toAddress=accountBatchEmailRecepients.value__c.split(';');
    	}
    	else{
    		toAddress.add(userinfo.getUserEmail());
    	}
    	system.debug(custIdCountMap);	
    	
    	EmailTemplate temp=[Select Subject, HtmlValue, DeveloperName, Body From EmailTemplate e
    				where DeveloperName='UniqueAccountsTemplate'];    	
    	
    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    	
    	mail.setToAddresses(toAddress);	        
        mail.setSubject(temp.Subject);
		mail.setBccSender(false); 
		mail.setUseSignature(false);			
		if(custIdCountMap.size()>0){
			mail.setPlainTextBody(temp.Body.replace('+++AAABBB+++',JSON.serialize(custIdCountMap)));
			string tableRows='';
			for(string str:custIdCountMap.keySet()){
					tableRows=tableRows+'<tr><td>'+str+'</td>'+'<td>'+custIdCountMap.get(str)+'</td></tr>';		
			}
			mail.setHtmlBody(temp.HtmlValue.replace('+++AAABBB+++',tableRows));
		}else{
			mail.setPlainTextBody(temp.Body.replace('+++AAABBB+++','Zero records created recently'));
			mail.setHtmlBody(temp.HtmlValue.replace('+++AAABBB+++','Zero records created recently'));
		}
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
    		
    }
    
}