import 'dart:io';
import 'package:justine/util/connectivity.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

class UploadFiles {
  Dio dio = new Dio();
  Connectivity _connect = Connectivity();
  Future<String> uploadvideo(File file, String type) async {
    final bname = DateTime.now().toString() + basename(file.path);

    print(bname);
    FormData formData = new FormData.from(
        {type == "video" ? "video" : "video": new UploadFileInfo(file, bname)});

    Response res = await dio.post(
        "${_connect.baseUrl}/request.php?action=upload-video",
        data: formData);
    String url = res.data;
    print(url);
    print('problem here');
    url = url.substring(0);
    url = url.substring(1, url.length - 1);
    print(url);
    print('no problem');
    return _connect.baseUrl + "/videos/$url";
    // return _connect.baseUrl + type == 'video'
    //     ? "/rfb/videos/${url.data}"
    //     : "/rfb/images/${url.data}";
  }
}
