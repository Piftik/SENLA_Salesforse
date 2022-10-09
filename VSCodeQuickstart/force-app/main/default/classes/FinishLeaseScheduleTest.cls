@isTest
public class FinishLeaseScheduleTest {
    
      static final Id LEASE_TYPE = Schema.SObjectType.Deal__c.getRecordTypeInfosByName().get('Lease').getRecordTypeId();
    public static String CRON_EXP = '0 0 6 * * ?';

    @isTest static void testScheduledJob() {
        Test.startTest();
        String jobID = System.schedule('Remind property tenants', CRON_EXP, new FinishLeaseScheduler());
        Test.stopTest();
        CronTrigger ct = [SELECT TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobID];
    }
}

