public with sharing class OpportunitySelector {

    public static List<Opportunity> getOpportunitiesByAccountId(Id accountId) {
        if (accountId == null) {
            return new List<Opportunity>(); // Protection contre null
        }
        
        return [
            SELECT Id, Name, Amount, CloseDate, StageName
            FROM Opportunity
            WHERE AccountId = :accountId
            ORDER BY CloseDate DESC
            LIMIT 100
        ];
    }
}
