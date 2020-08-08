import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:justine/db/form-db.dart';
import 'package:justine/util/connectivity.dart';
import 'package:justine/util/uploader.dart';

class ApiHelper {
  FormDb formDb = FormDb();
  UploadFiles _uploadFunc = UploadFiles();
  Connectivity _connect = Connectivity();

  // 'http://10.0.2.2:5000';
  List values;
  Dio dio = new Dio();

  Future singleUploadingData(Map<String, dynamic> val, context) async {
    Connectivity _connectivity = Connectivity();
    try {
      if (val['status']) {
        throw new Exception("taarifa haiwezi tuma mara mbili");
      }

      bool connectionStatus = await _connectivity.connection();
      if (connectionStatus == false) {
        // await formDb.updateForm(val['_id'], val);
        throw new Exception("connection fails, form will store offline");
      }

      // if (val['form']['video'].startsWith('https:') == false &&
      //     val['form']['video'].length > 10) {
      //   print('------------------------- video --------------------');

      //   String url =
      //       await _uploadFunc.uploadvideo(File(val['form']['video']), 'videos');

      //   // print(url.toString());
      //   val['form']['video'] = url;
      // }
      print(val['form']['video'].toString().length);
      print(val['form']['picha'].toString().length);
      List func = ['picha', 'video'];
      var result = func.map((f) async {
        if (f == 'video') {
          if (val['form']['video'].startsWith('https:') == false &&
              val['form']['video'].toString().length > 10) {
            try {
              var res = await _uploadFunc.uploadvideo(
                  File(val['form']['video']), 'videos');
              // .catchError((onError) => {});
              print(res);
              return val['form']['video'] = res;
            } catch (e) {
              print(e);
              Flushbar(
                title: "Fail to upload video",
                message: e.toString(),
                duration: Duration(seconds: 5),
              )..show(context);
            }
          }
        }
        if (f == 'picha') {
          if (val['form']['picha'].startsWith('https:') == false &&
              val['form']['picha'].toString().length > 10) {
            print(val['form']['picha']);

            var res = await _uploadFunc
                .uploadvideo(File(val['form']['picha']), 'images')
                .catchError((onError) => {
                      print(onError),
                      Flushbar(
                        title: "Fail to upload picture",
                        message: onError.toString(),
                        duration: Duration(seconds: 5),
                      )..show(context)
                    });
            print(res);
            return val['form']['picha'] = res;
          }
        }
      });
      await Future.wait(result);
      print(
          '-----------               ---------------------            -----------');

      print(val['form']['picha'].toString().length);
      print(val['form']['video'].toString().length);
      // return false;
      // set data status to online(true)
      val['submitted_date'] = DateTime.now().millisecondsSinceEpoch;
      await formDb.updateForm(val['_id'], val);
      // check if video or image have data and they are not url
      // pass to http post if video and image have data and they are both url , or they dont have any data.
      if (val['form']['video'].startsWith('https:') == false &&
          val['form']['video'].toString().length > 10) {
        throw new Exception(
            "fail to upload video , try again ,or chack your connection");
      }
      if (val['form']['picha'].startsWith('https:') == false &&
          val['form']['picha'].toString().length > 10) {
        throw new Exception(
            "fail to upload image , try again ,or chack your connection");
      }
      //

      // replace json string to id
      // val['form'] = {};
      var mkoa = json.decode(val['form']['mkoa'])['region_id'];
      var aina = json.decode(val['form']['aina'])['id'];
      var wilaya = json.decode(val['form']['wilaya'])['district_id'];
      var wadi = json.decode(val['form']['wadi'])['ward_id'];

      var dt = {
        ...val,
        'form': {
          "mkoa": mkoa,
          "aina": aina,
          "wilaya": wilaya,
          "wadi": wadi,
          'barabara': val['form']['barabara'],
          "maelezo": val['form']['maelezo'],
          "number": val['form']['number'],
          "kazi": val['form']['kazi'],
          "picha": val['form']['picha'],
          "video": val['form']['video']
        },
        'status': true,
      };
      val['status'] = true;
      Response response;
      Map<String, dynamic> body = dt;
      print(dt);
      print('------------------  you ---------------------');
      print(val);
      response = await dio.post(
        '${_connect.baseUrl}/request.php?action=register-service',
        data: body,
        // options:
        //     new Options(contentType: ContentType.parse("application/json"))
      );
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while upload  data");
      }

      // set data status to online(true)
      var cc = await formDb.updateForm(val['_id'], {'status': true});
      print(cc);
      print('------------------  exit ---------------------');
      // pop  loading dialog
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      // print(response);
      // print('666666666666666666666666666666666666666666');
      Flushbar(
        title: "succesfully Uploading",
        message: 'Taarifa imefanikiwa kutumwa',
        duration: Duration(seconds: 4),
      )..show(context);
      return response;
    } catch (e) {
      // pop out  loading dialog
      print(e);
      Flushbar(
        title: "Fail to Uploading",
        message: 'connection fails, form will store offline',
        duration: Duration(seconds: 4),
      )..show(context).then((onValue) {
          Navigator.pop(context);
          Navigator.of(context).pop();
        });
    }
  }

  Future backgroundUpload(Map<String, dynamic> val, context) async {
    Connectivity _connectivity = Connectivity();
    try {
      if (val['status']) {
        throw new Exception("taarifa haiwezi tuma mara mbili");
      }

      bool connectionStatus = await _connectivity.connection();
      if (connectionStatus == false) {
        // await formDb.updateForm(val['_id'], val);
        throw new Exception("connection fails, form will store offline");
      }

      List func = ['picha', 'video'];
      var result = func.map((f) async {
        if (f == 'video') {
          if (val['form']['video'].startsWith('https:') == false &&
              val['form']['video'].toString().length > 10) {
            var res = await _uploadFunc
                .uploadvideo(File(val['form']['video']), 'videos')
                .catchError((onError) => {
                      Flushbar(
                        title: "Fail to upload video",
                        message: onError.toString(),
                        duration: Duration(seconds: 5),
                      )..show(context)
                    });
            print(res);
            return val['form']['video'] = res;
          }
        }
        if (f == 'picha') {
          if (val['form']['picha'].startsWith('https:') == false &&
              val['form']['picha'].toString().length > 10) {
            print(val['form']['picha']);

            var res = await _uploadFunc
                .uploadvideo(File(val['form']['picha']), 'images')
                .catchError((onError) => {
                      Flushbar(
                        title: "Fail to upload picture",
                        message: onError.toString(),
                        duration: Duration(seconds: 5),
                      )..show(context)
                    });
            print(res);
            return val['form']['picha'] = res;
          }
        }
      });
      await Future.wait(result);

      // return false;
      // set data status to online(true)
      val['submitted_date'] = DateTime.now().millisecondsSinceEpoch;
      await formDb.updateForm(val['_id'], val);
      // check if video or image have data and they are not url
      // pass to http post if video and image have data and they are both url , or they dont have any data.
      if (val['form']['video'].startsWith('https:') == false &&
          val['form']['video'].toString().length > 10) {
        throw new Exception(
            "fail to upload video , try again ,or chack your connection");
      }
      if (val['form']['picha'].startsWith('https:') == false &&
          val['form']['picha'].toString().length > 10) {
        throw new Exception(
            "fail to upload image , try again ,or chack your connection");
      }
      //

      // replace json string to id
      // val['form'] = {};
      var mkoa = json.decode(val['form']['mkoa'])['region_id'];
      var aina = json.decode(val['form']['aina'])['id'];
      var wilaya = json.decode(val['form']['wilaya'])['district_id'];
      var wadi = json.decode(val['form']['wadi'])['ward_id'];
      var dt = {
        ...val,
        'form': {
          "mkoa": mkoa,
          "aina": aina,
          "wilaya": wilaya,
          "wadi": wadi,
          'barabara': val['form']['barabara'],
          "maelezo": val['form']['maelezo'],
          "number": val['form']['number'],
          "kazi": val['form']['kazi'],
          "picha": val['form']['picha'],
          "video": val['form']['video']
        },
        'status': true,
      };
      val['status'] = true;
      Response response;
      Map<String, dynamic> body = dt;
      response = await dio.post(
        '${_connect.baseUrl}/request.php?action=register-service',
        data: body,
        // options:
        //     new Options(contentType: ContentType.parse("application/json"))
      );
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while upload  data");
      }

      // set data status to online(true)
      // var cc = await formDb.updateForm(val['_id'], {'status': true});
      print(
          '=================================  succesfuly upload ====================================');
      return response;
    } catch (e) {}
  }
}
