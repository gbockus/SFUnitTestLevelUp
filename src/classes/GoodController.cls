
public with sharing class GoodController {
  public static final String ACCOUNT_ERROR = 'Unable to load Accounts';
  public static final String CONTACTS_ERROR = 'Unable to load Contacts';
  public static final String OWNER_ERROR = 'Unable to set Account Owner';


  @AuraEnabled
  public static List<Account> getAccounts() {
    try {
      return  AccountService.getInstance().getAccounts();
    } catch (Exception e) {
      AuraHandledException auraException =  new AuraHandledException(ACCOUNT_ERROR);
      auraException.setMessage(ACCOUNT_ERROR);
      throw auraException;
    }
  }

  @AuraEnabled
  public static List<Contact> getContacts() {
    try {
      return ContactService.getInstance().getContacts();
    } catch (Exception e) {
      AuraHandledException auraException =  new AuraHandledException(CONTACTS_ERROR);
      auraException.setMessage(CONTACTS_ERROR);
      throw auraException;
    }
  }

  @AuraEnabled
  public static boolean assignContactToAccount(Account selectedAccount, Contact selectedContact) {
    try {
      AccountService.getInstance().updateAccountOwner(selectedContact, selectedAccount);
      return true;
    } catch(Exception e) {
      AuraHandledException auraException =  new AuraHandledException(OWNER_ERROR);
      auraException.setMessage(OWNER_ERROR);
      throw auraException;
    }
  }
}