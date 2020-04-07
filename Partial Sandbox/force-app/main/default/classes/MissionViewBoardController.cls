public class MissionViewBoardController 
{
    public Account contactAccount {get; set;} //The Property for displaying the current User's Account.
    public Contact contactUser { get; set;}	//The Property for displaying the current User's info. 
    public String trackingNumber {get; set;}//A property for the user to search for a tracking number.
    String error {get; set;}//To display an error message to the user if their account doesn't exist. 
    List<SelectOption> options {get; set;}//This property is used to display the status options.
    List<Inhabitant__c> residents {get; set;}//This Properpty is used to gather all packages sent to the contact, regardless of address.
    public List<String> packageStatusList {get; set;}
    //This property is used for displaying the statuses on 
    //the MissionViewBoard visualforcepage. 
    public List<String> statuses {get
    {
        if(statuses == null)
        {
            packageStatusList = new List<String>();
        	Schema.DescribeFieldResult statusPickList = Package__c.Shipping_Status__c.getDescribe();
        	List<Schema.PicklistEntry> ple = statusPickList.getPicklistValues();
        	for(Schema.PicklistEntry pickListVal : ple)
        	{
            	packageStatusList.add(pickListVal.getLabel());
        	}   
        }
        return packageStatusList;
    } set;}
    //This Property is used for displaying all the packages associated with
    //the current user on the MissionViewBoard visualforcepage. 
    public List<Package__c> packages {get
    {
        if(packages == null && contactUser != null) 
        {
            residents = [SELECT Id, Contact__r.Id 
                         FROM Inhabitant__c 
                         WHERE Contact__r.Id =: contactUser.Id];
            packages = [SELECT Shipping_Status__c, Tracking_Number__c 
                        FROM Package__c 
                        WHERE Inhabitant__r.Id IN :residents];
        }
        return packages;
    }set;}
	//Constructor
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
    //Action method to display our statuses on the MissionViewBoard visualforcepage. 
    public List<SelectOption> getItems()
    {
        options = new List<SelectOption>();
        for(String status : statuses)
        {
            options.add(new SelectOption(status,status));
        }
        return options;
    }
    //Action method for allowing filtering of packages by status on the 
    //MissionViewBoard visualforcepage.
    public void setPackages()
    {
        packages = [SELECT Shipping_Status__c, Tracking_Number__c FROM Package__c 
                    WHERE (Inhabitant__r.Id IN :residents) AND Shipping_Status__c LIKE :statuses];
    }    
    public PageReference findPackage()
    {
        PageReference packageDetails = new PageReference('');
        
        Package__c pck = [SELECT Id FROM Package__c WHERE Tracking_Number__c =: trackingNumber LIMIT 1];
        
        return packageDetails;
    }
}