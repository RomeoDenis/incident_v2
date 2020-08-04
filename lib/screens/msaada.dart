import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Msaada extends StatefulWidget {
  Msaada({Key key}) : super(key: key);

  _MsaadaState createState() => _MsaadaState();
}

class _MsaadaState extends State<Msaada> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: GradientAppBar(
        leading: BackButton(),
        title: Text('Jinsi Ya Kutumia'),
        gradient: LinearGradient(colors: [
          Color(0XFF7f933d),
          Color(0XFF4d7e46),
          Color(0XFF2e5536),
        ]),
      )),
    );
  }
}
