public class MaintenanceRequestHelper {
    
    //public static void updateWorkOrders(){
        // update workorders
    //}  
    public static void updateWorkOrders(List<Case> newList){
        Map<Id,Case> closedCaseMap = new Map<Id,Case>();
        for(Case c : newList){
            if(c.Type=='Repair' || c.Type=='Routine Maintenance'){
                closedCaseMap.put(c.id, c);
            }
        }
        if(!closedCaseMap.isEmpty()){
            Map<Id,Object> caseLifeSpanMap = new Map<Id,Object>();
            for(Case caseRec : [SELECT Id, Equipment__c, Equipment__r.Lifespan_Months__c, Equipment__r.Maintenance_Cycle__c FROM Case WHERE ID IN:closedCaseMap.keySet() ORDER BY Equipment__r.Maintenance_Cycle__c DESC]){
                caseLifeSpanMap.put(caseRec.id, caseRec.Equipment__r.Maintenance_Cycle__c);
            }
            List<Case> childCaseList = new List<Case>();
            for(Id caseId : closedCaseMap.keySet()){
                Case caseNew = new Case();
                caseNew.Vehicle__c = closedCaseMap.get(caseId).Vehicle__c;
                caseNew.Equipment__c = closedCaseMap.get(caseId).Equipment__c;
                caseNew.Type = 'Routine Maintenance';
                caseNew.Subject = 'Next Routine Maintenance';
                caseNew.Date_Reported__c = date.today();
                Integer lifeSpan = Integer.valueOf(caseLifeSpanMap.get(caseId));
                lifeSpan = (lifeSpan==null)?0:lifeSpan;
                caseNew.Date_Due__c = date.today().addDays(lifeSpan);
                childCaseList.add(caseNew);
            }
            insert childCaseList;
        }
    }
    
}