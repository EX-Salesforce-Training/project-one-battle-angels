public with sharing class ContactInfoRedirect {
    public Contact c {get;set;}
    public Contact cId {get;set;}
    public ContactInfoRedirect(ApexPages.StandardController controller) {
        cId = (Contact) controller.getRecord();
        c = [SELECT AccountId FROM Contact WHERE Id =: cId.Id LIMIT 1];
    }
    public PageReference save() {
        update cId;
        return new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/apex/FindEditAccountInfo?id=' + c.AccountId);
    }
    public PageReference cancel() {
        return new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/apex/FindEditAccountInfo?id=' + c.AccountId);
    }
}