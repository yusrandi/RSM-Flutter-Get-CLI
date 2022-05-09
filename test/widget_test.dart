import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rsm_flutter_get_cli/app/data/models/user.dart';

void main() async {
  Uri url = Uri.parse("http://192.168.10.166/rsm-laravel/public/api/user/1");
  var res = await http.get(url);
  User data = User.fromJson(json.decode(res.body)['data']);
  print(data.toJson());
}
