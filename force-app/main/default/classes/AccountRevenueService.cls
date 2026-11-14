public class AccountRevenueService {
    
    public static void recalculate(Set<Id> accIds){
        Map<Id, Decimal> revenueByAccount = new Map<Id, Decimal>();
        
        For(AggregateResult ar: [Select AccountId, SUM(Amount) annualRevenue From Opportunity 
                                 Where AccountId IN :accIds AND StageName ='Closed Won' Group By AccountId]){
                                     revenueByAccount.put((Id)ar.get('AccountId'), (Decimal)ar.get('annualRevenue'));
                                 }
        
        List<Account> accToUpdate = new List<Account>();
        for(Id acc: revenueByAccount.keySet()){
            Account account = new Account(Id=acc,AnnualRevenue=revenueByAccount.get(acc));
            accToUpdate.add(account);
            
        }
        
        if(accToUpdate != null){
            update accToUpdate;
        }
    }
    
    

}