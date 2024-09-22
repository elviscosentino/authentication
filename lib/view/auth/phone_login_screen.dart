import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth/auth_controller.dart';
import '../../services/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
class PhoneLoginScreen extends StatelessWidget {
  PhoneLoginScreen({super.key});
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login com nº de celular"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Aqui usa o Get.back() para voltar à página anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: GetX<AuthController>(
                  builder: (authController) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: height / 2.8,
                          child: Image.asset("assets/otpimage.jpg"),
                        ),
                        CustomTextfield(
                          controller: _phoneController,
                          inputFormatters: [phoneFormatter],
                          icon: Icons.phone, label: 'Número de celular',
                          keyboard: TextInputType.phone,
                          validator: phoneValidator,
                          readOnly: authController.smsEnviado.value,
                        ),
                        !authController.smsEnviado.value
                        ? CustomButton(
                          isThinking: authController.isLoading.value,
                          onPressed: (){
                            FocusScope.of(context).unfocus(); // retira o foco dos campos que automaticamente fecha o teclado.
                            if (_formKey.currentState!.validate()){
                              authController.loginPhone(context, phone: _phoneController.text);
                            }
                          },
                          text: "Receber código por SMS"
                        )
                        : Column(
                          children: [
                            const SizedBox(height: 12),
                            const Text("Informe abaixo o código recebido via SMS:",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            CustomTextfield(
                              controller: _otpController,
                              icon: Icons.dialpad, label: 'Código de verificação',
                              keyboard: TextInputType.number,
                              //validator: numberValidator
                            ),
                            CustomButton(
                              isThinking: authController.isLoading2.value,
                              onPressed: (){
                                FocusScope.of(context).unfocus(); // retira o foco dos campos que automaticamente fecha o teclado.
                                if (_formKey.currentState!.validate()){
                                  authController.loginPhoneCode(context, smsCode: _otpController.text);
                                }
                              },
                              text: "Confirmar código"
                            )
                          ]
                        )
                      ]
                    );
                  }
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
