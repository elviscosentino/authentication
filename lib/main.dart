import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'controller/auth/auth_controller.dart';
import 'services/firebase_options.dart';
import 'view/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "authentication-a8e04",
      options: DefaultFirebaseOptions.currentPlatform
  );
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.blue,
          seedColor: Colors.blue
        ),
        useMaterial3: true,
      ),
      onReady: () async{
        final authController = Get.find<AuthController>();
        await authController.validateUser();
      },
      getPages: AppPages.pages,
      initialRoute: PagesRoutes.splashRoute,
    );
  }
}