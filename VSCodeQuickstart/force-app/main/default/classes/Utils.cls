public  class Utils {
  
        public static final EmailTemplate remindEndRentTemplate = [SELECT id FROM EmailTemplate WHERE Name = 'Remind property tenants' LIMIT 1];
    
        public static void checkDatabaseSaveResults(List<Database.SaveResult> saveResults,
                                                     List<SObject> records, String errorSource) {
            String logMsg = '';
            for (Integer i = 0; i < saveResults.size(); i++) {
                if (saveResults[i].isSuccess()) continue;
                logMsg += 'DML operation failed for record: ' + records[i].Id + '\ncause:\n';
    
                for (Database.Error err: saveResults[i].getErrors()) {
                    logMsg += err.getMessage() + '\n';
                }
            }
    
            if (String.isBlank(logMsg)) LogManager.createLog(errorSource, logMsg, true);
        }

        public static String startDealEndRentalScheduler() {
            DealEndRentalScheduler reminder = new DealEndRentalScheduler();
            String sch = '0 0 6 * * ?';
            String jobID = System.schedule('Remind property tenants', sch, reminder);
            return jobID;
        }

        public static void sendEmailToFinishLease(List<Deal__c> deals) {
            List<Messaging.SingleEmailMessage> massage = new List<Messaging.SingleEmailMessage>();
            for (Deal__c deal : deals) {
                Messaging.Singleemailmessage email = new Messaging.Singleemailmessage();
                email.setReplyTo(deal.Buyer__r.Email);
                massage.add(email);
            }
    
            Messaging.sendEmail(massage, false);
        }
}
