public with sharing class Authenticate2Controller {
    

    @AuraEnabled(cacheable=true)
    public static String sayHello() {
        return 'Hello222';
    }
    @AuraEnabled(cacheable=true)
    public static String authenticateUser(String uName, String passwd, String region) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.nice-incontact.com/InContactAuthorizationServer/Token');               
        request.setMethod('POST');
        //request.setHeader('Authorization', accessToken);
        request.setTimeout(120000);
        request.setHeader('content-Type', 'application/json; charset=UTF-8');
        request.setHeader('Accept', 'application/json, text/javascript, */*; q=0.01');
        String body = '{"grant_type": "password", "username":"' + uName + '", "password":"' + passwd + '", "scope": "RealTimeApi ChatApi CustomApi AdminApi AgentApi ReportingApi"}';
        request.setBody('{"grant_type":"password","username":"Einstein@b2.com","password":"password1","scope":"RealTimeApi ChatApi CustomApi AdminApi AgentApi ReportingApi","Authorization":"basic aW5Db250YWN0IFN0dWRpb0BpbkNvbnRhY3QgSW5jLjpaV0kxTUdFNE5tWTNOR1JsTkdJMU9EbG1ZMk14TUdFM1pUUmhOek0xWkRNPQ=="}');
        HttpResponse response =   http.send(request);
        system.debug(response.getBody());
        Map<String, Object> data = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        system.debug(data);
        String token = (String)data.get('access_token');
        return  token;
     }
}