import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../home/home_screen.dart';
import '../../controller/auth/auth_email.dart';
import 'login_screen.dart';
import '../widgets/snackbar.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
  }
  void signupUser() async {
    // String res = await Authentication().signUpUser(
    //     email: emailController.text,
    //     password: passwordController.text,
    //     name: nameController.text
    // );
    // if (res == "Cadastrado com sucesso!"){
    //   setState(() {
    //     isLoading = false;
    //   });
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => HomeScreen())
    //   );
    // }else{
    //   setState(() {
    //     isLoading = false;
    //   });
    //   showSnackBar(context, res, Colors.red);
    // }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            GetX<AuthController>(
                builder: (authController) {
                  return CustomButton(
                    onTap: signupUser,
                    text: "Concluir cadastro"
                  );
              }
            ),
          ],
        ),
      ),
    );
  }
}
