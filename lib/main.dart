import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'controller/auth/auth_controller.dart';
import 'services/firebase_options.dart';
import 'view/splash_screen.dart';
import 'view/app_pages.dart';

Future<void> main() async {
  runApp(const SplashScreen());
  WidgetsFlutterBinding.ensureInitialized();
  //NotificationService().initNotification(); // Inicializa as notificacoes
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  //Get.lazyPut(()=>AuthController());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.blue,
          seedColor: Colors.blue
        ),
        useMaterial3: true,
      ),
      onReady: () async{
        //debugPrint("onReady do main");
        final authController = Get.find<AuthController>();
        await authController.validateUser();
      },
      getPages: AppPages.pages,
      initialRoute: PagesRoutes.splashRoute,

      //home: LoginScreen(),
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData){
      //       String providerId = snapshot.data?.providerData[0].providerId ?? "unknown";
      //       String? uId = snapshot.data?.uid;
      //       print(providerId);
      //       print(uId);
      //       if (providerId == "phone"){
      //         // await _firestore.collection("users").doc(credential.user!.uid).set({
      //         //   'name': name,
      //         //   'email': email,
      //         //   'uid': credential.user!.uid,
      //         // });
      //       if (providerId == "password"){
      //         print("telefone");
      //       }
      //       return const HomeScreen();
      //     }else{
      //       return const LoginScreen();
      //     }
      //   }
      // )
    );
  }
}