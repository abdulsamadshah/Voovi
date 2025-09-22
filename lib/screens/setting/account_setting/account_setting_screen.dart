import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:Voovi/components/app_dialog_widget.dart';
import 'package:Voovi/generated/assets.dart';
import 'package:Voovi/screens/profile/model/profile_detail_resp.dart';
import 'package:Voovi/screens/setting/account_setting/components/register_mobile_component.dart';
import 'package:Voovi/screens/setting/account_setting/shimmer_account_setting.dart';
import 'package:Voovi/screens/setting/setting_controller.dart';
import 'package:Voovi/utils/app_common.dart';
import 'package:Voovi/utils/constants.dart';

import '../../../components/app_scaffold.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../../profile/components/subscription_component.dart';
import '../../subscription/model/subscription_plan_model.dart';
import 'components/other_devices_component.dart';
import 'components/your_device/your_device_component.dart';

class AccountSettingScreen extends StatelessWidget {
  final ProfileModel profileInfo;

  final bool isDeviceLimitReached;
  final SettingController settingController;

  const AccountSettingScreen({
    super.key,
    required this.profileInfo,
    required this.settingController,
    this.isDeviceLimitReached = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: settingController.isLoading,
      scaffoldBackgroundColor: appScreenBackgroundDark,
      appBartitleText: locale.value.accountSettings,
      body: Obx(
        () => SnapHelperWidget(
          future: settingController.getAccountSettingFuture.value,
          loadingWidget: const ShimmerAccountSetting(),
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.value.reload,
              titleTextStyle: secondaryTextStyle(color: white),
              subTitleTextStyle: primaryTextStyle(color: white),
              imageWidget: const ErrorStateWidget(),
              onRetry: () {
                settingController.getAccountSetting();
              },
            );
          },
          onSuccess: (res) {
            return Obx(
              () => AnimatedScrollView(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                listAnimationType: commonListAnimationType,
                refreshIndicatorColor: appColorPrimary,
                onSwipeRefresh: () {
                  return settingController.getAccountSetting();
                },
                children: [
                  if (cachedProfileDetails != null && cachedProfileDetails?.data.planDetails.status == SubscriptionStatus.active) SubscriptionComponent(planDetails: currentSubscription.value).paddingBottom(16) else SubscriptionComponent(planDetails: SubscriptionPlanModel()).paddingBottom(16),
                  RegisterMobileComponent(mobileNo: settingController.accountSettingResp.value.registerMobileNumber.validate(), profileDetail: profileInfo)
                      .visible(settingController.accountSettingResp.value.registerMobileNumber.isNotEmpty),
                  if (!isDeviceLimitReached) YourDeviceComponent(deviceDet: yourDevice.value),
                  OtherDevicesComponent(
                    devicesDetail: settingController.accountSettingResp.value.otherDevice,
                    onLogout: (logoutAll, device, String deviceName) {
                      if (logoutAll) {
                        settingController.logOutAll();
                      } else {
                        settingController.deviceLogOut(device: device);
                      }
                    },
                  ),
                  10.height,
                ],
              ),
            );
          },
        ),
      ),
      bottomNavBar: Obx(
        () => settingController.isLoading.isTrue
            ? const Offstage()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        isDismissible: true,
                        isScrollControlled: true,
                        enableDrag: false,
                        AppDialogWidget(
                          image: Assets.imagesIcDelete,
                          title: locale.value.deleteAccountPermanently,
                          subTitle: locale.value.allYourDataWill,
                          onAccept: () {
                            settingController.deleteAccountPermanently();
                          },
                          positiveText: locale.value.proceed,
                          negativeText: locale.value.cancel,
                        ),
                      );
                    },
                    child: Text(
                      locale.value.deleteAccount,
                      style: boldTextStyle(
                        size: 14,
                        color: appColorPrimary,
                      ),
                    ).paddingOnly(bottom: 18, top: 18),
                  )
                ],
              ).visible(!settingController.isLoading.value),
      ),
    );
  }
}