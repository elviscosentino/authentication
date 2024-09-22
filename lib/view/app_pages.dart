import 'package:get/get.dart';
import 'auth/email_signup_screen.dart';
import 'auth/login_screen.dart';
import 'auth/phone_login_screen.dart';
import 'auth/register_screen.dart';
import 'splash_screen.dart';
import 'base_screen.dart';
abstract class AppPages{
  static final pages = <GetPage>[
    GetPage(page: () => const BaseScreen(), name: PagesRoutes.baseRoute),
    // GetPage(page: () => const BaseScreen(), name: PagesRoutes.baseRoute, bindings: [NavigationBinding(), HomeBinding(), CartBinding(), OrdersBinding()]), //
    GetPage(page: () => const SplashScreen(), name: PagesRoutes.splashRoute),
    GetPage(page: () => LoginScreen(), name: PagesRoutes.loginRoute),
    GetPage(page: () => PhoneLoginScreen(), name: PagesRoutes.loginPhoneRoute),
    GetPage(page: () => EmailSignupScreen(), name: PagesRoutes.signUpRoute),
    GetPage(page: () => RegisterScreen(), name: PagesRoutes.registerUserRoute),
    // GetPage(page: () => CadastrarCartao(), name: PagesRoutes.cadCartaoRoute),
    // GetPage(page: () => const CartClientItemsScreen(), name: PagesRoutes.cartClientItemsRoute),
    // GetPage(page: () => const TermosUsoScreen(), name: PagesRoutes.termosUsoRoute),
  ];
}

abstract class PagesRoutes{
  static const String baseRoute = '/';
  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String loginPhoneRoute = '/loginPhone';
  static const String signUpRoute = '/signup';
  static const String registerUserRoute = '/registerUser';
  // static const String productRoute = '/product';
  // static const String cadCartaoRoute = '/cadcartao';
  // static const String cartClientItemsRoute = '/cartClientItems';
  // static const String termosUsoRoute = '/termosUso';
  // static const String politicaPrivacidadeRoute = '/politicaPrivacidade';
}