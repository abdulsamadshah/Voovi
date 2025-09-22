import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:Voovi/components/app_logo_widget.dart';
import 'package:Voovi/main.dart';
import '../components/app_scaffold.dart';
import '../components/loader_widget.dart';
import '../utils/colors.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final String deepLink;
  final bool? link;

  SplashScreen({super.key, this.deepLink = "", this.link});

  final SplashScreenController splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    if (link == true) {
      splashController.handleDeepLinking(deepLink: deepLink);
    }
    return AppScaffold(
      hideAppBar: true,
      scaffoldBackgroundColor: appScreenBackgroundDark,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogoWidget(size: Size(160, 160)),
            Obx(
              () => splashController.isLoading.value
                  ? const LoaderWidget().center()
                  : TextButton(

                      child: Text(locale.value.reload, style: boldTextStyle()),
                      onPressed: () {
                        splashController.init(showLoader: true);
                      },
                    ).visible(splashController.appNotSynced.isTrue),
            )
          ],
        ),
      ),
    );
  }
}