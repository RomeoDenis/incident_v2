import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayWidget extends StatefulWidget {
  String video;
  VideoPlayWidget({Key key, this.video}) : super(key: key);

  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlayWidget> {
  VideoPlayerController videoCtr;
  var chewieController;
  @override
  void initState() {
    super.initState();
    videoCtr = widget.video.toString().startsWith('https:') ||
            widget.video.toString().startsWith('http:')
        ? new VideoPlayerController.network(widget.video)
        : new VideoPlayerController.file(File(widget.video));

    chewieController = ChewieController(
      videoPlayerController: videoCtr,
      aspectRatio: 3 / 2,
      autoPlay: true,
      autoInitialize: true,
      looping: false,

      // Try playing around with some of these other options:
      showControls: false,
      materialProgressColors: new ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: new Container(
        color: Colors.grey,
      ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    videoCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Chewie(
      controller: chewieController,
    ));
  }
}
