trigger PackageTrigger on Package__c (after insert) {
	if (Trigger.isAfter && Trigger.isInsert)
        Tracking.createTrackingNumbers(Trigger.new);
}