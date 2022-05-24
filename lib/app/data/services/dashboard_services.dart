import 'dart:convert';

import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/data/models/dashboard_model.dart';
import 'package:rsm_flutter_get_cli/app/data/models/kategori_model.dart';
import 'package:http/http.dart' as http;

import '../config/api.dart';

class DashboardService extends GetConnect {
  Future<DashboardModel> fetchDashboardReport(String id) async {
    final response =
        await http.get(Uri.parse(Api.instance.sale + '/report/' + id));

    DashboardModel data =
        DashboardModel.fromJson(json.decode(response.body)['data']);

    return data;
  }
}
