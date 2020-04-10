public class AccountRelatedContactsController {
    public List<Contact> contacts {get;set;}
    public Account acc {get;set;}

    public AccountRelatedContactsController(ApexPages.StandardController controller) {
        acc = (Account) controller.getRecord();
        contacts = [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId =: acc.Id];
    }
    public PageReference editContact() {
        return new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/apex/EditContactInfo?id=' + ApexPages.currentPage().getParameters().get('contactId'));
    }
    public PageReference deleteContact() {
        try {
        for (Contact c: contacts)
            if (c.Id == ApexPages.currentPage().getParameters().get('contactId'))
                delete c;
        } catch (DMLException e) {
            system.debug(e.getStackTraceString());
        } finally {
            PageReference currentPage = ApexPages.currentPage();
            currentPage.setRedirect(true);
            return currentPage;
        }
        return null;
    }
    public PageReference cancel() {
        return new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/apex/MissionViewBoard');
    }
}