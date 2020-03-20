trigger PackageTrigger on Package__c (before insert) {
    if (Trigger.isBefore && Trigger.isInsert)
        Tracking.createTrackingNumber(Trigger.new);
}