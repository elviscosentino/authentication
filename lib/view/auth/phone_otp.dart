import 'package:authentication/view/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/otpimage.jpg"),
            const Text("Código de verificação",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text("Para cadastrar seu celular, informe abaixo o código recebido via SMS:",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  controller: otpController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Digite o código recebido",
                      hintText: "1234"
                  )
              ),
            ),
            isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async{
                  setState(() {
                    isLoading = true;
                  });
                  try{
                    final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: otpController.text
                    );
                    await FirebaseAuth.instance.signInWithCredential(credential);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }catch(e){
                    print(e);
                  }
                  setState(() {
                    isLoading = false;
                  });
                  otpController.clear();
                },
                child: const Text("Confirmar código",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white
                  ),
                )
            )
          ],
        )
      ),
    );
  }
}
