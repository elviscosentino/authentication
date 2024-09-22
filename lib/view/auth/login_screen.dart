import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_pages.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../auth/email_forgot_password.dart';
import '../../controller/auth/auth_controller.dart';
import '../../services/validators.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height / 3.1,
                  child: Image.asset("assets/login.jpg"),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: _emailController,
                        icon: Icons.email, label: 'E-mail',
                        keyboard: TextInputType.emailAddress,
                        validator: emailValidator
                      ),
                      CustomTextfield(
                        controller: _passwordController,
                        icon: Icons.lock, label: 'Senha',
                        isSecret: true,
                        validator: passwordValidator
                      ),
                      const ForgotPassword(),
                      const SizedBox(height: 12),
                      GetX<AuthController>(
                        builder: (authController) {
                          return CustomButton(
                            isThinking: authController.isLoading.value,
                            onPressed: (){
                              //FocusScope.of(context).unfocus(); // retira o foco dos campos que automaticamente fecha o teclado.
                              if (_formKey.currentState!.validate()){
                                authController.loginEmail(context, email: _emailController.text, password: _passwordController.text);
                              }
                            },
                            text: "Login"
                          );
                        }
                      ),
                    ]
                  )
                ),
                SizedBox(
                  height: 32,
                  child: Row(
                    children: [
                      Expanded(child: Container(height: 1, color: Colors.black45)),
                      const Text("  ou  "),
                      Expanded(child: Container(height: 1, color: Colors.black45))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GetX<AuthController>(
                    builder: (authController) {
                      return Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                            onPressed: (){
                              authController.loginGoogle(context);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Image.network("https://ouch-cdn2.icons8.com/VGHyfDgzIiyEwg3RIll1nYupfj653vnEPRLr0AeoJ8g/rs:fit:456:456/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODg2/LzRjNzU2YThjLTQx/MjgtNGZlZS04MDNl/LTAwMTM0YzEwOTMy/Ny5wbmc.png",
                                    height: 30,
                                  ),
                                ),
                                authController.isLoading2.value
                                ? const Expanded(child: Center(child: SizedBox(width: 29, height: 29, child: CircularProgressIndicator(color: Colors.white))))
                                : const Text("  Continuar com o Google",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white
                                  ),
                                )
                              ],
                            )
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              onPressed: (){
                                authController.smsEnviado.value = false;
                                Get.toNamed(PagesRoutes.loginPhoneRoute);
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Image.network("https://static.vecteezy.com/system/resources/thumbnails/010/829/986/small/phone-icon-in-trendy-flat-style-free-png.png",
                                      height: 28,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text("   Login com nº de celular",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Não tem cadastro?", style: TextStyle(fontSize: 16),),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(PagesRoutes.signUpRoute);
                      },
                      child: const Text(
                        " Cadastrar",
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
