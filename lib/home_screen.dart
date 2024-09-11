import 'package:authentication/authentication.dart';
import 'package:authentication/custom_button.dart';
import 'package:authentication/login_screen.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Parabéns\nVocê se logou com sucesso!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
            )),
            CustomButton(onTap: () async {
              await Authentication().logoutUser();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
            }, text: "Logout")
          ],
        ),
      ),
    );
  }
}
