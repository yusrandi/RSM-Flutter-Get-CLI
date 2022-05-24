import 'package:http/http.dart' as http;
import 'package:rsm_flutter_get_cli/app/data/config/api.dart';
import 'dart:convert';

import 'package:rsm_flutter_get_cli/app/data/models/user.dart';
import 'package:rsm_flutter_get_cli/app/data/services/dashboard_services.dart';

void main() async {
  print('halooo');

  // var store = transaksiStore("2000", "1,2", "2,2");
  // print(store.toString());

  var _response = await DashboardService().fetchDashboardReport(1);

  print(_response);
}

Future<String> transaksiStore(
    String amount, String cabang_produk_ids, String qtys) async {
  var _response = await http.post(Uri.parse(Api().sale), body: {
    "user_id": "1",
    "amount": amount,
    "qtys": qtys,
    "cabang_produk_ids": cabang_produk_ids,
  });

  print(_response.body);
  return _response.body;
}

Future<String> getUser() async {
  Uri url = Uri.parse(Api().getUser + '/login');
  print(url);
  var res = await http.get(url);
  User data = User.fromJson(json.decode(res.body)['data']);
  print(data);

  return data.name!;
}
