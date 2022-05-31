import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_styles.dart';
import 'package:rsm_flutter_get_cli/app/modules/auth/controllers/auth_controller.dart';
import 'package:rsm_flutter_get_cli/app/modules/home/views/home_view.dart';
import 'package:rsm_flutter_get_cli/app/modules/home/views/onboard.dart';
import 'package:rsm_flutter_get_cli/app/routes/app_pages.dart';

import '../../../cores/core_colors.dart';
import '../../../cores/core_images.dart';
import '../../../cores/core_strings.dart';
import '../../auth/controllers/authentication_manager.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
  final AuthController _authController = Get.put(AuthController());

  Future<void> initializeSettings() async {
    _authmanager.checkLoginStatus();

    //Simulate other services for 3 seconds
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initializeSettings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _body(context);
          } else {
            if (snapshot.hasError)
              return errorView(snapshot);
            else
              return OnBoard();
          }
        },
      ),
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Stack _body(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(CoreImages.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Lottie.asset(
                CoreImages.motorJson,
                height: 150,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
