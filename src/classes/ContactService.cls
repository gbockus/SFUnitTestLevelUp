
public with sharing class ContactService {

  private static ContactService instance;

  @TestVisible
  private static void setMock(ContactService mock) {
    if (instance != null) {
      throw new ServiceException('The service was already mocked or accessed.');
    }
    instance = mock;
  }

  public static ContactService getInstance() {
    if (instance == null) {
      instance = new ContactService();
    }
    return instance;
  }

  public List<Contact> getContacts() {
    return ContactDao.getInstance().getContacts();
  }

}