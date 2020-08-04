import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:justine/db/form-db.dart';
import 'package:justine/screens/update-taarifa.dart';

class ListTaarifa extends StatefulWidget {
  ListTaarifa({Key key}) : super(key: key);

  _ListTaarifaState createState() => _ListTaarifaState();
}

class _ListTaarifaState extends State<ListTaarifa> {
  FormDb _formdb = FormDb();
  bool isLoading = false;
  List _forms = [];
  Color fontGreen = Color(0XFF2e5536);
  @override
  void initState() {
    super.initState();
    // _scrollController = ScrollController()..addListener(() => setState(() {}));
    getResponces();
  }

  getResponces() {
    _formdb.getForms().then((res) => {
          setState(() {
            _forms = res;
            _forms.sort((a, b) =>
                a['created_date'].toString().compareTo(b['created_date'].toString()));
            _forms.sort((a, b) =>
                a['status'].toString().compareTo(b['status'].toString()));

            isLoading = false;
          })
        });
  }

  _dateConvert(date) {
    date = date.runtimeType == int ? date : int.tryParse(date);
    return DateFormat.yMMMMd()
        .format(DateTime.fromMillisecondsSinceEpoch(date));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: GradientAppBar(
            leading: BackButton(),
            title: Text('Orodha Ya Taarifa'),
            gradient: LinearGradient(colors: [
              Color(0XFF7f933d),
              Color(0XFF4d7e46),
              Color(0XFF2e5536),
            ]),
          ),
          body: Container(
              child: isLoading
                  ? loading()
                  : _forms.length == 0
                      ? Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Center(
                            child: Text(
                              'Hakuna Taarifa',
                              style: TextStyle(color: fontGreen, fontSize: 15),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          cacheExtent: 100.0,
                          physics: ClampingScrollPhysics(),
                          itemCount: _forms != null ? _forms.length : 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: EdgeInsets.only(bottom: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        left: BorderSide(
                                            color: _forms[index]['status']
                                                ? Colors.blue.withOpacity(0.7)
                                                : Colors.red.withOpacity(0.7),
                                            width: 5.0))),
                                child: listtileType(_forms[index]));
                          }))),
    );
  }

  Widget listtileType(form) {
    // List imagesTypes = ['picture', 'signature'];

    return
        // imagesTypes.contains(type)
        // ? ListTile(
        //     onTap: () => {
        //       Navigator.of(context)
        //           .push(MaterialPageRoute(
        //               builder: (context) => Editresponce(
        //                     responces: data,
        //                     formName: widget.formName,
        //                     formData: widget.formData,
        //                     userData: widget.userData,
        //                   )))
        //           .then((f) {
        //         getResponces();
        //       }),
        //     },

        //     leading: ConstrainedBox(
        //       constraints: BoxConstraints(
        //         minWidth: 80,
        //         minHeight: 80,
        //         maxWidth: 100,
        //         maxHeight: 100,
        //       ),
        //       child: val.toString().length > 10
        //           ? val.toString().startsWith('https:')
        //               ? Image.network(val.toString(), fit: BoxFit.cover)
        //               : Image.file(File(val.toString()), fit: BoxFit.cover)
        //           : Icon(
        //               Icons.broken_image,
        //               size: 50,
        //             ),
        //     ),
        //     // title: Text(val.toString()),
        //     subtitle: Row(
        //       children: <Widget>[
        //         Expanded(
        //             child: Text('created: ' +
        //                 _dateConvert(data['created_date']).toString()))
        //       ],
        //     ),
        //     trailing: IconButton(
        //       onPressed: () => {},
        //       icon: Icon(Icons.more_horiz),
        //     ),
        //   )
        // :
        ListTile(
      onTap: () => {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => UpdateTaarifaForm(formData: form)))
            .then((f) {
          getResponces();
        }),
      },
      // leading: IconButton(
      //   onPressed: () => {},
      //   icon: Icon(Icons.image),
      // ),
      // startsWith('https:')
      // leading: ConstrainedBox(
      //   constraints: BoxConstraints(
      //     minWidth: 80,
      //     minHeight: 80,
      //     maxWidth: 100,
      //     maxHeight: 100,
      //   ),
      //   child: Image.network(val.toString(), fit: BoxFit.cover),
      // ),
      title: Text('Barabara : ' + form['form']['barabara']),

      subtitle: Row(
        children: <Widget>[
          Expanded(
              child: Text(
                  'created: ' + _dateConvert(form['created_date']).toString()))
        ],
      ),
      trailing: IconButton(
        onPressed: () => {
          print(form),
          _formdb
              .removeForm(form['_id'])
              .then((onValue) => {
                    getResponces(),
                    Flushbar(
                      title: "succesful removed",
                      message: ' ',
                      duration: Duration(seconds: 2),
                    )..show(context)
                  })
              .catchError((onError) => {
                    print(onError),
                    Flushbar(
                      title: "Fail to removed",
                      message: ' ',
                      duration: Duration(seconds: 2),
                    )..show(context)
                  })
        },
        icon: Icon(Icons.delete),
      ),
    );
  }

  Widget loading() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Loading ',
              style: TextStyle(color: fontGreen),
            )
          ],
        ),
      ),
    );
  }
}
