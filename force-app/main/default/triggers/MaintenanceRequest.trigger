trigger MaintenanceRequest on Case (before update, after update) {
    
    if(Trigger.isAfter && Trigger.isUpdate){
        List<Case> caseList = new List<Case>();
        for(Case c : Trigger.new){
            if(c.status =='Closed' && Trigger.oldMap.get(c.id).status!='Closed'){
                caseList.add(c);
            }
        }
     MaintenanceRequestHelper.updateWorkOrders(caseList);
    }
}