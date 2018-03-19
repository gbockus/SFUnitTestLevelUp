
public with sharing class BadController {

  @AuraEnabled
  public static List<Account> getAccounts() {
    List<Account> accounts = [select Id, Name from Account];
    return accounts;
  }

  @AuraEnabled
  public static List<Contact> getContacts() {
    List<Contact> contacts = [select id, FirstName, LastName from Contact];
    return contacts;
  }

  @AuraEnabled
  public static boolean assignContactToAccount(Account selectedAccount, Contact selectedContact) {
    User owner = [SELECT Id FROM User WHERE Id = :selectedContact.OwnerId];
    selectedAccount.OwnerId = owner.Id;
    try {
      update selectedAccount;
    } catch(Exception e) {
      return false;
    }
    return true;
  }
}