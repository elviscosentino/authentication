import 'package:authentication/controller/auth/auth_google.dart';
import 'package:authentication/view/widgets/custom_button.dart';
import 'package:authentication/view/auth/forgot_password.dart';
import 'package:authentication/view/auth/phone_login.dart';
import 'package:authentication/view/auth/signup_screen.dart';
import 'package:authentication/view/widgets/snackbar.dart';
import 'package:flutter/material.dart';

import '../../controller/auth/authentication.dart';
import '../widgets/custom_textfield.dart';
import '../home_screen.dart';
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
      showSnackBar(context, res, Colors.red);
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
                height: height / 3.1,
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
              const ForgotPassword(),
              CustomButton(onTap: loginUser, text: "Login"),
              Row(
                children: [
                  Expanded(child: Container(height: 1, color: Colors.black45)),
                  const Text("  ou  "),
                  Expanded(child: Container(height: 1, color: Colors.black45))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                  onPressed: () async {
                    bool res = await FirebaseServices().signInWithGoogle();
                    print(res);
                    if (res) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    }
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Image.network("https://ouch-cdn2.icons8.com/VGHyfDgzIiyEwg3RIll1nYupfj653vnEPRLr0AeoJ8g/rs:fit:456:456/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODg2/LzRjNzU2YThjLTQx/MjgtNGZlZS04MDNl/LTAwMTM0YzEwOTMy/Ny5wbmc.png",
                          height: 35,
                        ),
                      ),
                      const Text("  Continuar com o Google",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white
                        ),
                      )
                    ],
                  )
                )
              ),
              PhoneAuthentication(),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 100),
                child: Row(
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
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
