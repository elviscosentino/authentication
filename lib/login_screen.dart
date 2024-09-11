import 'package:authentication/custom_button.dart';
import 'package:authentication/signup_screen.dart';
import 'package:authentication/snackbar.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';
import 'custom_textfield.dart';
import 'home_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    String res = await Authentication().loginUser(
        email: emailController.text,
        password: passwordController.text,
    );
    if (res == "sucesso"){
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    }else{
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 2.7,
                child: Image.asset("assets/login.jpg"),
              ),
              CustomTextfield(
                textEditingController: emailController,
                hintText: "Digite seu e-mail",
                icon: Icons.email,
              ),
              CustomTextfield(
                textEditingController: passwordController,
                hintText: "Digite sua senha",
                isPass: true,
                icon: Icons.lock,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Esqueceu a senha?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue
                    ),
                  ),
                ),
              ),
              CustomButton(onTap: loginUser, text: "Login"),
              SizedBox(height: height / 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Não tem cadastro?", style: TextStyle(fontSize: 16),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const SignupScreen())
                      );
                    },
                    child: const Text(
                      " Cadastrar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
