public class AddPrimaryContact implements Queueable{

    private List<Account> accounts;
    private contact con;
    private String s;
    public AddPrimaryContact(Contact cont, String State){
        this.con = cont;
        this.s = State;
        this.accounts = [SELECT Id, BillingState FROM Account WHERE BillingState = :State LIMIT 200];
           
    }
    
    public void execute(QueueableContext context) {
        LIst<Contact> conList = new List<Contact>();
        for (Account account : accounts) {
          Contact c = new Contact();
            c= con.clone();
            c.LastName = 'test'+account.Id;
            c.AccountId = account.Id;
            conList.add(c);
        }
        insert conList;
    }
}