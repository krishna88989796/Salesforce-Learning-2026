public with sharing class OpportunityRelatedListController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId) {
        return [
            SELECT Id, Name, StageName, Amount, CloseDate, Owner.Name
            FROM Opportunity
            WHERE AccountId = :accountId
            ORDER BY CreatedDate DESC
            LIMIT 50
        ];
    }
}