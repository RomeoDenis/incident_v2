import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:justine/db/init-welcome.dart';
// import 'package:flutter/services.dart';
import 'package:justine/screens/welcome.dart';
import 'package:justine/services/data-api.dart';

import 'screens/home.dart';

Future main() async {
  // Set default home.
  Widget _defaultHome = Welcome();

  try {
    // InitWelcome inti = InitWelcome();
    // final List res = await inti.checkdata();
    // print(res);
    // if (res.isNotEmpty) {
    //   _defaultHome = Homepage();
    // } else {
    //   ApiData apiOffline = ApiData();
    //   // cache data for offline use
    //   apiOffline.getAina();
    //   apiOffline.getDistrict();
    //   apiOffline.getMikoa();
    //   //
    //   inti.storeForm({});
    // }
  } catch (e) {}
  runApp(MyApp(defaultHome: _defaultHome));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final defaultHome;
  MyApp({Key key, this.defaultHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Color(0XFF2e5536)));

    return MaterialApp(
      // title: 'Mfuko wa barabara -  Tanzania',
      debugShowCheckedModeBanner: false,
      // color: Colors.blueGrey,

      theme: ThemeData(
        primarySwatch: Colors.blue,

        // appBarTheme:  AppBarTheme.of(context)
      ),
      home: defaultHome,
    );
  }
}
