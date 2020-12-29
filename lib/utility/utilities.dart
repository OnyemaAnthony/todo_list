import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility {
  static String todoTable = 'todoTable';
  static String id = 'id';
  static String task = 'task';
  static String deadline = 'deadLine';

  static void showLongErrorToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  static Center showCirclarLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
