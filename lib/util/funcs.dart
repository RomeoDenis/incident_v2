import 'dart:typed_data';

import 'package:video_thumbnail/video_thumbnail.dart';

class Funcs {
  Future<Uint8List> videoThumbnailGenerator(file) async {
    Uint8List uint8list = await VideoThumbnail.thumbnailData(
      video: file,
      imageFormat: ImageFormat.WEBP,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 50,
    );
    return uint8list;
  }
}
