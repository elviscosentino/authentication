import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../home/home_screen.dart';
import '../../controller/auth/auth_email.dart';
import 'login_screen.dart';
import '../widgets/snackbar.dart';
class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({super.key});
  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}
class _EmailSignupScreenState extends State<EmailSignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signupUser() async {
    String res = await Authentication().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text
    );
    if (res == "Cadastrado com sucesso!"){
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen())
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
                  height: height / 2.8,
                  child: Image.asset("assets/signup.jpeg"),
                ),
                CustomTextfield(
                  textEditingController: nameController,
                  hintText: "Digite seu nome",
                  icon: Icons.person,
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
                CustomButton(onTap: signupUser, text: "Cadastrar"),
                SizedBox(height: height / 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Já tem um cadastro?", style: TextStyle(fontSize: 16),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const LoginScreen())
                        );
                      },
                      child: const Text(
                        " Fazer Login",
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
