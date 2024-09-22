import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth/auth_controller.dart';
import '../../services/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
class EmailSignupScreen extends StatelessWidget {
  EmailSignupScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cadastre-se"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Aqui usa o Get.back() para voltar à página anterior
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            controller: _emailController,
                            icon: Icons.email, label: 'Digite seu e-mail',
                            keyboard: TextInputType.emailAddress,
                            validator: emailValidator
                        ),
                        CustomTextfield(
                            controller: _passwordController,
                            icon: Icons.lock, label: 'Defina uma senha',
                            isSecret: true,
                            validator: passwordValidator
                        ),
                        CustomTextfield(
                            controller: _password2Controller,
                            icon: Icons.lock, label: 'Digite a senha novamente',
                            isSecret: true,
                            validator: (value) => confirmPasswordValidator(value, _passwordController.text)
                        ),
                        const SizedBox(height: 8),
                        GetX<AuthController>(
                          builder: (authController) {
                            return CustomButton(
                              isThinking: authController.isLoading.value,
                              onPressed: () async {
                                FocusScope.of(context).unfocus(); // retira o foco dos campos que automaticamente fecha o teclado.
                                if (_formKey.currentState!.validate()){
                                  await authController.signUp(context, email: _emailController.text, password: _passwordController.text);
                                }
                              },
                              text: "Cadastrar"
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Já tem um cadastro?", style: TextStyle(fontSize: 16),),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: const Text(
                          " Fazer Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16,
                              color: Colors.blue
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
