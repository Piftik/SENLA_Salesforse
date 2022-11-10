public with sharing  class PropertyOwnerController {
	
     public ;
    private final Contact contacts;

    public PropertyOwnerInfoReportController(ApexPages.StandardController stdController) {
        this.contacts = (Contact)stdController.getRecord();
    }
    
          public List<DealTableWrapper> getDeals() {
        String fields = 'Id, Total__c, OwnerId, Property_New__r.RecordType.Name, Total_Percent__c';
            List<Deal__c> listDeals = DealManager.getDealsByClosedWon (new List<Id>{contacts.Id}, fields);
          
          Map<String, List<Deal__c>> dealsByRecordType = new Map<String, List<Deal__c>>();
          
          for(Deal__c deal : listDeals) {
            List<Deal__c> groupValue = dealsByRecordType.get(deal.Property_New__r.RecordType.Name);

            if (groupValue == null) {
                dealsByRecordType.put(deal.Property_New__r.RecordType.Name, new List<Deal__c>());    
            }

            dealsByRecordType.get(deal.Property_New__r.RecordType.Name).add(deal);
        }
          
     List<DealTableWrapper> result = new List<DealTableWrapper>();
        for (List<Deal__c> groupedDeals : dealsByRecordType.values()) {
            result.add(new DealTableWrapper(groupedDeals));
        }

        return result;
}
 		
    
    public class DealTableWrapper {
        public String recordTypeName {get;set;}
        public Integer amauntDels {get;set;}
        public Decimal totalSum {get;set;}
        public Decimal totalSumWithBrokerPercent {get;set;}

        public DealTableWrapper(List<Deal__c> deals) {
            this.recordTypeName = deals[0].Property_New__r.RecordType.Name;
            this.amauntDels = 0;
            this.totalSum = 0;
            this.totalSumWithBrokerPercent = 0;

            for (Deal__c deal : deals) {
                this.totalSum += deal.Amount__c;
                this.totalSumWithBrokerPercent += deal.Total__c;
                this.amauntDels += 1;
                
            }
        }
    }
}