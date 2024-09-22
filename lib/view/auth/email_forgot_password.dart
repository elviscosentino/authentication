import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/messages.dart';
import '../../services/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}
class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final Messages msg = Messages();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          myDialogBox(context);
        },
        child: const Text(
          "Esqueceu a senha?",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue
          ),
        ),
      ),
    );
  }

  void myDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Esqueceu sua senha?",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: emailController,
                        icon: Icons.email, label: 'Digite seu e-mail',
                        keyboard: TextInputType.emailAddress,
                        validator: emailValidator
                      ),
                      CustomButton(
                        isThinking: isLoading,
                        onPressed: () async {
                          FocusScope.of(context).unfocus(); // retira o foco dos campos que automaticamente fecha o teclado.
                          if (_formKey.currentState!.validate()){
                            setState(() {
                              isLoading = true;
                            });
                            await auth.sendPasswordResetEmail(email: emailController.text)
                            .then((value){
                              if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
                              msg.showSnackBar(context, "Enviamos um link de reset para o seu e-mail, por favor verifique.", Colors.green);
                            })
                            .onError((error, stackTrace){
                              if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
                              msg.showSnackBar(context, error.toString(), Colors.red);
                            });
                            isLoading = false;
                            emailController.clear();
                            if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
                            Navigator.pop(context);
                          }
                        },
                        text: "Enviar"
                      ),
                    ]
                  ),
                ),
              ]
            ),
          ),
        );
      }
    );
  }
}