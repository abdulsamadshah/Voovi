// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voovi/screens/dashboard/components/floating_widget.dart';
import 'package:voovi/screens/movie_list/shimmer_movie_list/shimmer_movie_list.dart';
import 'package:voovi/screens/slider/banner_widget.dart';
import 'package:voovi/screens/tv_show/tv_show_screen.dart';
import 'package:voovi/screens/tv_show/tvshow_list_controller.dart';
import 'package:voovi/utils/colors.dart';
import 'package:voovi/utils/constants.dart';

import '../../components/app_scaffold.dart';
import '../../main.dart';
import '../../utils/animatedscroll_view_widget.dart';
import '../../utils/empty_error_state_widget.dart';

class TvShowListScreen extends StatelessWidget {
  TvShowListScreen({super.key});

  final TvShowListController tvShowListCont = Get.put(TvShowListController());

  @override
  Widget build(BuildContext context) {
    return AppScaffoldNew(
      hasLeadingWidget: false,
      hideAppBar: true,
      scaffoldBackgroundColor: appScreenBackgroundDark,
      floatingActionButton: FloatingWidget(label: locale.value.tVShows),
      body: AnimatedScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        onNextPage: tvShowListCont.onNextPage,
        onSwipeRefresh: () async {
          tvShowListCont.page(1);
          tvShowListCont.sliderController.getBanner(type: BannerType.tvShow);
          return tvShowListCont.getTvShowDetails();
        },
        children: [
          BannerWidget(sliderController: tvShowListCont.sliderController),
          Obx(
            () {
              return SnapHelperWidget(
                future: tvShowListCont.getTvShowFuture.value,
                loadingWidget: const ShimmerMovieList(),
                errorBuilder: (error) {
                  return SizedBox(
                    width: Get.width,
                    height: Get.height * 0.8,
                    child: NoDataWidget(
                      titleTextStyle: secondaryTextStyle(color: white),
                      subTitleTextStyle: primaryTextStyle(color: white),
                      title: error,
                      retryText: locale.value.reload,
                      imageWidget: const ErrorStateWidget(),
                      onRetry: () async {
                        return tvShowListCont.getTvShowDetails();
                      },
                    ).center(),
                  );
                },
                onSuccess: (data) {
                  if (tvShowListCont.tvShowList.isEmpty && !tvShowListCont.isLoading.value) {
                    return NoDataWidget(
                      titleTextStyle: boldTextStyle(color: white),
                      subTitleTextStyle: primaryTextStyle(color: white),
                      title: locale.value.noDataFound,
                      retryText: "",
                      imageWidget: const EmptyStateWidget(),
                    ).paddingSymmetric(horizontal: 16);
                  }

                  //  Data loaded and list is not empty → show list
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.value.tVShows,
                        style: primaryTextStyle(),
                      ).paddingDirectional(start: 16),
                      10.height,
                      CustomAnimatedScrollView(
                        paddingLeft: Get.width * 0.04,
                        paddingRight: Get.width * 0.04,
                        paddingBottom: Get.height * 0.10,
                        spacing: Get.width * 0.03,
                        runSpacing: Get.height * 0.02,
                        posterHeight: 150,
                        posterWidth: Get.width * 0.286,
                        isHorizontalList: false,
                        isLoading: tvShowListCont.isLoading.value,
                        isLastPage: tvShowListCont.isLastPage.value,
                        itemList: tvShowListCont.tvShowList,
                        onTap: (posterDet) {
                          Get.to(() => TvShowScreen(key: UniqueKey()), arguments: posterDet);
                        },
                        isMovieList: true,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}