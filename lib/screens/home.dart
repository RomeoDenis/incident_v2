import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:justine/db/form-db.dart';
import 'package:justine/screens/aboutus.dart';
import 'package:justine/screens/intro.dart';
import 'package:justine/screens/list-taarifa.dart';
import 'package:justine/screens/mawasiliano.dart';
import 'package:connectivity/connectivity.dart';
import 'package:justine/services/send-taarifa.dart';
import 'package:justine/util/connectivity.dart' as conn;
import 'form-taarifa.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var subscription;
  conn.Connectivity _connectivity = conn.Connectivity();
  FormDb _formdb = FormDb();
  ApiHelper apiService = ApiHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    subscription = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      print(result.toString());
      if (result.toString() == 'ConnectivityResult.none') {
        // Connectivity().
      }
      bool connectionStatus = await _connectivity.connection();
      if (connectionStatus == false) {
        Flushbar(
          title: "Connection Status",
          message: 'No connection',
          duration: Duration(seconds: 4),
        )..show(context);
      } else {
        Flushbar(
          title: "Connection Status",
          message: 'your connected',
          duration: Duration(seconds: 4),
        )..show(context);

        try {
          List forms = await _formdb.getForms();

          forms.forEach((f) => {
                // print(f),
                if (!f['status'])
                  {print(f['_id']), apiService.backgroundUpload(f, context)}
              });
        } catch (e) {
          print(e);
        }
        // .then((res) => {
        //   List forms= res,
        //   // forms.
        //       setState(() {
        //         _forms = res;
        //         _forms.sort((a, b) => a['created_date']
        //             .toString()
        //             .compareTo(b['created_date'].toString()));
        //         _forms.sort((a, b) =>
        //             a['status'].toString().compareTo(b['status'].toString()));

        //         isLoading = false;
        //       })
        //     });
        //  apiService.singleUploadingData(widget.formData, context);
      }
      // Got a new connectivity status!
    });
    super.initState();
  }

  @override
  void dispose() {
    // subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // appBar: AppBar(
        //   leading:
        // ),
        drawer: drawerWidget(),
        body: Center(
            child: Container(
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.symmetric(horizontal: ),
          decoration: BoxDecoration(
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
          child: Container(
              // padding: EdgeInsets.only(top: 80),
              child: ListView(
            physics: ScrollPhysics(),
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                child: RichText(
                  softWrap: true,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Color(0XFFf1ce1b),
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Trajan Pro',
                      fontSize: 25.0,
                    ),
                    text: 'Bodi ya Mfuko Wa Barabara  Tanzania',
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: OrientationBuilder(builder: (context, orientation) {
                  return GridView.count(
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    // crossAxisCount: 2,
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                    shrinkWrap: true,
                    children: <Widget>[
                      cardmenu('Toa Taarifa', Icons.record_voice_over,
                          TaarifaForm()),
                      cardmenu('Taarifa Zilizohifadhiwa', Icons.offline_bolt,
                          ListTaarifa()),
                      cardmenu('Mawasiliano', Icons.phone, Mawasiliano()),
                      cardmenu(
                          'Kuhusu Bodi', Icons.help_outline, Aboutus())
                    ],
                  );
                }),
              ),
            ],
          )),
        )));
  }

  Widget drawerWidget() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
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
        padding: const EdgeInsets.only(left: 16.0, top: 50),
        // color: Colors.green,
        child: Align(
          alignment: Alignment.topLeft,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.all(0.0),
                child: RichText(
                  softWrap: true,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Color(0XFFf1ce1b),
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Trajan Pro',
                      fontSize: 25.0,
                    ),
                    text: 'Menu Kuu',
                  ),
                ),
                decoration: BoxDecoration(
                    // color: Colors.green,
                    ),
              ),
              menuList('Toa Taarifa', Icons.record_voice_over, TaarifaForm()),
              menuList(
                  'Zilizohifadhiwa', Icons.offline_bolt, ListTaarifa()),
              menuList('Mawasiliano', Icons.phone, Mawasiliano()),
              menuList('Jinsi Ya Kutumia', Icons.help_outline, IntroScreen()),
              menuList('Kuhusu Bodi', Icons.supervised_user_circle, Aboutus()),
            ],
          ),
        ),
      ),
    );
  }

  InkWell menuList(String title, icon, page) {
    return InkWell(
        onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              ),
              _scaffoldKey.currentState.removeCurrentSnackBar()
            },
        child: ListTile(
          leading: Icon(
            icon,
            size: 30.0,
            color: Color(0XFFf1ce1b),
          ),
          title: Text("$title",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ));
  }

  Widget cardmenu(title, icon, page) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        )
      },
      child: Card(
          color: Colors.white,
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 80.0,
                    color: Color(0XFF294f36),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ]),
          )),
    );
  }
}
