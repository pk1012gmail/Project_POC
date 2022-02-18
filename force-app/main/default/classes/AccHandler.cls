public class AccHandler {
    
    public Integer getContact(Id accId){
        Integer conCount = [Select count() from Contact where Id=:accId];
        return conCount;
    }

}