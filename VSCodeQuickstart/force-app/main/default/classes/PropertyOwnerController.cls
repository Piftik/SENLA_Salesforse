public with sharing  class PropertyOwnerController {
	
    private contact contacts {get; set;}
    public List<Deal__c> listDeals;
   

    public PropertyOwnerInfoReportController(ApexPages.StandardController stdController) {
        this.contacts = (contact)stdController.getRecord();
        this listDeals = DealManager.getDealsByOwner (this.contacts)
    }
    public List<DealsInfoForTable.DealTableWrapper> getDeals() {
        return DealsInfoForTable.getDealsInfoForTable(this.deals);
    }
          
       
    
}