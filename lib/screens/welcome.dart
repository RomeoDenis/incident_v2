import 'package:flutter/material.dart';
import 'package:justine/screens/home.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      height: MediaQuery.of(context).size.height,
      // padding: EdgeInsets.symmetric(horizontal: ),
      decoration: BoxDecoration(
          image: DecorationImage(
            //image: new ExactAssetImage('assets/images/roadbackground.png'),
            image: new ExactAssetImage('assets/images/tanroads.png'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Color(0XFF7f933d),
                Color(0XFF4d7e46),
                Color(0XFF2e5536),
                Color(0xFF2c5334),
                Color(0XFF294f36)
              ])),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:100),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                
                // width: 100,
                child: Image.asset('assets/launcher/icon.png',width: 300,)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        //color: Color(0XFF7f933d),
                        color: Color(0XFFf1ce1b),
                        fontWeight: FontWeight.w900,
                        fontSize: 25.0,
                      ),
                      text: 'Bodi Ya Mfuko Wa Barabara  Tanzania',
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 3.0, color: Color(0XFFf1ce1b)),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.center,

                    // overflow: TextOverflow.visible,
                    text: TextSpan(
                      style: TextStyle(
                        color: Color(0XFFcdd8d0),
                        // fontWeight: FontWeight.w900,
                        backgroundColor: Colors.black.withOpacity(0.2),
                        // fontFamily: 'Trajan Pro',
                        fontSize: 20.0,
                      ),
                      text:
                          'Bodi Ya Barabara  Tanzania , inakuletea mfumo wa ukusanyaji wa taarifa zinazohusu uharibifu wa barabara pamoja na miundombinu yake',
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    )
                  },
                  child: new Container(
                    //width: 100.0,
                    height: 50.0,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: new BoxDecoration(
                      color: Color(0XFFf1ce1b),
                      // border: new Border.all(color: Colors.white, width: 2.0),
                      // borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: new Center(child: Text('ANZA HAPA')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
