import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Aboutus extends StatefulWidget {
  Aboutus({Key key}) : super(key: key);

  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        leading: BackButton(),
        title: Text('Kuhusu Sisi'),
        gradient: LinearGradient(colors: [
          Color(0XFF7f933d),
          Color(0XFF4d7e46),
          Color(0XFF2e5536),
        ]),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
          //image begins here, you can comment to remove it
             Container(
               width: MediaQuery.of(context).size.width,
               height: 200,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: ExactAssetImage('assets/images/build.webp'),
                   fit: BoxFit.cover,
                 ),
               ),
             ),
             //End of image

            Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  // RichText(
                  //   softWrap: true,
                  //   textAlign: TextAlign.center,
                  //   text: TextSpan(
                  //     style: TextStyle(
                  //       color: Color(0XFFf1ce1b),
                  //       // fontWeight: FontWeight.w900,
                  //       fontSize: 21.0,
                  //     ),
                  //     text: 'Bodi ya Mfuko Wa Barabara  Tanzania',
                  //   ),
                  // ),
                  RichText(
                    softWrap: true,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: TextStyle(
                          color: Color(0XFF2e5536),
                          // fontWeight: FontWeight.w900,
                          fontSize: 18.0,
                        ),
                        // text:
                        //     'Mfuko wa barabara inawezesha wananchi wa Tanzania kutuma taarifa za uharibifu wa miundombinu ya barabara',
                        children: [
                          TextSpan(
                              style: TextStyle(
                                color: Color(0XFFf1ce1b),
                                // fontWeight: FontWeight.w900,
                                fontSize: 21.0,
                              ),
                              text: 'Mission'),
                          TextSpan(
                            text:
                                '\nExcellence in Roads Fund Management for a well maintained public road network',
                          ),
                          TextSpan(
                              style: TextStyle(
                                color: Color(0XFFf1ce1b),
                                // fontWeight: FontWeight.w900,
                                fontSize: 21.0,
                              ),
                              text: '\n \nVision'),
                          TextSpan(
                            text:
                                '\nTo provide sustainable funding for road maintenance to implementing agencies through collection, disbursement and monitoring its utilization for socio-economic wellbeing of the public',
                          ),
                               TextSpan(
                              style: TextStyle(
                                color: Color(0XFFf1ce1b),
                                // fontWeight: FontWeight.w900,
                                fontSize: 21.0,
                              ),
                              text: '\n \nCore Values'),
                          TextSpan(
                            text:
                                '\nIntegrity, transparency,team work and competence',
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
