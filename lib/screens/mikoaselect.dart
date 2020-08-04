import 'package:flutter/material.dart';
import 'package:justine/services/data-api.dart';

typedef void MikoaDialogCallback(Map result);

class MikoaDialog extends StatefulWidget {
  final MikoaDialogCallback onSubmit;
  final String dialogType;
  final String reginalId;
  final String districtId;
  final String districtName;
  MikoaDialog(
      {this.onSubmit,
      this.dialogType,
      this.reginalId,
      String reginalName,
      this.districtId,
      this.districtName});

  @override
  _MikoaDialogState createState() => _MikoaDialogState();
}

class _MikoaDialogState extends State<MikoaDialog> {
  Map value = {};
  TextEditingController controller = new TextEditingController();
  List<dynamic> _listViewData = [];
  List<dynamic> _listViewDataOrginal = [];
  ApiData offlineData = ApiData();
  onSearchTextChanged(String text) async {
    print(text);
    // _searchResult.clear();
    if (text.isEmpty) {
      setState(() {
        _listViewData = _listViewDataOrginal;
      });
      return;
    }

    setState(() {
      if (widget.dialogType == 'mikoa') {
        _listViewData = _listViewData
            .where((d) =>
                d['region_name'].toLowerCase().contains(text.toLowerCase()))
            .toList();
      } else if (widget.dialogType == 'Wilaya') {
        _listViewData = _listViewData
            .where((d) =>
                d['district_name'].toLowerCase().contains(text.toLowerCase()))
            .toList();
      } else if (widget.dialogType == 'aina') {
        _listViewData = _listViewData
            .where((d) => d['name'].toLowerCase().contains(text.toLowerCase()))
            .toList();
      }

      print(_listViewData);
    });
  }

  @override
  void initState() {
    try {
      if (widget.dialogType == 'mikoa') {
        offlineData.getMikoa().then((onValue) {
          setState(() {
            _listViewDataOrginal = onValue;
            _listViewData = onValue;
          });
        });
      } else if (widget.dialogType == 'wilaya') {
        offlineData.getDistrict().then((onValue) {
          setState(() {
            _listViewDataOrginal = onValue;
            _listViewData = onValue;
            print(widget.reginalId);
            _listViewData = _listViewData
                .where((f) => f['region_id'] == widget.reginalId)
                .toList();
            print(_listViewData);
          });
        });
      } else if (widget.dialogType == 'wadi') {
        offlineData.getward().then((onValue) {
          setState(() {
            _listViewDataOrginal = onValue;
            _listViewData = onValue;
            print(widget.districtId);
            _listViewData = _listViewData
                .where((f) => f['district_id'] == widget.districtId)
                .toList();
            print(_listViewData);
          });
        });
      } else if (widget.dialogType == 'aina') {
        offlineData.getAina().then((onValue) {
          setState(() {
            _listViewDataOrginal = onValue;
            _listViewData = onValue;
          });
        });
      }
    } catch (e) {
      _listViewDataOrginal = null;
      _listViewData = null;
    }
    super.initState();
  }

  Widget titleDialog() {
    if (widget.dialogType == 'mikoa') {
      return Text('Chagua Mikoa');
    } else if (widget.dialogType == 'disctrit') {
      return Text('Chagua Wilaya');
    } else if (widget.dialogType == 'wadi') {
      return Text('Chagua Wadi');
    } else if (widget.dialogType == 'aina') {
      return Text('Chagua Aina');
    }
    return Container();
  }

  radiooptions() {
    if (widget.dialogType == 'mikoa') {
      return _listViewData
          .map(
            (val) => new RadioListTile(
              value: val,
              groupValue: value,
              title: Text(val['region_name'].toString()),
              // subtitle: Text("Radio 2 Subtitle"),
              onChanged: (value) {
                setState(() {
                  this.value = value;
                });
              },
              activeColor: Colors.green,
            ),
          )
          .toList();
    } else if (widget.dialogType == 'wilaya') {
      return _listViewData
          .map((val) => new RadioListTile(
                value: val,
                groupValue: value,
                title: Text(val['district_name'].toString()),
                // subtitle: Text("Radio 2 Subtitle"),
                onChanged: (value) {
                  setState(() {
                    this.value = value;
                  });
                },
                activeColor: Colors.green,
              ))
          .toList();
    } else if (widget.dialogType == 'wadi') {
      return _listViewData
          .map((val) => new RadioListTile(
                value: val,
                groupValue: value,
                title: Text(val['ward_name'].toString()),
                // subtitle: Text("Radio 2 Subtitle"),
                onChanged: (value) {
                  setState(() {
                    this.value = value;
                  });
                },
                activeColor: Colors.green,
              ))
          .toList();
    } else if (widget.dialogType == 'aina') {
      return _listViewData
          .map((val) => new RadioListTile(
                value: val,
                groupValue: value,
                title: Text(val['name'].toString()),
                // subtitle: Text("Radio 2 Subtitle"),
                onChanged: (value) {
                  setState(() {
                    this.value = value;
                  });
                },
                activeColor: Colors.green,
              ))
          .toList();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(child: titleDialog()),
          SizedBox(
            height: 10,
          ),
          _listViewDataOrginal != null
              ? TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                  onChanged: onSearchTextChanged,
                )
              : Container(),
        ],
      ),
      content: Container(
        width: double.maxFinite,
        height: 300.0,
        child: _listViewDataOrginal != null
            ? _listViewDataOrginal.isNotEmpty
                ? ListView(
                    padding: EdgeInsets.all(8.0),
                    //map List of our data to the ListView
                    children: radiooptions())
                : Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
            : Text(
                'Something wrong , check your Connetion',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL', style: TextStyle(color: Colors.green)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            'OK',
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            Navigator.pop(context);
            // if (widget.dialogType == 'mikoa') {
            //   widget.onSubmit(value);
            // } else if (widget.dialogType == 'disctrit') {
            //   widget.onSubmit(value);
            // } else if (widget.dialogType == 'aina') {

            // }
            widget.onSubmit(value);
          },
        )
      ],
    );
  }
}
