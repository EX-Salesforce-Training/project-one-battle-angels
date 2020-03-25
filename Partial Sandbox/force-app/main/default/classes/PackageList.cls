public class PackageList {
    private ApexPages.StandardSetController ssc;

    public PackageList()
    {
        List<Package__c> PackageList = [SELECT Name, Shipping_Status__c FROM Package__c];

        ssc = new ApexPages.StandardSetController(PackageList);
        ssc.setFilterID('00B17000004GxUs');
    }

    public List<Package__c> getPackages() 
    {
        return (List<Package__c>)ssc.getRecords();
    }
}