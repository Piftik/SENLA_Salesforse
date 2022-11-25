public with sharing class PropertyController {
 
    @AuraEnabled(cacheable=true)
    public static List<Property_New__c> getPropertyList() {
        
        return [
            SELECT Id, Name, Address__c, Property_Owner__r.Name, Cost_Sale__c, Picture__c
            FROM Property_New__c
            WHERE Picture__c != NULL
            ];
    }

}
