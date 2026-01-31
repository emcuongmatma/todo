import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/core/theme/colors.dart';

void showToast({String? msg , bool isLong = false}) {
  if (msg == null) return;
  Fluttertoast.showToast(
      msg: msg,
      toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorDark.whiteFocus,
      textColor: ColorDark.bottomNavigationBackground,
      fontSize: 16.0
  );
}