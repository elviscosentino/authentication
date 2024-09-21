import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Text("SPLASH", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
          //SizedBox(height: 20),
          SizedBox(
            height: 50.0,
            width: 50.0,
            child: Column(
              children: [
                //CircularProgressIndicator(color: CustomColors.primarySwatch),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
