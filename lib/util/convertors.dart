import 'dart:convert';

import 'package:async_resource/file_resource.dart';

class Convertor {
  toBase64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}

class Functions {
  String validateMobile(String value) {
    print(value);
    print(value.runtimeType);
    print(value.length);
    String patttern = r'(^(?:[+0]9)?[0-9]{10,10}$)';
    RegExp regExp = new RegExp(patttern);
    // print(regExp.hasMatch(value));
    // if (value.length == 0) {
    //   print('return null');
    //   return null;
    // } else if (!regExp.hasMatch(value)) {
    //   print('return f message');
    //   return 'Please enter valid mobile number';
    // }
    // print('return fail message');
    //val.isEmpty ? 'value is required' : null,
    if (value.isEmpty)
      return 'Tafadhali jaza namba ya simu';
    else if (!regExp.hasMatch(value))
      return 'Namba ya simu inatakiwa iwe(0784xxxxxx)';
    else
      return null;

// Indian Mobile number are of 10 digit only
    // if (value.isEmpty) {
    //   return null;
    // }

    // if (value.length != 10)
    //  { return 'Mobile Number must be of 10 digit';}
    // else
    //   {return null;}
  }
}
