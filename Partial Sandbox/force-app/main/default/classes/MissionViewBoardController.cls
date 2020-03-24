public class MissionViewBoardController 
{
    Account userAccount;
    Contact user;
    
	public MissionViewBoardController()
    {
        user = [SELECT Account.Name, FirstName, LastName 
                FROM Contact 
                WHERE (FirstName =: UserInfo.getFirstName() AND LastName =: UserInfo.getLastName())
              	AND Email =: UserInfo.getUserEmail()];
        
        userAccount = new Account(Id = user.AccountId, Name = user.Account.Name);
    }
}