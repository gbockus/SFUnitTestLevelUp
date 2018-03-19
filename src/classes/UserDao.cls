
public with sharing class UserDao {

  public static UserDao instance = new UserDao();

  public static UserDao getInstance() {
    return instance;
  }


  public User getContactOwner(Contact ownedContact) {
    List<User> users = [
        SELECT Id
        FROM User
        WHERE Id = :ownedContact.OwnerId
        LIMIT 1
    ];

    User ownerUsr = (users.size() == 1) ? users.get(0) : null;

    return ownerUsr;
  }
}