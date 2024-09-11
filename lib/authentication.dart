
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({required String email, required String password, required String name}) async {
    String res = " Ocorreu um erro!";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty){
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        await _firestore.collection("users").doc(credential.user!.uid).set({
          'name': name,
          'email': email,
          'uid': credential.user!.uid,
        });
        res = "Cadastrado com sucesso!";
      }
    } catch (e){
      return e.toString();
    }
    return res;
  }

  Future<String> loginUser({required String email, required String password}) async {
    String res = " Ocorreu um erro!";
    try {
      if (email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(
            email: email,
            password: password
        );
        res = "sucesso";
      }else{
        res = "Por favor preencha todos os campos";
      }
    } catch (e){
      return e.toString();
    }
    return res;
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}