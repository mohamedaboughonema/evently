import 'package:evently/utils/app_color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToastMessage {
  static Future<bool?> showMessage(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColor.black,
      textColor: AppColor.white,
      fontSize: 20.0,
    );
  }
}
