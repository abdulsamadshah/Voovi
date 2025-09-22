import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Voovi/screens/download_videos/download_controller.dart';
import 'package:Voovi/utils/colors.dart';
import 'package:Voovi/video_players/model/video_model.dart';
import 'package:Voovi/video_players/video_player.dart';

import '../../../components/app_scaffold.dart';

class DownloadDetailsScreen extends StatelessWidget {
  final VideoPlayerModel movieDetails;

  final DownloadController downloadVideoCont;

  const DownloadDetailsScreen({super.key, required this.movieDetails, required this.downloadVideoCont});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldNew(
      hasLeadingWidget: true,
      isLoading: false.obs,
      hideAppBar: false,
      topBarBgColor: appScreenBackgroundDark,
      scaffoldBackgroundColor: appScreenBackgroundDark,
      body: VideoPlayersComponent(
        videoModel: movieDetails,
        isTrailer: false,
        isFromDownloads: true,
      ),
    );
  }
}