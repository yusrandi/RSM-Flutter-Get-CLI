import 'package:get/get.dart';

import 'package:rsm_flutter_get_cli/app/modules/absensi/bindings/absensi_binding.dart';
import 'package:rsm_flutter_get_cli/app/modules/absensi/views/absensi_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/absensi/views/display_picture.dart';
import 'package:rsm_flutter_get_cli/app/modules/barcode/bindings/barcode_binding.dart';
import 'package:rsm_flutter_get_cli/app/modules/barcode/views/barcode_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/cart/bindings/cart_binding.dart';
import 'package:rsm_flutter_get_cli/app/modules/cart/views/cart_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:rsm_flutter_get_cli/app/modules/dashboard/views/dashboard_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/detail/bindings/detail_binding.dart';
import 'package:rsm_flutter_get_cli/app/modules/detail/views/detail_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/home/bindings/home_binding.dart';
import 'package:rsm_flutter_get_cli/app/modules/home/views/home_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/menu/bindings/menu_binding.dart';
import 'package:rsm_flutter_get_cli/app/modules/menu/views/menu_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/setting/bindings/setting_binding.dart';
import 'package:rsm_flutter_get_cli/app/modules/setting/views/setting_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BARCODE,
      page: () => BarcodeView(),
      binding: BarcodeBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.ABSENSI,
      page: () => AbsensiView(),
      binding: AbsensiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.DISPLAY,
      page: () => DisplayPicture(),
      binding: AbsensiBinding(),
    ),
  ];
}
