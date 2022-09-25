public inherited sharing class DealManager {

        public class DealWrapper {
            public Id buyer {get; set;}
            public Id salesman {get; set;}
            public Id sellingProperty {get; set;}
            public Date finishLease {get; set;}
        }
    
        public static Deal__c createDeal(DealWrapper wrapper, Boolean serialize) {
            Deal__c deal = new Deal__c();
            deal.Buyer__c = wrapper.buyer;
            deal.Salesman__c = wrapper.salesman;
            deal.Selling_Property__c = wrapper.sellingProperty;
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
            delete [SELECT Id FROM Deal__c WHERE Deal.Id IN : idss];
        }

        public static Deal__c getDealFinishLease(Id dealId, String fields){

            if (finishLease == today().addDays(5)) {
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();//хотел чтоб при аренде когда остается 5 дней до конца отпровлялось письмо, но разобраться до конца не смог, не хватило времени.                
            }
            String query = 'select ' + fields + ' from Deal__c where Id=:dealId';
            Deal__c deal = Database.query(query);
            return deal;
        }
}
