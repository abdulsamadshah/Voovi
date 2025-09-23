import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:voovi/generated/assets.dart';
import '../configs.dart';
import '../utils/constants.dart';

class AppMinLogoWidget extends StatelessWidget {
  final Size? size;

  const AppMinLogoWidget({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: APP_MINI_LOGO_URL,
      height: size?.height ?? Constants.appLogoSize,
      width: size?.width ?? Constants.appLogoSize,
      placeholder: (context, url) {
        return Image.asset(
          Assets.iconsIcIcon,
          height: size?.height ?? Constants.appLogoSize,
          width: size?.width ?? Constants.appLogoSize,
        );
      },
    );
  }
}

class AppLogoWidget extends StatelessWidget {
  final Size? size;

  const AppLogoWidget({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: size?.height ?? Constants.appLogoSize,
      width: size?.width ?? Constants.appLogoSize,
      imageUrl: APP_LOGO_URL,
      placeholder: (context, url) {
        return Image.asset(
          Assets.assetsAppLogo,
          height: size?.height ?? Constants.appLogoSize,
          width: size?.width ?? Constants.appLogoSize,
        );
      },
    );
  }
}
