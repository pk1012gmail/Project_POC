trigger ValidateAccount on Account (before insert, before update) {
    
    set<string> custIdSet=new set<string>();
    
    Map<string, List<Account>> custIdAccountMap=new Map<string, List<Account>>();
    
    for(Account a:Trigger.new){
    	//custIdLst.add(a.Custom_Id__c);
    	if(string.isnotblank(a.Custom_Id__c)){
	    	if(custIdAccountMap.containsKey(a.Custom_Id__c) && custIdAccountMap.get(a.Custom_Id__c).size()<2){
	    		List<Account> accLst=custIdAccountMap.get(a.Custom_Id__c);
	    		accLst.add(a);
	    		custIdAccountMap.put(a.Custom_Id__c,accLst);
	    		custIdSet.add(a.Custom_Id__c);
	    	}    	
	    	else if(custIdAccountMap.containsKey(a.Custom_Id__c) && custIdAccountMap.get(a.Custom_Id__c).size()==2){
	    		custIdSet.remove(a.Custom_Id__c);
	    		a.addError('Duplicate Account, cannot be Inserted / Updated');
	    	}
	    	else{
	    		custIdAccountMap.put(a.Custom_Id__c,new List<Account>{a});
	    		custIdSet.add(a.Custom_Id__c);
	    	}
    	}
    }
    
    AggregateResult[] lstDuplicateAccount=[Select count(id)dupRec,Custom_Id__c from Account 
    			where Custom_Id__c in:custIdSet and id not in :Trigger.new  group by Custom_Id__c];
    
    for(AggregateResult a:lstDuplicateAccount){
    	if(integer.valueof(a.get('dupRec'))>=2 && custIdAccountMap.containsKey(string.valueof(a.get('Custom_Id__c')))){
    		List<Account> accLst=custIdAccountMap.get(string.valueof(a.get('Custom_Id__c')));
    		for(Account acc:accLst){
    			acc.AddError('Duplicate Account, cannot be Inserted / Updated');
    		}
    	}else if(integer.valueof(a.get('dupRec'))==1 && custIdAccountMap.containsKey(string.valueof(a.get('Custom_Id__c'))) 
    			&& custIdAccountMap.get(string.valueof(a.get('Custom_Id__c'))).size()==2){
    				custIdAccountMap.get(string.valueof(a.get('Custom_Id__c')))[1].AddError('Duplicate Account, cannot be Inserted / Updated');
    			}
    }			
}