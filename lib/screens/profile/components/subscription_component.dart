import 'package:Voovi/screens/payment/QrPaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:Voovi/screens/subscription/subscription_screen.dart';
import 'package:Voovi/utils/app_common.dart';
import 'package:Voovi/utils/colors.dart';
import 'package:Voovi/utils/common_base.dart';

import '../../../components/cached_image_widget.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../subscription/model/subscription_plan_model.dart';

class SubscriptionComponent extends StatelessWidget {
  final SubscriptionPlanModel planDetails;
  final VoidCallback? callback;

  const SubscriptionComponent({super.key, this.callback, required this.planDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: boxDecorationDefault(
        color: yellowColor.withValues(alpha: 0.06),
        border: Border.all(color: yellowColor, width: 0.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const CachedImageWidget(
            url: Assets.iconsIcSubscription,
            height: 25,
            width: 32,
          ),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Marquee(
                child: Text(
                  planDetails.level > -1 ? planDetails.name.validate() : locale.value.subscribeToEnjoyMore,
                  style: boldTextStyle(size: 14),
                ),
              ),
              2.height,
              Marquee(
                child: Text(
                  planDetails.level > -1
                      ? planDetails.endDate.isNotEmpty
                          ? "${locale.value.expiringOn} ${dateFormat(planDetails.endDate)}"
                          : ""
                      : locale.value.daysFreeTrail,
                  style: secondaryTextStyle(
                    weight: FontWeight.w500,
                    color: darkGrayTextColor,
                  ),
                ),
              ),
            ],
          ).expand(),
          16.width,
          InkWell(
            onTap: () {
              Get.to(() => SubscriptionScreen(launchDashboard: false))?.then((value) {
                if (planDetails.level != currentSubscription.value.level) {
                  callback?.call();
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: boxDecorationDefault(color: white, borderRadius: BorderRadius.circular(4)),
              alignment: Alignment.center,
              child: Text(
                planDetails.level == -1 ? locale.value.subscribe : locale.value.updrade,
                style: secondaryTextStyle(
                  size: 12,
                  weight: FontWeight.w600,
                  color: black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class QrSubscriptionComponent extends StatelessWidget {

  final VoidCallback? callback;

  const QrSubscriptionComponent({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: boxDecorationDefault(
        color: yellowColor.withValues(alpha: 0.06),
        border: Border.all(color: yellowColor, width: 0.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const CachedImageWidget(
            url: Assets.iconsIcSubscription,
            height: 25,
            width: 32,
          ),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Marquee(
                child: Text(
                  locale.value.subscribeToEnjoyMore,
                  style: boldTextStyle(size: 14),
                ),
              ),
              2.height,

              Text(
              "Pay with Qr Code",
              style: boldTextStyle(size: 13),
              ),


            ],
          ).expand(),
          16.width,
          InkWell(
            onTap: () {
              Get.to(() => PaymentQrScreen());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: boxDecorationDefault(color: white, borderRadius: BorderRadius.circular(4)),
              alignment: Alignment.center,
              child: Text(
              "Pay",
                style: secondaryTextStyle(
                  size: 12,
                  weight: FontWeight.w600,
                  color: black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}