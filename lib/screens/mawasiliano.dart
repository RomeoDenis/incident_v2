import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Mawasiliano extends StatefulWidget {
  Mawasiliano({Key key}) : super(key: key);

  _MawasilianoState createState() => _MawasilianoState();
}

class _MawasilianoState extends State<Mawasiliano> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: GradientAppBar(
          leading: BackButton(),
          title: Text('Mawasiliano'),
          gradient: LinearGradient(colors: [
            Color(0XFF7f933d),
            Color(0XFF4d7e46),
            Color(0XFF2e5536),
          ]),
        ),
        body: Container(
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //       Color(0XFF7f933d),
          //       Color(0XFF4d7e46),
          //       Color(0XFF2e5536),
          //       Color(0xFF2c5334),
          //       Color(0XFF294f36)
          //     ])),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          // alignment: Alignment.bottomCenter,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.border_color,
                  color: Color(0XFF294f36),
                ),
                title: Text(
                  'Roads Fund Board,\n'
                  'Njedengwa Investment Area,'
                  'Block D, Plot No. 3,\n'
                  'P.O.Box 993,\n'
                  'Dodoma,\n'
                  'Tanzania.',
                  style: TextStyle(color: Color(0XFF294f36)),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.call,
                  color: Color(0XFF294f36),
                ),
                title: InkWell(
                  onTap: () => _launchCaller('+255 26 2963277'),
                  child: Text(
                    '+255 26 2963277/8',
                    style: TextStyle(color: Color(0XFF294f36)),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.email, color: Color(0XFF294f36)),
                title: Text('info@roadsfund.go.tz',
                    style: TextStyle(color: Color(0XFF294f36))),
              )
            ],
          ),
        ),
      ),
    );
  }

  _launchCaller(phone) async {
    var url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
