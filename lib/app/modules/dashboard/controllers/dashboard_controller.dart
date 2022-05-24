import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rsm_flutter_get_cli/app/data/models/dashboard_model.dart';
import 'package:rsm_flutter_get_cli/app/data/services/cabang_product_services.dart';
import 'package:rsm_flutter_get_cli/app/data/services/dashboard_services.dart';
import 'package:rsm_flutter_get_cli/app/modules/auth/controllers/authentication_manager.dart';
import 'dart:convert';

import '../../../data/config/api.dart';
import '../../../data/models/cabang-product.dart';

class DashboardController extends GetxController {
  final count = 0.obs;
  final AuthenticationManager _authManager = Get.find();

  @override
  void onInit() async {
    super.onInit();

    print("UserID ${_authManager.getToken()}");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<DashboardModel> fetchReport(String id) async {
    return await DashboardService().fetchDashboardReport(id);
  }

  Future<List<CabangProduct>> getAllProductById(int id) async {
    return await CabangProductService().getAllProductById(id);
  }
}
