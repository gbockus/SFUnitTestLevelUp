
public with sharing class ContactDao {

  private static ContactDao instance = new ContactDao();

  public static ContactDao getInstance() {
    return instance;
  }

  public List<Contact> getContacts() {
    List<Contact> contacts = [
        select Id, FirstName, LastName
        from Contact
    ];
    return contacts;
  }

  public void updateContact(Contact contactToUpdate) {
    update contactToUpdate;
  }
}