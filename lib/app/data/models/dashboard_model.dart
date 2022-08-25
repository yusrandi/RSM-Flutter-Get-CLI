// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  DashboardModel({
    this.cabangTotal,
    this.userTotal,
    this.userQty,
    this.profit,
  });

  int? cabangTotal;
  int? userTotal;
  int? userQty;
  int? profit;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        cabangTotal: json["cabang_total"],
        userTotal: json["user_total"],
        userQty: json["user_qty"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "cabang_total": cabangTotal,
        "user_total": userTotal,
        "user_qty": userQty,
        "profit": profit,
      };
}
