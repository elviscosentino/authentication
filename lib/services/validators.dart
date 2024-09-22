//import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'messages.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
final Messages msg = Messages();

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return 'Digite seu e-mail!';
  if (!value.isEmail) return 'Digite um e-mail válido!';
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Digite sua senha!';
  if (value.length < 6) return 'Digite uma senha com pelo menos 6 caracteres.';
  return null;
}

String? confirmPasswordValidator(String? value, String password) {
  if (value == null || value.isEmpty) return 'Digite sua senha!';
  if (value.length < 6) return 'Digite uma senha com pelo menos 6 caracteres.';
  if (value != password) return 'As senhas não coincidem.';
  return null;
}

String? nameValidator(String? value){
  if (value == null || value.isEmpty) return 'Digite um nome!';
  if (value.split(' ').length == 1) return 'Digite seu nome completo!';
  return null;
}

String? phoneValidator(String? value){
  if (value == null || value.isEmpty) return 'Digite um celular!';
  if (value.length < 15 || !value.isPhoneNumber) return 'Digite um número válido!';
  return null;
}
final phoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: {'#': RegExp(r'[0-9]')});

String? cpfValidator(String? value){
  if (value == null || value.isEmpty) return 'Digite um CPF!';
  if (!value.isCpf) return 'Digite um CPF válido!';
  return null;
}
final cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});

String? cepValidator(String? value){
  if (value == null || value.isEmpty) return 'Digite um CEP!';
  if (value.length < 9) return 'Digite um CEP válido!';
  return null;
}
final cepFormatter = MaskTextInputFormatter(mask: '#####-###', filter: {'#': RegExp(r'[0-9]')});

String? numeroValidator(String? value) {
  if (value == null || value.isEmpty) return 'Digite o número!';
  return null;
}

// String? validadeCartaoValidator(String? value) {
//   String? erro;
//
//   DateTime now = DateTime.now();
//   String year = now.year.toString();
//   String month = now.month.toString().padLeft(2, '0');
//   //print("Ano: $year, Mês: $month");
//   //print(int.parse((value?.split('/')[1] ?? '') + (value?.split('/')[0] ?? '')));
//
//   if (value == null || value.isEmpty) {
//     erro = 'Digite a validade!';
//   } else if (value.length < 7 || int.parse(value.split('/')[0]) >= 13 || int.parse(value.split('/')[1] + value.split('/')[0]) <= int.parse("$year$month")) {
//     erro = 'Digite uma data válida!';
//   }
//   if (erro != null) msg.showToast(msg: erro, isError: true, toastGravity: ToastGravity.TOP);
//   return erro;
// }
// final validadeCartaoFormatter = MaskTextInputFormatter(
//     mask: '!#/@%##',
//     filter: {
//       '#': RegExp(r'[0-9]'),
//       '!': RegExp(r'[0-1]'),
//       '@': RegExp(r'[2]'),
//       '%': RegExp(r'[0]'),
//     }
// );

// String? cardNumberValidator(String? value) {
//   String? erro;
//   if (value == null || value.isEmpty) erro = 'Digite o número do cartão!';
//   if ((value?.length ?? 0) < 19 || detectCCType(value!).isEmpty) erro = 'Número de cartão inválido!';
//   if (erro != null) msg.showToast(msg: erro, isError: true, toastGravity: ToastGravity.TOP);
//   return erro;
// }
// final cardNumberFormatter = MaskTextInputFormatter(mask: '#### #### #### ####', filter: {'#': RegExp(r'[0-9]')});
//
// String? cvvValidator(String? value) {
//   String? erro;
//   if (value == null || value.isEmpty) {
//     erro = 'Digite o CVV!';
//   } else if (value.length < 3) {
//     erro = 'CVV inválido!';
//   }
//   if (erro != null) msg.showToast(msg: erro, isError: true, toastGravity: ToastGravity.TOP);
//   return erro;
// }
// final cvvFormatter = MaskTextInputFormatter(mask: '###', filter: {'#': RegExp('[0-9]')});
