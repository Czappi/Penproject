import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Models/User.dart';

class UserProvider {
  User user;

  var _ud = UserDatabase.db;
  Future<void> getLoggedinUser() async {
    var lu = await _ud.getUserbyLastLoggedIn();

    if (lu != null) user = lu;
  }
}
