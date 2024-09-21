import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../services/utils.dart';
import '../../view/app_pages.dart';

class AuthController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Utils utils = Utils();

  RxBool isLoading = false.obs;
  UserModel user = UserModel();

  Future<void> validateUser() async{
    print("validando usuario");
    if (_auth.currentUser != null){
      print("entrou no autenticado");
      try{
        print("vai consultar banco");
        //DocumentSnapshot usuarioSnapshot = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
        DocumentSnapshot usuarioSnapshot = await _firestore.collection('users').doc('JwSC9se280XgW4XVeGAGTQQuziF2').get();
        print("vai mapear");
        if(usuarioSnapshot.exists) {
          print("existe");
          Map? usuario = usuarioSnapshot.data() as Map;
        }else{
          print("nao existe");
        }

        print("vai printar usuario");
        //print(usuario);
  //
        print(_auth.currentUser!.phoneNumber);

        //user.uid = _auth.currentUser!.uid;
        //user.email = _auth.currentUser!.email;
        //user.name = usuario['nome'];
        //user.celphone = usuario['celular'];
  //       user.cpf = usuario['cpf'];
  //       user.cep = usuario['cep'];
  //       user.endereco = usuario['endereco'];
  //       user.numero = usuario['numero'];
  //       user.complemento = usuario['complemento'];
  //       user.pontoreferencia = usuario['ponto_ref'];
  //       user.bairro = usuario['bairro'];
  //       user.cidade = usuario['cidade'];
  //       user.uf = usuario['uf'];
  //       user.estabelecimento = usuario['estabelecimento'] ?? "";
  //       user.adm = usuario['adm'] ?? false;
  //       user.distancia = usuario['distancia'].toInt();
  //
  //       await atualizaDadosEntrega();
  //       carregaEstabelecimentos();
  //       saveTokenMsg();
  //       verificaAtivo();
        Get.offAllNamed(PagesRoutes.baseRoute);
      }catch(e){
        print("erro");
        print(e.toString());
  //       signOut();
      }
    }else{
      print("nao autenticado, chamando tela de login...");
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

  Future<void> concluirCadastro({required String name}) async {
    isLoading.value = true;
    try {
      if (name.isNotEmpty){
        await _firestore.collection("usuarios").doc(_auth.currentUser!.uid).set({
          'name': name,
          'email': _auth.currentUser!.email ?? '',
          'celular': _auth.currentUser!.phoneNumber ?? '',
        });
        utils.showToast(msg: 'Cadastrado concluído!', isSuccess: true);
      }
    } catch (e){
      print(e);
      utils.showToast(msg: 'Ocorreu um erro!', isError: true);
    }
    isLoading.value = false;
  }

}