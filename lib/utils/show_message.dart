// import 'package:flutter/material.dart';
// import 'package:overlay_support/overlay_support.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
//
// showSnackBar(
//   ScaffoldState snackBarState,
//   BuildContext context, {
//   String title,
//   String message,
// }) {
//   final snackBar = SnackBar(content: Text(message));
//   snackBarState.showSnackBar(
//     snackBar,
//   );
// }
//
// Future showToastLong(String msg) {
//   // return Fluttertoast.showToast(
//   //     msg: msg,
//   //     toastLength: Toast.LENGTH_LONG,
//   //     gravity: ToastGravity.BOTTOM,
//   //     textColor: Colors.white,
//   //     fontSize: 16.0);
// }
//
// Future showToastShort(String msg) {
//   // return Fluttertoast.showToast(
//   //     msg: msg,
//   //     toastLength: Toast.LENGTH_SHORT,
//   //     gravity: ToastGravity.BOTTOM,
//   //     textColor: Colors.white,
//   //     fontSize: 16.0);
//
// //  return Fluttertoast.showToast(
// //      msg: msg,
// //      toastLength: Toast.LENGTH_SHORT,
// //      gravity: ToastGravity.BOTTOM,
// //      timeInSecForIos: 1);
// }
//
// void showMessage(BuildContext context, String title, String message,
//     {NotificationPosition position = NotificationPosition.top}) {
//   showSimpleNotification(
//     Text(
//       title,
//       style: TextStyle(fontSize: 14, color: Colors.white),
//     ),
//     leading: Icon(Icons.done_all, color: Colors.white),
//     duration: Duration(seconds: 2),
//     subtitle: Text(
//       message,
//       style: TextStyle(fontSize: 12, color: Colors.white),
//     ),
//     position: position,
//     slideDismiss: true,
//     autoDismiss: true,
//     background: Theme.of(context).primaryColor.withOpacity(0.85),
//   );
// }
