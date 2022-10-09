public class FinishLeaseScheduler implements Schedulable {
    public void execute(SchedulableContext ctx) {

        Date endLeaseDate =  Date.today().addDays(-1);

        List<Deal__c> leaseEndDeals = [SELECT Id, Name, Finish_Lease__c FROM Deal__c
        WHERE  Finish_Lease__c = endLeaseDate ];
        
        List<NotifyClientRentEnding__e> newsEventList = new List<NotifyClientRentEnding__e>();
        for (Deal__c deal : scope) {
            NotifyClientRentEnding__e notifyEvent = new NotifyClientRentEnding__e(
                DealId__c = deal.Id,
                Info__c =  JSON.serialize(new InfoWrapper.InfoSpecification(deal), true)
            );
            newsEventList.add(notifyEvent);
        }
        
        Utils.sendEmailToFinishLease(scope);
        List<Database.SaveResult> results = EventBus.publish(newsEventList);
    }
    
}
