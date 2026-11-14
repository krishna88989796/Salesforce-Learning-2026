/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-14-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountService {
    public Account createAccount(String accName, String accNumber) {
        Account acc = new Account(
        Name = accName,
        AccountNumber = accNumber);
        
        return acc;
    }
}