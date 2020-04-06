public class MissionViewBoardController 
{
    Account contactAccount {get; set;}
    Contact contactUser { get; set;}
    public String trackingNumber {get; set;}
    String error {get; set;}
    /*
    List<Package__c> packages {get
    {
        if(packages == null && contactUser != null) 
        {
            List<Inhabitant__c> residents = [SELECT Id, Contact__r.Id 
                                      FROM Inhabitant__c 
                                      WHERE Contact__r.Id =: contactUser.Id];
            packages = [SELECT Shipping_Status__c, Tracking_Number__c 
                        FROM Package__c 
                        WHERE Inhabitant__r.Id IN :residents];
        }
        return packages;
    }set;}
    */
	public MissionViewBoardController()
    {
        try
        {
          contactUser = [SELECT Account.Name, AccountId, FirstName, LastName 
                         FROM Contact 
                         WHERE User_Name__c =: UserInfo.getUserName()]; 
            
           if(contactUser.AccountId != null )
           {
            	contactAccount = new Account(Id = contactUser.AccountId, Name = contactUser.Account.Name);   
           }
        }
        catch(System.QueryException e)
        {
            contactUser = null;
			error = e.getMessage();            
        } 
    }
    
    public PageReference findPackage()
    {
        PageReference packageDetails = new PageReference('');
        
        Package__c pck = [SELECT Id FROM Package__c WHERE Tracking_Number__c =: trackingNumber LIMIT 1];
        
        return packageDetails;
    }
}