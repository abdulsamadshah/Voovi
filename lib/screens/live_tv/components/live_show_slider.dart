import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:Voovi/generated/assets.dart';
import 'package:Voovi/screens/live_tv/components/live_card.dart';
import 'package:Voovi/screens/live_tv/live_tv_controller.dart';
import 'package:Voovi/screens/live_tv/model/live_tv_dashboard_response.dart';
import 'package:Voovi/utils/colors.dart';

import '../../../components/cached_image_widget.dart';
import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../live_tv_details/live_tv_details_screen.dart';

class LiveShowSliderComponent extends StatelessWidget {
  LiveShowSliderComponent({super.key});

  final LiveTVController liveTvCont = Get.put(LiveTVController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 340,
            width: double.infinity,
            child: Stack(
              children: [
                if (liveTvCont.liveDashboard.value.data.slider.isNotEmpty)
                  PageView(
                    controller: liveTvCont.sliderCont.value,
                    children: List.generate(
                      liveTvCont.liveDashboard.value.data.slider.length,
                      (index) {
                        final ChannelModel data = liveTvCont.liveDashboard.value.data.slider[index];
                        return Stack(
                          children: [
                            CachedImageWidget(url: data.posterImage.validate(), width: double.infinity, height: double.infinity, fit: BoxFit.cover).onTap(() {}),
                            IgnorePointer(
                              ignoring: true,
                              child: Container(
                                height: 340,
                                width: double.infinity,
                                foregroundDecoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [black.withValues(alpha: 0.4), black.withValues(alpha: 0.2), black.withValues(alpha: 0.8), black.withValues(alpha: 1)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            sliderDetails(data),
                          ],
                        );
                      },
                    ),
                  )
                else
                  const CachedImageWidget(url: '', height: 340, width: double.infinity),
                const Positioned(
                  left: 10,
                  top: 10,
                  child: LiveCard(),
                ),
              ],
            ),
          ),
          if (liveTvCont.liveDashboard.value.data.slider.length.validate() > 1)
            DotIndicator(
              pageController: liveTvCont.sliderCont.value,
              pages: liveTvCont.liveDashboard.value.data.slider,
              indicatorColor: white,
              unselectedIndicatorColor: darkGrayColor,
              currentBoxShape: BoxShape.rectangle,
              boxShape: BoxShape.rectangle,
              borderRadius: radius(3),
              currentBorderRadius: radius(3),
              currentDotSize: 6,
              currentDotWidth: 6,
              dotSize: 6,
            ),
          32.height
        ],
      ),
    );
  }

  Positioned sliderDetails(ChannelModel data) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data.name, style: commonSecondaryTextStyle(size: 22, color: white)),
          12.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => LiveShowDetailsScreen(), arguments: data);
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: boxDecorationDefault(borderRadius: BorderRadius.circular(4), color: greyBtnColor),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CachedImageWidget(
                        url: Assets.iconsIcPlay,
                        height: 10,
                        width: 10,
                      ),
                      12.width,
                      Text(
                        locale.value.playNow,
                        style: boldTextStyle(size: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
