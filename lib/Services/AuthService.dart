import 'package:json_feed/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  static final IS_LOGIN = 'is_login';
  static final USERNAME = 'username';

  Future login({User user}) async{
    if(user.Username == 'admin@gmail.com' && user.Password == 'password'){

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString(USERNAME, user.Username);
      _prefs.setBool(IS_LOGIN, true);

      return true;
    }
    return false;
  }

  Future<bool> isLogin()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(IS_LOGIN) ?? false;
  }

  Future logout() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(IS_LOGIN);

    return await Future<void>.delayed(Duration(seconds:1));
  }
}