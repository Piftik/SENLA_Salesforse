trigger DealTrigger on Deal__c (after update) {
    new DealTriggerHandler().run();
}