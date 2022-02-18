global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    
   
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'Select Id, LeadSource from Lead';
      return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Lead> scope){
        for(Lead l : scope){
            l.LeadSource = 'Dreamforce';
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext ctx){
        
    }
}