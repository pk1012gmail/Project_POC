public class AccList {
	@AuraEnabled
    public static List<Account> AccountListFun(){
        List<Account> accList = [Select id, name from Account LIMIT 100];
        return accList;
    }
}