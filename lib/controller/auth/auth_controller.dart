import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/user_model.dart';
import '../../services/messages.dart';
import '../../view/app_pages.dart';

class AuthController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final googleSignIn = GoogleSignIn();
  final Messages msg = Messages();

  RxBool isLoading = false.obs;
  RxBool isLoading2 = false.obs;
  UserModel user = UserModel();
  String? _verificationId;
  RxBool smsEnviado = false.obs;

  Future<void> validateUser() async{
    debugPrint("validando usuario");
    if (_auth.currentUser != null){
      debugPrint("entrou no autenticado");
      try{
        debugPrint("vai consultar banco");
        DocumentSnapshot usuarioSnapshot = await _firestore.collection('usuarios').doc(_auth.currentUser!.uid).get();
        //DocumentSnapshot usuarioSnapshot = await _firestore.collection('users').doc('JwSC9se280XgW4XVeGAGTQQuziF2').get();
        if(usuarioSnapshot.exists) {
          debugPrint("existe");
          debugPrint("vai mapear");
          Map? usuario = usuarioSnapshot.data() as Map;

          debugPrint("vai printar usuario");
          debugPrint(usuario.toString());
          //debugPrint(_auth.currentUser!.phoneNumber);

          user.uid = _auth.currentUser!.uid;
          user.email = _auth.currentUser!.email;
          user.name = usuario['nome'];
          user.celphone = usuario['celular'];
          // user.distancia = usuario['distancia'].toInt();

          Get.offAllNamed(PagesRoutes.baseRoute);
        }else{
          debugPrint("nao existe");
          Get.offAllNamed(PagesRoutes.registerUserRoute);
        }
      }catch(e){
        debugPrint("erro");
        debugPrint(e.toString());
  //       signOut();
      }
    }else{
      debugPrint("nao autenticado, chamando tela de login...");
  //     //utilServices.showToast(msg: 'Token nao encontrado!', isError: true);
  //     //print("chamou signout do validate");
  //     signOut();
      Get.offAllNamed(PagesRoutes.loginRoute);
    }
  //   //initialRoute: user.uid == null ? PagesRoutes.cepRoute : PagesRoutes.baseRoute
  //   //} else {
  //   //  signOut();
  //   //}
  //   //}
  //   /*
  //   print("logado!");
  //   print(_auth.currentUser?.email);
  //   //Get.offAllNamed(PagesRoutes.baseRoute);
  //   //return;
  //   user.uid = _auth.currentUser?.uid;
  //   user.email = _auth.currentUser?.email;
  //   print(user.email);
  //   */
  }

  Future<void> signUp(BuildContext context, {required String email, required String password}) async{
    isLoading.value = true;
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      debugPrint("novo usuario: ${_auth.currentUser?.uid}");
      if (_auth.currentUser?.uid != null){
        await validateUser();
      }else{
        if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
        msg.showSnackBar(context, 'Erro ao criar cadastro!', Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'email-already-in-use'){
        if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
        msg.showSnackBar(context, 'E-mail já cadastrado. Se não souber a senha, selecione "Esqueceu a senha?" na tela anterior.', Colors.red);
      }else {
        if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
        msg.showSnackBar(context, 'Erro ao criar cadastro!', Colors.red);
      }
    }
    isLoading.value = false;
  }

  Future<void> loginEmail(BuildContext context, {required String email, required String password}) async {
    isLoading.value = true;
    try {
      //await Future.delayed(const Duration(seconds: 3));
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      await validateUser();
    } catch (e){
      if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
      msg.showSnackBar(context, 'Login inválido!', Colors.red);
    }
    isLoading.value = false;
  }

  Future<void> loginGoogle(BuildContext context) async {
    isLoading2.value = true;
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken
        );
        await _auth.signInWithCredential(authCredential);
        await validateUser();
      }
    } on FirebaseAuthException catch (e){
      debugPrint(e.toString());
      if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
      msg.showSnackBar(context, 'Erro ao fazer login!', Colors.red);
      //msg.showSnackBar(context, e.toString(), Colors.red);
    } catch (e){
      debugPrint(e.toString());
      if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
      msg.showSnackBar(context, 'Erro ao fazer login!', Colors.red);
    }
    isLoading2.value = false;
  }

  Future<void> loginPhone(BuildContext context, {required String phone}) async {
    isLoading.value = true;
    await _auth.verifyPhoneNumber(
      phoneNumber: '+55$phone',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
        debugPrint("Login com sucesso!");
        isLoading.value = false;
        await validateUser();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          debugPrint('O número de telefone fornecido é inválido.');
        } else {
          debugPrint('Falha na verificação: ${e.message}');
        }
        isLoading.value = false;
      },
      codeSent: (verificationId, resendToken) {
        _verificationId = verificationId;
        debugPrint("Código de verificação enviado.");
        //print(_verificationId);
        isLoading.value = false;
        smsEnviado.value = true;
        msg.showSnackBar(context, 'Código de verificação enviado.', Colors.green);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
        debugPrint("Código de verificação timeout.");
        //print(_verificationId);
        isLoading.value = false;
      }
    );
  }

  Future<void> loginPhoneCode(BuildContext context, {required String smsCode}) async {
    isLoading2.value = true;
    if (_verificationId != null) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      try {
        await _auth.signInWithCredential(credential);
        await validateUser();
        smsEnviado.value = false;
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
        if (e.code == 'invalid-verification-code'){
          debugPrint('O código informado é inválido.');
          msg.showSnackBar(context, 'O código informado é inválido.', Colors.red);
        } else {
          debugPrint('Falha na verificação: ${e.toString()}');
          msg.showSnackBar(context, e.toString(), Colors.red);
        }
      }
    }
    isLoading2.value = false;
  }

  Future<void> logout() async {
    if (_auth.currentUser?.providerData[0].providerId == "google.com"){
      await googleSignIn.signOut();
    }
    await _auth.signOut();
    Get.offAllNamed(PagesRoutes.loginRoute);
  }

  Future<void> registerUser(BuildContext context, {required String name}) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> userData = {
        'name': name,
      };
      if (_auth.currentUser!.email != null && _auth.currentUser!.email!.isNotEmpty) {
        userData['email'] = _auth.currentUser!.email;
      }
      if (_auth.currentUser!.phoneNumber != null && _auth.currentUser!.phoneNumber!.isNotEmpty) {
        userData['celular'] = _auth.currentUser!.phoneNumber;
      }
      await _firestore.collection("usuarios").doc(_auth.currentUser!.uid).set(userData);
      if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
      msg.showSnackBar(context, 'Cadastro concluído!', Colors.green);
      await validateUser();
    } catch (e){
      debugPrint(e.toString());
      if (!context.mounted) return; // para evitar o erro do 'Do not use BuildContext across async gaps'
      msg.showSnackBar(context, 'Ocorreu um erro!', Colors.red);
    }
    isLoading.value = false;
  }
}