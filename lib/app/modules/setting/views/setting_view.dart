import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_styles.dart';
import 'package:rsm_flutter_get_cli/app/data/config/api.dart';
import 'package:rsm_flutter_get_cli/app/data/models/user.dart';
import 'package:rsm_flutter_get_cli/app/modules/auth/controllers/auth_controller.dart';

import '../../../cores/core_colors.dart';
import '../../auth/controllers/authentication_manager.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  final userController = Get.put(SettingController());
  AuthenticationManager _authManager = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _body(),
    );
  }

  FutureBuilder<User> _body() {
    return FutureBuilder<User>(
      future: userController.getUser("1"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(color: CoreColor.primary));
        }
        User u = snapshot.data!;
        print(snapshot.data);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              Api.imageUserURL + '/' + u.foto!)))),
              Text(
                u.name!,
                style: CoreStyles.uTitle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    u.phone!,
                    style: CoreStyles.uTitle.copyWith(fontSize: 14),
                  ),
                  Text(
                    "|",
                    style: CoreStyles.uTitle.copyWith(fontSize: 16),
                  ),
                  Text(
                    u.email!,
                    style: CoreStyles.uTitle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  _authManager.logOut();
                },
                child: Container(
                  margin: EdgeInsets.all(16),
                  height: 60,
                  decoration: BoxDecoration(
                      color: CoreColor.primary,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Logout",
                      style: CoreStyles.uTitle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
