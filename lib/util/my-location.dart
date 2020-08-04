import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class Mylocation {
  LocationData currentLocation;
  String error;
  var location = new Location();
  Stream onExit;

  Future<Stream> getLocation(context) async {
    var controller = new StreamController();
    onExit = controller.stream;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await Location().requestPermission();
      currentLocation = await location.getLocation();
      location.onLocationChanged().listen((LocationData currentLocation) {
        controller.add(currentLocation);
      });
      //  return currentLocation ;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask user to enable it from app settings';
      }
      Flushbar(
        title: "Location Error",
        message: '$error',
        duration: Duration(seconds: 10),
      )..show(context);
      // currentLocation = null;
      controller.close();
    }
    return controller.stream;
  }
}
