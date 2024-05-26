import 'package:get/get.dart';

import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/analysis/bindings/analysis_binding.dart';
import '../modules/analysis/views/analysis_view.dart';
import '../modules/detail_product/bindings/detail_product_binding.dart';
import '../modules/detail_product/views/detail_product_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/views/products_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/splash/splashScreen.dart';
import '../modules/splash/splashScreen.dart';
import '../modules/splash_page/bindings/splash_page_binding.dart';
import '../modules/splash_page/views/splash_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.addProduct,
      page: () => AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.products,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.detailProduct,
      page: () => DetailProductView(),
      binding: DetailProductBinding(),
    ),
    GetPage(
      name: _Paths.registration,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
    // GetPage(
    //   name: _Paths.splash,
    //   page: () => const Splashscreen(),
    // ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashPageView(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: _Paths.analysis,
      page: () =>  AnalysisView(),
      binding: AnalysisBinding(),
    ),
  ];
}
