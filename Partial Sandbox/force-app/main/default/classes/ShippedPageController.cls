public class ShippedPageController {
   private ApexPages.StandardSetController ssc;

    public ShippedPageController(){
        List<Package__c> caseList = [SELECT Name FROM Package__c];

        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(caseList);
    }

    public List<Package__c> getCases() 
    {
        return (List<Package__c>)ssc.getRecords();
    }

}