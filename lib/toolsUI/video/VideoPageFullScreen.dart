
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/toolsUI/app_colors.dart';

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../circular_progress.dart';

class VideoPageFullScreen extends StatefulWidget {
  String videoSrc;

  VideoPageFullScreen({super.key, required this.videoSrc});

  @override
  State<VideoPageFullScreen> createState() => _VideoPageFullScreenState();
}

class _VideoPageFullScreenState extends State<VideoPageFullScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    initiateVideo(widget.videoSrc);
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        backgroundColor: grey,
        elevation: 0,
        title: Text(
          'gallery',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        leading: BackButton(color: Colors.black),
      ),
      body: Container(
        decoration: mainContainerDecoration,
        height: DeviceTools.getHeight(context),
        child: Center(
          child: _videoPlayerController.value.isInitialized
              ? Chewie(
                  controller: ChewieController(
                    videoPlayerController: _videoPlayerController,
                    autoPlay: true,
                    looping: true,
                  ),
                )
              : circularProgress(),
        ),
      ),
    );
  }

  initiateVideo(src) {
    _videoPlayerController = VideoPlayerController.network(
      src,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }
}
