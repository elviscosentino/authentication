import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth/auth_controller.dart';
import '../../services/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (_nameController.text == "") {
      _nameController.text = user?.displayName ?? '';
    }
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Completar dados do cadastro"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 2.8,
                child: Image.asset("assets/signup.jpeg"),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: _nameController,
                      icon: Icons.person, label: 'Digite seu nome',
                      validator: nameValidator,
                    ),
                    GetX<AuthController>(
                      builder: (authController) {
                        return CustomButton(
                          isThinking: authController.isLoading.value,
                          onPressed: () async {
                            FocusScope.of(context).unfocus(); // retira o foco dos campos que automaticamente fecha o teclado.
                            if (_formKey.currentState!.validate()){
                              await authController.registerUser(context, name: _nameController.text);
                            }
                          },
                          text: "Concluir cadastro"
                        );
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
