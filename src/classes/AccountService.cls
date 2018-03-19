
public with sharing class AccountService {

  private static AccountService instance;

  @TestVisible
  private static void setMock(AccountService mock) {
    if (instance != null) {
      throw new ServiceException('The service was already mocked or accessed.');
    }
    instance = mock;
  }

  public static AccountService getInstance() {
    if (instance == null) {
      instance = new AccountService();
    }
    return instance;
  }

  public List<Account> getAccounts() {
    return AccountDao.getInstance().getAccounts();
  }

  public void updateAccountOwner(Contact contact, Account account) {
    User owner = UserDao.getInstance().getContactOwner(contact);
    if (owner != null) {
      account.ownerId = owner.Id;
      AccountDao.getInstance().updateAccount(account);
    } else {
      throw new ServiceException('Unable to find User for contact');
    }

  }

  public void fakeForTesting() {
    System.debug('No reason for this to be here.');
  }
}