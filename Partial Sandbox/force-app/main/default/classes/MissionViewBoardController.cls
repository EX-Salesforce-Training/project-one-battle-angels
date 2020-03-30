public class MissionViewBoardController 
{
    Account contactAccount {get; set;}
    Contact contactUser { get; set;}
    String error {get; set;}
    List<Package__c> packages {get
    {
        if(packages == null && contactUser != null) 
        {
            Inhabitant__c resident = [SELECT Id, Contact__r.Id 
                                      FROM Inhabitant__c 
                                      WHERE Contact__r.Id =: contactUser.Id];
            packages = [SELECT Shipping_Status__c, Tracking_Number__c 
                        FROM Package__c 
                        WHERE Inhabitant__r.Id =: resident.Id];
        }
        return packages;
    }set;}
    
	public MissionViewBoardController()
    {
        try
        {
          contactUser = [SELECT Account.Name, AccountId, FirstName, LastName 
                  FROM Contact 
                  WHERE User_Name__c =: UserInfo.getUserName()]; 
            
          contactAccount = new Account(Id = contactUser.AccountId, Name = contactUser.Account.Name);
        }
        catch(System.QueryException e)
        {
            contactUser = null;
			error = e.getMessage();            
        } 
    }
}