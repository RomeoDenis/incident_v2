import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:justine/util/funcs.dart';

import 'video-player.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    Key key,
    @required TextEditingController controllerVideo,
  })  : _controllerVideo = controllerVideo,
        super(key: key);

  final TextEditingController _controllerVideo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Uint8List>(
        future: Funcs().videoThumbnailGenerator(_controllerVideo.text),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            VideoPlayWidget(video: _controllerVideo.text)));
                  },
                  child: Stack(children: <Widget>[
                    Center(
                      child: Container(
                        height: 300,
                        child: Image.memory(
                          snapshot.data,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ]),
                )
              : SizedBox.shrink();
        },
      ),
    );
  }
}
