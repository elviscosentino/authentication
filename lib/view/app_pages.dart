import 'package:get/get.dart';
import 'auth/login_screen.dart';
import 'splash_screen.dart';

import 'base_screen.dart';
abstract class AppPages{
  static final pages = <GetPage>[
    GetPage(page: () => const BaseScreen(), name: PagesRoutes.baseRoute),
    // GetPage(page: () => const BaseScreen(), name: PagesRoutes.baseRoute, bindings: [NavigationBinding(), HomeBinding(), CartBinding(), OrdersBinding()]), //
    GetPage(page: () => const SplashScreen(), name: PagesRoutes.splashRoute),
    // GetPage(page: () => CepScreen(), name: PagesRoutes.cepRoute),
    GetPage(page: () => const LoginScreen(), name: PagesRoutes.loginRoute),
    // GetPage(page: () => SignUpScreen(), name: PagesRoutes.signUpRoute),
    // GetPage(page: () => EnderecoScreen(), name: PagesRoutes.enderecoRoute),
    // GetPage(page: () => ProductScreen(), name: PagesRoutes.productRoute),
    // GetPage(page: () => CadastrarCartao(), name: PagesRoutes.cadCartaoRoute),
    // GetPage(page: () => const CartClientItemsScreen(), name: PagesRoutes.cartClientItemsRoute),
    // GetPage(page: () => const TermosUsoScreen(), name: PagesRoutes.termosUsoRoute),
  ];
}

abstract class PagesRoutes{
  static const String baseRoute = '/';
  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  // static const String cepRoute = '/cep';
  // static const String signUpRoute = '/signup';
  // static const String enderecoRoute = '/endereco';
  // static const String productRoute = '/product';
  // static const String cadCartaoRoute = '/cadcartao';
  // static const String cartClientItemsRoute = '/cartClientItems';
  // static const String termosUsoRoute = '/termosUso';
  // static const String politicaPrivacidadeRoute = '/politicaPrivacidade';
}