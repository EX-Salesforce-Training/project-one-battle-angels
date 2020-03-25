public class PastList {
    private ApexPages.StandardSetController ssc;

    public PastList()
    {
        List<Package__c> PackageList = [SELECT Name, Shipping_Status__c FROM Package__c];

        ssc = new ApexPages.StandardSetController(PackageList);
        ssc.setFilterID('00B17000004Gxe8');
    }

    public List<Package__c> getPackages() 
    {
        return (List<Package__c>)ssc.getRecords();
    }
}