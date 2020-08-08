// import 'dart:io';
// import 'dart:typed_data';

// import 'package:camera/camera.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraFuctions {
  static Future openCamera(FormFieldState<dynamic> state, context) async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    print(image.path);
    state.didChange(image.path);
    Navigator.pop(context);
  }

  static Future openGallery(FormFieldState<dynamic> state, context) async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    // List<int> imageBytes = image.readAsBytesSync();
    // String imageB64 = base64Encode(imageBytes);
    // print(imageB64);
    // image.path
    print(
        'kkkkkk  ------- jjjjjjjj  ------ jjjjjdsfsfdfdf  ------- dfsdfdfsfdf  ');
    print(image.path);
    // File imageFile = new File(image.path);
    //  Uint8List imageBytes = await imageFile.readAsBytes();
    // String imageB64 = base64Encode(imageBytes);
    // print(imageB64);
    // print('data:image/${extension(image.path).split('.')[1]};base64,' + imageB64);
// data:image/png;base64
    // print(extension(image.path));
    state.didChange(image.path);
    Navigator.pop(context);
    return image.path;
  }

  Future videoCamera(FormFieldState<dynamic> state, context) async {
    var image = await ImagePicker.pickVideo(
      source: ImageSource.camera,
    );
    return image.path;
  }

  Future videoGallery(FormFieldState<dynamic> state, context) async {
    var image = await ImagePicker.pickVideo(
      source: ImageSource.gallery,
    );

    return image.path;
  }
}
