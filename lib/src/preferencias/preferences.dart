import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = new UserPreferences.internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences.internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get theme {
    return _prefs.getString('theme') ?? 'purple';
  }

  set theme(String value) {
    _prefs.setString('theme', value);
  }

  get cellphone {
    return _prefs.getString('cellphone');
  }

  set cellphone(String value) {
    _prefs.setString('cellphone', value);
  }

  get userId {
    return _prefs.getString('userId');
  }

  set userId(String value) {
    _prefs.setString('userId', value);
  }

  destroyData() {
    _prefs.clear();
  }
}
