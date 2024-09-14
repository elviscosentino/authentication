import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text, Color color){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      elevation: 10,
      content: Text(text, style: const TextStyle(fontWeight: FontWeight.w500),)
    )
  );
}