import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:async_resource/file_resource.dart';
import 'package:flutter/services.dart';
import 'package:justine/db/form-db.dart';
import 'package:justine/util/connectivity.dart';
import 'package:path_provider/path_provider.dart';

class DistrictData {
  final String district_name;
  final int district_id;
  final int region_id;

  DistrictData(this.district_name, this.region_id, this.district_id);
}

class AinaData {
  final String name;

  final int id;
  AinaData(this.name, this.id);
}

class MikoaData {
  final dynamic region_name;
  final dynamic region_id;

  MikoaData(this.region_id, this.region_name);
}

class ApiData {
  Connectivity _connect = Connectivity();
  FormDb formDb = FormDb();
  String regioneUrl = '/request.php?action=get-regions';
  String districtUrl = '/request.php?action=get-districts';
  String ainaUrl = '/request.php?action=get-types';
  // 'http://10.0.2.2:5000';
  List values;
  Dio dio = new Dio();

  Future getMikoa() async {
    try {
      var data = await rootBundle.loadString('assets/jsons/mikoa.json');
      print(data);
      return json.decode(data);
      // final path = (await getApplicationDocumentsDirectory()).path;
      // print(path);
      // final myDataResource = HttpNetworkResource<dynamic>(
      //   url: _connect.baseUrl + regioneUrl,
      //   parser: (contents) => jsonDecode(contents),
      //   cache: FileResource(File('$path/mikoa.json')),
      //   maxAge: Duration(minutes: 1),
      //   strategy: CacheStrategy.cacheFirst,
      // );

      // var data = await myDataResource.get(forceReload: true);
      // return data;
    } catch (e) {
      print(e);
    }
  }
Future getward() async {
    try {
      var data = await rootBundle.loadString('assets/jsons/ward.json');
      return json.decode(data);
      // final path = (await getApplicationDocumentsDirectory()).path;
      // print(path);
      // final myDataResource = HttpNetworkResource<dynamic>(
      //   url: _connect.baseUrl + districtUrl,
      //   parser: (contents) => jsonDecode(contents),
      //   cache: FileResource(File('$path/wilaya.json')),
      //   maxAge: Duration(minutes: 1),
      //   strategy: CacheStrategy.cacheFirst,
      // );

      // var data = await myDataResource.get(forceReload: true);
      // return data;
    } catch (e) {
      print(e);
    }
  }

  Future getDistrict() async {
    try {
      var data = await rootBundle.loadString('assets/jsons/district.json');
      return json.decode(data);
      // final path = (await getApplicationDocumentsDirectory()).path;
      // print(path);
      // final myDataResource = HttpNetworkResource<dynamic>(
      //   url: _connect.baseUrl + districtUrl,
      //   parser: (contents) => jsonDecode(contents),
      //   cache: FileResource(File('$path/wilaya.json')),
      //   maxAge: Duration(minutes: 1),
      //   strategy: CacheStrategy.cacheFirst,
      // );

      // var data = await myDataResource.get(forceReload: true);
      // return data;
    } catch (e) {
      print(e);
    }
  }

  Future getAina() async {
    try {
      var data = await rootBundle.loadString('assets/jsons/aina.json');
      return json.decode(data);
      //final path = (await getApplicationDocumentsDirectory()).path;
      //print(path);
      //final myDataResource = HttpNetworkResource<dynamic>(
        //url: _connect.baseUrl + ainaUrl,
        //parser: (contents) => jsonDecode(contents),
        //cache: FileResource(File('$path/aina.json')),
        //maxAge: Duration(minutes: 60),
        //strategy: CacheStrategy.cacheFirst,
      //);

      //var data = await myDataResource.get(forceReload: true);
      //return data;
    } catch (e) {
      print(e);
    }
  }
}
