import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();
  static SPHelper spHelper = SPHelper._();

  SharedPreferences sharedPreferences;

  Future<SharedPreferences> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } else {
      return sharedPreferences;
    }
  }


  setUser(String value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setString('userId', value);
  }

  Future<String> getUser() async {
    sharedPreferences = await initSharedPrefrences();
    String x = sharedPreferences.getString('userId');
    return x;
  }
}
