public with sharing  class PropertyOwnerController {
	
    private String statusOrder = 'Closed Won';
      private final Contact con;

    public PropertyOwnerController(ApexPages.StandardController stdController) {
        this.con = (Contact)stdController.getRecord();
    } 
          
	public List<DealTableWrapper> getOfficeDeals() {
          List<Deal__c> listDeals = [Select Id, Total__c, OwnerId, Property_New__r.RecordType.Name,
                               	Amount__c 
                               FROM Deal__c 
                               WHERE Status__c =:statusOrder 
                               AND Property_New__r.RecordType.Name = 'Office']; 
          
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
       public List<DealTableWrapper> getIndustrialDeals() {
    List<Deal__c> listDeals = [Select Id, Total__c, OwnerId, Property_New__r.RecordType.Name,
                               	Amount__c
                               FROM Deal__c 
                               WHERE Status__c =:statusOrder 
                               AND Property_New__r.RecordType.Name = 'Industrial']; 
          
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
    
      public List<DealTableWrapper> getSpaceDeals() {
    List<Deal__c> listDeals = [Select Id, Total__c, OwnerId, Property_New__r.RecordType.Name,
                               	Amount__c 
                               FROM Deal__c 
                               WHERE Status__c =:statusOrder 
                               AND Property_New__r.RecordType.Name = 'Space']; 
          
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