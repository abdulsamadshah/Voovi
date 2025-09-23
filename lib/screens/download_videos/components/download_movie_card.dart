import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voovi/components/cached_image_widget.dart';
import 'package:voovi/utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import 'package:voovi/generated/assets.dart';

import '../../../video_players/model/video_model.dart';

class DownloadMovieCard extends StatelessWidget {
  final VideoPlayerModel movieDetails;

  const DownloadMovieCard({super.key, required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedImageWidget(
            url: movieDetails.thumbnailImage.replaceAll("'", ""),
            height: double.infinity,
            width: 120,
            fit: BoxFit.cover,
            radius: 6,
          ),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Marquee(
                child: Text(
                  movieDetails.name,
                  style: boldTextStyle(size: 16, color: white),
                ),
              ),
              6.height,
              Text(
                parseHtmlString(movieDetails.description),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: primaryTextStyle(size: 12, color: darkGrayTextColor),
              ),
            ],
          ).expand(),
          16.width,
          if (getIntAsync('${SharedPreferenceConst.DOWNLOAD_KEY}_${movieDetails.id}') >= 1 && getIntAsync('${SharedPreferenceConst.DOWNLOAD_KEY}_${movieDetails.id}') < 100) Container(
                  height: 42,
                  width: 42,
                  padding: const EdgeInsets.all(4),
                  decoration: boxDecorationDefault(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Marquee(
                    child: Text(
                      '${getIntAsync('${SharedPreferenceConst.DOWNLOAD_KEY}_${movieDetails.id}')}'.suffixText(value: '%'),
                      style: primaryTextStyle(color: appColorPrimary),
                    ),
                  ),
                ).center() else Container(
                  height: 28,
                  width: 28,
                  padding: const EdgeInsets.all(4),
                  decoration: boxDecorationDefault(color: circleColor, shape: BoxShape.circle),
                  child: Image.asset(
                    movieDetails.hasDownloadError ? Assets.iconsIcPending : Assets.iconsIcDownloaded,
                    color: white,
                  ),
                ).center()
        ],
      ),
    );
  }
}