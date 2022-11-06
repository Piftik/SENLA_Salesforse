public class RESTWrappers {
    public class DealWrapper{
        public Id deal_Object {get; set;}
        public Id realtor {get; set;}
        public Id seller {get; set;}
        public Date leaseStartDate {get; set;}
        public Date leaseEndDate {get; set;}
        public Decimal revenue {get; set;}

        public DealWrapper(Deal__c deal) {
            this.Deal_Object = deal.Deal_Object__c;
            this.realtor = deal.Buyer__c;
            this.seller = deal.Seller__c;
            this.leaseStartDate = deal.Leasing_Begins_From__c;
            this.leaseEndDate = deal.Leasing_Ends_To__c;
            this.revenue = deal.Leasing_Price_Net__c;
        }
    }

    public class Client {
        public String sfId {get; set;}
        public String firstName {get; set;}
        public String lastName {get; set;}
        public String email {get; set;}

        public Client(Client buyer) {
            this.sfId = buyer.sfId;
            this.firstName = buyer.FirstName;
            this.lastName = buyer.LastName;
            this.email = buyer.Email;
        }
    }

    public class changeOwnerWrapper {
        public String propertyId {get; set;}
        public Client newOwner {get; set;}
    }

    public class Response {
        public Date startDate {get; set;}
        public Date endDate {get; set;}
        public String totalRevenue {get; set;}
        public List<DealWrapper> deals {get; set;}

        public Response (Date startDate, Date endDate, List<Deal__c> deals) {
            this.startDate = startDate;
            this.endDate = endDate;
            List<DealWrapper> deals_buffer = new List<DealWrapper>();
            Decimal revenue = 0;
            for (Deal__c deal : deals) {
                deals_buffer.add(new DealWrapper(deal));
                if (deal.RecordType.DeveloperName == 'Lease') {
                    revenue += deal.Leasing_Price_Net__c;
                }
            }
            this.totalRevenue = String.valueOf(revenue);
        }
    }
}