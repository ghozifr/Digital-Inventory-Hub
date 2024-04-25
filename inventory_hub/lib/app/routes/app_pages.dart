import 'package:get/get.dart';

import '../modules/add_products/bindings/add_products_binding.dart';
import '../modules/add_products/views/add_products_view.dart';
import '../modules/detail_product/bindings/detail_product_binding.dart';
import '../modules/detail_product/views/detail_product_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/product_list/bindings/product_list_binding.dart';
import '../modules/product_list/views/product_list_view.dart';
import '../modules/qr_scan/bindings/qr_scan_binding.dart';
import '../modules/qr_scan/views/qr_scan_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';

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
      name: _Paths.add_products,
      page: () => AddProductsView(),
      binding: AddProductsBinding(),
    ),
    GetPage(
      name: _Paths.product_list,
      page: () => const ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: _Paths.qr_scan,
      page: () => const QrScanView(),
      binding: QrScanBinding(),
    ),
    GetPage(
      name: _Paths.report,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.detail_product,
      page: () => DetailProductView(),
      binding: DetailProductBinding(),
    ),
    GetPage(
      name: _Paths.registration,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
  ];
}
