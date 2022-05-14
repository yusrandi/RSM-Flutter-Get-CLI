import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/modules/absensi/views/absensi_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/barcode/views/barcode_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/dashboard/views/dashboard_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/menu/views/menu_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/setting/views/setting_view.dart';

import '../../../cores/core_colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final tabs = ['Home', 'Profile', 'Help', 'Settings'];
  HomeController c = Get.put(HomeController());
  int selectedPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreColor.greyColor2,
      body: Stack(children: [
        Container(
          child: Obx((() => c.count.value == 0
              ? BarcodeView()
              : c.count.value == 1
                  ? DashboardView()
                  : c.count.value == 2
                      ? MenuView()
                      : c.count.value == 3
                          ? AbsensiView()
                          : c.count.value == 4
                              ? SettingView()
                              : Container())),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            height: 90,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 30,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15))),
                ),
                Positioned(
                    bottom: 8, left: 16, right: 16, top: 0, child: _tabItem()),
              ],
            ),
          ),
        )
      ]),
    );
  }

  _tabItem() {
    return Obx((() => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _listItem("home", "assets/icons/home.svg", 30, 1)),
            Expanded(
              child: _listItem("menu", "assets/icons/menu.svg", 25, 2),
            ),
            Expanded(
                child: GestureDetector(
              onTap: (() => c.setIndex(0)),
              child: Container(
                decoration: BoxDecoration(
                    color: CoreColor.primary, shape: BoxShape.circle),
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  "assets/icons/qr-code.svg",
                  color: Colors.white,
                  height: 50,
                ),
              ),
            )),
            Expanded(child: _listItem("absen", "assets/icons/list.svg", 28, 3)),
            Expanded(
                child: _listItem("setting", "assets/icons/setting.svg", 30, 4))
          ],
        )));
  }

  _listItem(String title, String iconAsset, double heightIcon, int index) {
    return GestureDetector(
      onTap: () => c.setIndex(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAsset,
            color: c.count.value == index ? CoreColor.primary : Colors.grey,
            height: heightIcon,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: c.count.value == index ? CoreColor.primary : Colors.grey,
                fontSize: 12),
          )
        ],
      ),
    );
  }
}
