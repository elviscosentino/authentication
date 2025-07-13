import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../../controller/auth/auth_controller.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    // Verificar o provedor de autenticação usado
    String? photoUrl = user?.photoURL;
    String providerId = user?.providerData[0].providerId ?? "unknown";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Parabéns\nVocê se logou com sucesso!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              )),
              CustomButton(onPressed: () async {
                await AuthController().logout();
              }, text: "Logout"),
              if (photoUrl != null && photoUrl.isNotEmpty)
                Image.network("${FirebaseAuth.instance.currentUser!.photoURL}")
              else
                const Icon(Icons.person, size: 80, color: Colors.grey),
              Text("${user!.email}"),
              Text("${user.displayName}"),
              const SizedBox(height: 20),
              Text("Método de autenticação: $providerId"),
            ],
          ),
        ),
      ),
    );
  }
}
