public class Tracking {
    public Tracking() {
        public static void createTrackingNumber(List<Package> newPackages) {
            for (Integer i = 0; i < newPackages.size(); i++)
                newPackages[i].Tracking_Number__c = EncodingUtil.convertToHex(
                    Crypto.generateDigest('SHA1',Blob.valueOf(newPackages[i].Name)));
        }
    }
}