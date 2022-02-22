public class AccountProcessor {

    @future 
    public static void countContacts(List<Id> AccIdList){
        
        List<Account> AccList= new List<Account>();
        Map<Id, Integer> accIdByConCountMap = new Map<Id, Integer>();
        Integer i = 0;
        for(Contact con : [SELECT Id,AccountId FROM Contact WHERE AccountId IN: AccIdList]){
            if(accIdByConCountMap.containsKey(con.AccountId))
                i = accIdByConCountMap.get(con.AccountId);
            i=i+1;
            accIdByConCountMap.put(con.AccountId,i);
        }
        for(Account acc : [SELECT ID, Number_Of_Contacts__c FROM Account WHERE Id IN : accIdByConCountMap.keySet()]){
            acc.Number_Of_Contacts__c = accIdByConCountMap.get(acc.Id);
            AccList.add(acc);
        }
        if(!AccList.isEmpty())
            update AccList;
    }
}