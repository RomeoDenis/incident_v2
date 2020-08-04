import 'package:flutter/material.dart';

typedef void LoadingDialogCallback(String result);

class LoadingDialog extends StatefulWidget {
  final LoadingDialogCallback onSubmit;
  final String dialogType;
  LoadingDialog({this.onSubmit, this.dialogType});

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      title: Center(child: Text('Uploading Data')),
      content: Container(
          width: double.maxFinite,
          height: 100.0,
          // width:100,
          child: Center(child: CircularProgressIndicator())),
      // actions: <Widget>[
      //   FlatButton(
      //     child: Text('CANCEL'),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   FlatButton(
      //     child: Text('OK'),
      //     onPressed: () {
      //       Navigator.pop(context);
      //       // widget.onSubmit(value);
      //     },
      //   )
      // ],
    );
  }
}
