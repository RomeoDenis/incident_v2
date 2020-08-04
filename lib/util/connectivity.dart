import 'dart:io';

class Connectivity {
  // base url
  String baseUrl = 'https://incident.roadsfund.go.tz';
  //String baseUrl = 'https://roadsfund.go.tz/incident';
  // checking for connection
  Future<bool> connection() async {
    bool status = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return status = true;
      }
    } on SocketException catch (_) {
      return status = false;
    }
    return status;
  }
}
