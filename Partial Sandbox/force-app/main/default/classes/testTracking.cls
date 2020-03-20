@isTest
public class testTracking {
    	@isTest
    	public static void testTrackingTest(){
    		Contact cont = new Contact(LastName='Saruman');
    		Address__c addr = new Address__c( Name = '1120 Boolean Road',
                                     City__c='Moscow', State__c='Idaho', 
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
            Package__c pack = new Package__c(Inhabitant__c = inhab.id);
            insert pack;
            pack = [SELECT Name, Tracking_Number__c FROM Package__c LIMIT 1];
            String tracking = pack.Tracking_Number__c;
            Package__c testpack = [SELECT Name FROM Package__c WHERE Tracking_Number__c = :tracking];
            system.assertEquals(pack.Name, testpack.Name);
    }
}