public class MissionViewBoardController 
{
    Account userAccount {get; set;}
    Contact user { get; set;}
    String error {get; set;}
    List<Package__c> packages {get
    {
        if(packages == null && user != null) 
        {
            Inhabitant__c resident = new Inhabitant__c();
            packages = [SELECT Shipping_Status__c, Tracking_Number__c 
                        FROM Package__c ];
        }
        return packages;
    }set;}
    
	public MissionViewBoardController()
    {
        try
        {
          user = [SELECT Account.Name, FirstName, LastName 
                  FROM Contact 
                  WHERE UserName__c =: UserInfo.getUserName()]; 
            
          userAccount = new Account(Id = user.AccountId, Name = user.Account.Name);
        }
        catch(System.QueryException e)
        {
            user = null;
			error = e.getMessage();            
        } 
    }
}