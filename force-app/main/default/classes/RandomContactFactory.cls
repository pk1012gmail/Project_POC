public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer count, String lName){
        List<Contact> conList = new List<Contact>();
        for(Integer i=0;i<count ;i++){
            contact con = new Contact();
            con.FirstName = 'Test' + i;
            con.LastName = lName;
            conList.add(con);
        }
        return conList;
    }
}