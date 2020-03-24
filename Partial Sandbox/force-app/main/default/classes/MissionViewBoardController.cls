public class MissionViewBoardController 
{
    Account userAccount;
    Contact user;
    
	public MissionViewBoardController()
    {
        user = [SELECT Account.Name, FirstName, LastName 
                FROM Contact 
                WHERE UserName__c =: UserInfo.getUserName()];
        
        userAccount = new Account(Id = user.AccountId, Name = user.Account.Name);
    }
}