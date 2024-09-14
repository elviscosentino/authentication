import 'package:authentication/controller/auth/auth_google.dart';
import 'package:authentication/controller/auth/authentication.dart';
import 'package:authentication/view/widgets/custom_button.dart';
import 'package:authentication/view/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    // Verificar o provedor de autenticação usado
    String? photoUrl = user?.photoURL;
    String providerId = user?.providerData[0].providerId ?? "unknown";

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
              await FirebaseServices().googleSignOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
            }, text: "Logout"),
            if (photoUrl != null && photoUrl.isNotEmpty)
              Image.network("${FirebaseAuth.instance.currentUser!.photoURL}")
            else
              const Icon(Icons.person, size: 80, color: Colors.grey),
            Text("${FirebaseAuth.instance.currentUser!.email}"),
            Text("${FirebaseAuth.instance.currentUser!.displayName}"),
            const SizedBox(height: 20),
            Text("Método de autenticação: $providerId"),

          ],
        ),
      ),
    );
  }
}
