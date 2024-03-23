//This class is used to perform user operations from different parts of the app


class UserOperations {
  //Create user
  Map<String, dynamic> createUser(bool newUser, String email, String name,
      String lastName, String profession, String description) {
    //Map
    Map<String, dynamic> userMap = {
      'newuser': newUser,
      'email': email,
      'name': name,
      'lastname': lastName,
      'profession': profession,
      'description': description,
    };

    //Return map
    return userMap;
  }
}
