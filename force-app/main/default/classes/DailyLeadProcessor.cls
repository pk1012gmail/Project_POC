global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> leads = new List<Lead>();
        for(Lead l:    [SELECT Id, leadsource FROM Lead WHERE leadsource = '' LIMIT 200]){
            l.leadsource='Dreamforce';
            leads.add(l);
        }
         update leads;   
    }
    
}