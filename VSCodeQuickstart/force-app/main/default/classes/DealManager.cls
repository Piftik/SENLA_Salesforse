public inherited sharing class DealManager {

    public static final Id SALE_RECORD_TYPE_ID = '';
    private String STATUS_ORDER = 'Closed Won';


        public class DealWrapper {
            public Id buyer {get; set;}
            public Id salesman {get; set;}
            public Id property {get; set;}
            public Date finishLease {get; set;}
        }
    
        public static Deal__c createDeal(DealWrapper wrapper, Boolean serialize) {
            Deal__c deal = new Deal__c();
            deal.Buyer__c = wrapper.buyer;
            deal.Salesman__c = wrapper.salesman;
            deal.Property_New__c = wrapper.property;
            deal.Finish_Lease__c = wrapper.finishLease;
    
            if (serialize) insert deal;
    
            return deal;
        }

        public static List<Deal__c> getDealsByIds(List<Id> ids, String fields){

            String query = 'select ' + fields + ' from Deal__c where Id in :ids';
            List<Deal__c> deals = Database.query(query);
            return deals;
        } 

        public static Deal__c getDealById(Id dealId, String fields){

            String query = 'select ' + fields + ' from Deal__c where Id=:dealId';
            Deal__c deal = Database.query(query);
            return deal;
        }

        public static void deleteDealById(Id dealId, String fields) {
            delete [SELECT Id FROM Deal__c WHERE Deal.Id IN : Ids];
        }

     public static List<Deal__c> getDealsByClosedWon(List<Id> sellers, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Deal__c WHERE Status__c =:STATUS_ORDER');
    }

public static List<Deal__c> getNotClosedSaleDealsByProperties(List<Id> propertyIds) {
   return [
           SELECT Id
           FROM Deal__c
           WHERE Property_New__c IN :propertyIds
           AND Status__c NOT IN ('Closed Won', 'Closed', 'Closed Lost')
           AND RecordTypeId = :SALE_RECORD_TYPE_ID
   ];
}

}
