trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    
    Set<Id> oppIdList = new Set<Id>();
    List<Task> taskList = new List<Task>();
    for(Opportunity opp : trigger.New) {
        if(opp.stageName == 'Closed Won') {
            oppIdList.add(opp.Id);
        }
    }
    for(Id oppId : oppIdList) {
        Task taskNew = new Task();
        taskNew.Subject ='Follow Up Test Task';
        taskNew.WhatId = oppId;
        taskList.add(taskNew);
    }
    if(!taskList.isEmpty())
        insert taskList;

}