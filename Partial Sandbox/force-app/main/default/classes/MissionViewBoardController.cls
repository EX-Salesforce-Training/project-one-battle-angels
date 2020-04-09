public class MissionViewBoardController 
{
    /*** Properties ***/
    public User currentUser {get; set;}
    public Contact userContact {get; set;}
    public Account userAccount {get; set;}  
    public String trackingNumber {get; set;}
    String error {get; set;}
    List<SelectOption> options {get; set;}
    List<Inhabitant__c> residents {get; set;}
    public PageReference editAccount{get
    {
        if(editAccount == null)
        {
            if(userAccount != null)
        	{
            	//editAccount = new ApexPages.StandardController(userAccount).edit();
                editAccount = new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/apex/FindEditAccountInfo?id=' +  userAccount.Id);
        	}
       	 	else
        	{
            	editAccount = ApexPages.currentPage();
        	}         
        }
        return editAccount;
    }set;}
    public List<String> statuses {get
    {
        if(statuses == null)
        {
            statuses = new List<String>();
        	Schema.DescribeFieldResult statusPickList = Package__c.Shipping_Status__c.getDescribe();
        	List<Schema.PicklistEntry> ple = statusPickList.getPicklistValues();
        	for(Schema.PicklistEntry pickListVal : ple)
        	{
            	statuses.add(pickListVal.getLabel());
        	}   
        }
        return statuses;
    } set;}
    public List<Package__c> packages {get
    {
        if(packages == null && userContact != null) 
        {
            residents = [SELECT Id, Contact__r.Id 
                         FROM Inhabitant__c 
                         WHERE Contact__r.Id =: userContact.Id];
            packages = [SELECT Shipping_Status__c, Tracking_Number__c 
                        FROM Package__c 
                        WHERE Inhabitant__r.Id IN :residents];
        }
        return packages;
    }set;}
	/*** Constructors ***/
	public MissionViewBoardController()
    {           
        try
        {
          currentUser = [SELECT ID, ContactId FROM User WHERE Id =: UserInfo.getUserId()];  
          userContact = [SELECT Account.Name, AccountId, FirstName, LastName 
                         FROM Contact 
                         WHERE Id =: currentUser.ContactId]; 
            
           if(userContact.AccountId != null )
           {
                userAccount = new Account(Id = userContact.AccountId, Name = userContact.Account.Name); 
           }
        }
        catch(System.QueryException e)
        {
            userContact = null;
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
}