public class Tracking {
        public static void createTrackingNumbers(Package__c[] newPackages) {
            Package__c[] trackedPackages = new List<Package__c>();
            for (Integer i = 0; i < newPackages.size(); i++)
                trackedPackages.add([SELECT Name FROM Package__c WHERE Id =: newPackages[i].Id LIMIT 1]);
            for (Integer i = 0; i < trackedPackages.size(); i++)
                trackedPackages[i].Tracking_Number__c = EncodingUtil.convertToHex(
                    Crypto.generateDigest('SHA1',Blob.valueOf(trackedPackages[i].Name)));
            update trackedPackages;
        }
}