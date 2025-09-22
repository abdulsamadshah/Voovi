// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:Voovi/screens/movie_list/shimmer_movie_list/shimmer_movie_list.dart';
import 'package:Voovi/screens/rented_content/pay_per_view_controller.dart';
import 'package:Voovi/utils/api_end_points.dart';
import 'package:Voovi/utils/colors.dart';

import '../../components/app_scaffold.dart';
import '../../main.dart';
import '../../utils/animatedscroll_view_widget.dart';
import '../../utils/empty_error_state_widget.dart';
import '../movie_details/movie_details_screen.dart';

class PayPerViewScreen extends StatelessWidget {
  final String? type;
  final String? title;

  PayPerViewScreen({super.key, this.type = APIEndPoints.payPerViewList, this.title});

  final PayPerViewController payPerViewController = Get.put(PayPerViewController());

  @override
  Widget build(BuildContext context) {
    return AppScaffoldNew(
      scaffoldBackgroundColor: appScreenBackgroundDark,
      topBarBgColor: Colors.transparent,
      appBartitleText: 'Pay Per View',
      body: Obx(
        () {
          return SnapHelperWidget(
            future: payPerViewController.getOriginalMovieListFuture.value,
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
                    return payPerViewController.getPayPerViewList();
                  },
                ).center(),
              );
            },
            onSuccess: (data) {
              return AnimatedScrollView(
                refreshIndicatorColor: appColorPrimary,
                padding: const EdgeInsets.only(bottom: 120),
                physics: const AlwaysScrollableScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                onNextPage: payPerViewController.onNextPage,
                onSwipeRefresh: payPerViewController.onSwipeRefresh,
                children: [
                  if (payPerViewController.originalMovieList.isEmpty && !payPerViewController.isLoading.value)
                    SizedBox(
                      width: Get.width,
                      height: Get.height * 0.8,
                      child: NoDataWidget(
                        titleTextStyle: boldTextStyle(color: white),
                        subTitleTextStyle: primaryTextStyle(color: white),
                        title: locale.value.noDataFound,
                        retryText: "",
                        imageWidget: const EmptyStateWidget(),
                      ).center(),
                    )

                  // Show list when data is available
                  else
                    CustomAnimatedScrollView(
                      paddingLeft: Get.width * 0.04,
                      paddingRight: Get.width * 0.04,
                      paddingBottom: Get.height * 0.10,
                      spacing: Get.width * 0.03,
                      runSpacing: Get.height * 0.02,
                      posterHeight: 150,
                      posterWidth: Get.width * 0.286,
                      isHorizontalList: false,
                      isLoading: false,
                      isLastPage: payPerViewController.isLastPage.value,
                      itemList: payPerViewController.originalMovieList,
                      onTap: (posterDet) {
                        Get.to(() => MovieDetailsScreen(), arguments: posterDet);
                      },
                      isMovieList: true,
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}