trigger OpportunityTrigger on Opportunity (after insert, after update, after undelete, after delete) {
    
    Set<Id> accIds = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Opportunity op: Trigger.New){
            if(op.AccountId != null){
                accIds.add(op.AccountId);
            }
        }
    }
    
        if(Trigger.isDelete || Trigger.isUpdate){
        for(Opportunity opp: Trigger.Old){
            if(opp.AccountId != null){
                accIds.add(opp.AccountId);
            }
        }
    }
    
    if(accIds != null){
        AccountRevenueService.recalculate(accIds);
    }
}