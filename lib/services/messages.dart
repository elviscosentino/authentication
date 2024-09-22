import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Messages {
  void showToast({required String msg, bool isError = false, bool isSuccess = false, ToastGravity toastGravity = ToastGravity.BOTTOM}){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: toastGravity,
        timeInSecForIosWeb: 3,
        backgroundColor: isError ? Colors.red : isSuccess ? Colors.green : Colors.grey,
        textColor: isError ? Colors.white : isSuccess ? Colors.black : Colors.black,
        fontSize: 14
    );
  }

  showSnackBar(BuildContext context, String text, Color color){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        elevation: 10,
        content: Text(text, style: const TextStyle(fontWeight: FontWeight.w500),)
      )
    );
  }
}