@isTest
public class PackageTriggerTest {
    @isTest
    public static void beforeInsertTriggerTest() {
        Contact cont = new Contact(LastName='Saruman');
            Address__c addr = new Address__c( Name = '1120 Boolean Road',
                                     City__c='Moscow', State__c='ID', 
                                     Zip_Code__c = '99163');
            insert cont;
            insert addr;
            cont = [SELECT Id FROM contact WHERE LastName='Saruman'];
            addr = [SELECT Id FROM address__c WHERE Name = '1120 Boolean Road'];
            Inhabitant__c inhab = new Inhabitant__c(Name = 'Castle', 
                                                Address__c = addr.Id, 
                                                Contact__c = cont.Id);
            insert inhab;
            inhab = [SELECT Id FROM Inhabitant__c WHERE Name = 'Castle'];
            Package__c testPac = new Package__c(Inhabitant__c = inhab.id);
        insert testPac;
        testPac = null;
        
        testPac = [SELECT Name, Tracking_Number__c FROM Package__c LIMIT 1];
        system.debug(testPac);
        system.assertEquals(EncodingUtil.convertToHex(Crypto.generateDigest('SHA1',Blob.valueOf(testPac.Name))), testPac.Tracking_Number__c);
    }
}