
public with sharing class AccountDao {
  private static AccountDao instance = new AccountDao();

  public static AccountDao getInstance() {
    return instance;
  }

  public List<Account> getAccounts() {
    List<Account> accounts = [
        select
        id, Name
        from account
    ];
    return accounts;
  }

  public void updateAccount(Account account) {
    update account;
  }
}