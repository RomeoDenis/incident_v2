import 'dart:convert';
import 'dart:io';
import 'package:custom_chewie/custom_chewie.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:justine/components/dialog-loading.dart';
import 'package:justine/db/form-db.dart';
import 'package:justine/services/send-taarifa.dart';
import 'package:justine/util/camera.dart';
import 'package:justine/util/convertors.dart';
import 'package:video_player/video_player.dart';
import 'mikoaselect.dart';

class UpdateTaarifaForm extends StatefulWidget {
  final Map<String, dynamic> formData;
  UpdateTaarifaForm({Key key, this.formData}) : super(key: key);

  _UpdateTaarifaFormState createState() => _UpdateTaarifaFormState();
}

class _UpdateTaarifaFormState extends State<UpdateTaarifaForm> {
  CameraFuctions camFunc = CameraFuctions();
  FormDb _formdb = FormDb();
  ApiHelper apiService = ApiHelper();
  // LoadingDialog loadingUpload = LoadingDialog();
  String reginalId;
  String districtId;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerMkoa = new TextEditingController();
  TextEditingController _controllerWilaya = new TextEditingController();
  TextEditingController _controllerWadi = new TextEditingController();

  TextEditingController _controllerAina = new TextEditingController();
  TextEditingController _controllerJina = new TextEditingController();
  TextEditingController _controllerMaelezo = new TextEditingController();

  TextEditingController _controllerKazi = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerPicture = new TextEditingController();
  TextEditingController _controllerVideo = new TextEditingController();

  Color bborderColor = Color(0XFF294f36).withOpacity(0.7);
  Color fontColor = Color(0XFF294f36);
  Color iconColorGreen = Color(0XFF294f36);
  TextStyle fontInputStyle = TextStyle(
      color: Color(0XFF294f36), fontSize: 14, fontWeight: FontWeight.w700);
  TextStyle inputHintStyle = TextStyle(color: Color(0XFF294f36), fontSize: 12);
  VideoPlayerController videoCtr;

  @override
  void dispose() {
    videoCtr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print(widget.formData);
    setState(() {
      print(widget.formData['form']);
      _controllerMkoa.text = widget.formData['form']['mkoa'];
      _controllerWilaya.text = widget.formData['form']['wilaya'];
      _controllerWadi.text = widget.formData['form']['wadi'];
      _controllerAina.text = widget.formData['form']['aina'];
      _controllerJina.text = widget.formData['form']['barabara'];
      _controllerMaelezo.text = widget.formData['form']['maelezo'];
      _controllerKazi.text = widget.formData['form']['kazi'];
      _controllerPhone.text = widget.formData['form']['number'];
      _controllerPicture.text = widget.formData['form']['picha'];
      _controllerVideo.text = widget.formData['form']['video'];
      print(widget.formData['form']);
      videoCtr = widget.formData['form']['video']
              .toString()
              .startsWith('https:')
          ? new VideoPlayerController.network(widget.formData['form']['video'])
          : new VideoPlayerController.file(
              File(widget.formData['form']['video']));
    });
  }

  void setDialogResult(type, TextEditingController v, result) {
    print(result);
    if (type == 'mikoa') {
      setState(() {
        v.text = json.encode(result);
        reginalId = result['region_id'];
      });
    } else if (type == 'wilaya') {
      setState(() {
        v.text = json.encode(result);
        districtId = result['district_id'];
      });
    } else if (type == 'wadi') {
      setState(() {
        v.text = json.encode(result);
        // reginalId = result['district_id'];
      });
    } else if (type == 'aina') {
      setState(() {
        v.text = json.encode(result);
        reginalId = result['id'];
      });
    }

    print(v.text);
  }

  void updateForm() {
    final FormState form = _formKey.currentState;
    print({
      "mkoa": _controllerMkoa.text,
      "aina": _controllerAina.text,
      "barabara": _controllerJina.text,
      "maelezo": _controllerMaelezo.text,
      "number": _controllerPhone.text,
      "picha": _controllerPicture.text,
      "video": _controllerVideo.text
    });
    if (!form.validate() ||
        !(_controllerMkoa.text.isNotEmpty &&
            _controllerWilaya.text.isNotEmpty &&
            _controllerWadi.text.isNotEmpty &&
            _controllerAina.text.isNotEmpty)) {
      Flushbar(
        title: "Invalid Form",
        message: 'Form is not valid! , Please review and correct field.',
        duration: Duration(seconds: 6),
      )..show(context);
    } else {
      form.save();

      var data = {
        "modified_date": DateTime.now().millisecondsSinceEpoch,
        'form': {
          "wilaya": _controllerWilaya.text,
          "mkoa": _controllerMkoa.text,
          "wadi": _controllerWadi.text,
          "aina": _controllerAina.text,
          "barabara": _controllerJina.text,
          "maelezo": _controllerMaelezo.text,
          "kazi": _controllerKazi.text,
          "number": _controllerPhone.text,
          "picha": _controllerPicture.text,
          "video": _controllerVideo.text
        }
      };
      print(data['form']);

      _formdb
          .updateForm(widget.formData['_id'], data)
          .then((v) => {
                print(v),
                Navigator.of(context).pop(),
                Flushbar(
                  title: "Update  Successfully",
                  message: ' ',
                  duration: Duration(seconds: 2),
                )..show(context),
              })
          .catchError((onError) => {
                print(onError),
                Flushbar(
                  title: "fail to update Form",
                  message: ' ',
                  duration: Duration(seconds: 3),
                )..show(context)
              });
    }
  }

  Future<void> imageSourceOption(FormFieldState<dynamic> state) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            Icons.camera_alt,
                            color: iconColorGreen,
                          ),
                        ),
                        // Spacer( flex: 3,),
                        Text('Piga Picha')
                      ],
                    ),
                    onTap: () => {CameraFuctions.openCamera(state, context)},
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            Icons.photo_library,
                            color: iconColorGreen,
                          ),
                        ),
                        // Spacer( flex: 3,),
                        Text('Chagua Kutoka Kwenye Mafaili')
                      ],
                    ),
                    onTap: () => {CameraFuctions.openGallery(state, context)},
                  ),
                ],
              ),
            ),
          );
        });
  }

// Video source option dialog
  Future<void> videoSourceOption(FormFieldState<dynamic> state) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            Icons.videocam,
                            color: iconColorGreen,
                          ),
                        ),
                        // Spacer( flex: 3,),
                        Text('Rekodi Video')
                      ],
                    ),
                    onTap: () async {
                      String path = await camFunc.videoCamera(state, context);
                      setState(() {
                        if (videoCtr != null) {
                          videoCtr.pause();
                        }
                        videoCtr = VideoPlayerController.file(File(path));

                        _controllerVideo.text = path;
                        Navigator.pop(context);
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            Icons.video_library,
                            color: iconColorGreen,
                          ),
                        ),
                        // Spacer( flex: 3,),
                        Text('Chagua Kutoka Kwenye Mafaili')
                      ],
                    ),
                    onTap: () async {
                      String path = await camFunc.videoGallery(state, context);
                      setState(() {
                        videoCtr = VideoPlayerController.file(File(path));

                        _controllerVideo.text = path;
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: GradientAppBar(
          leading: BackButton(),
          title: Text('Repoti Huaribifu'),
          actions: <Widget>[
            IconButton(
                color: Colors.white.withOpacity(.8),
                icon: Icon(Icons.delete),
                onPressed: () {
                  _formdb
                      .removeForm(widget.formData['_id'])
                      .then((onValue) => {
                            Navigator.pop(context),
                            Flushbar(
                              title: "succesfully removed",
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
                          });
                }),
            IconButton(
                color: widget.formData['status']
                    ? Colors.white.withOpacity(.3)
                    : Colors.white.withOpacity(.8),
                icon: Icon(Icons.cloud_upload),
                onPressed: () {
                  uploadData(context);
                })
          ],
          gradient: LinearGradient(colors: [
            Color(0XFF7f933d),
            Color(0XFF4d7e46),
            Color(0XFF2e5536),
          ]),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    child: FormField(
                        validator: (val) =>
                            val.isEmpty ? 'value is required' : null,
                        initialValue: _controllerMkoa.text,
                        builder: (FormFieldState<dynamic> state) {
                          return InkWell(
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) => MikoaDialog(
                                    dialogType: 'mikoa',
                                    onSubmit: (re) => setDialogResult(
                                        'mikoa', _controllerMkoa, re))),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: bborderColor, width: 2))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Mkoa',
                                    style: fontInputStyle,
                                  ),
                                  Text(
                                    _controllerMkoa.text.toString() == ''
                                        ? 'Chagua Mkoa'
                                        : json.decode(_controllerMkoa.text
                                            .toString())['region_name'],
                                    style: inputHintStyle,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: FormField(builder: (FormFieldState<dynamic> state) {
                      return InkWell(
                        onTap: () {
                          if (reginalId == null) {
                            Flushbar(
                              title: "Chagua Mkoa kwanza",
                              message: 'ili uweze kuchagua wilaya yake',
                              duration: Duration(seconds: 4),
                            )..show(context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => MikoaDialog(
                                    dialogType: 'wilaya',
                                    reginalId: reginalId,
                                    reginalName: _controllerMkoa.text,
                                    onSubmit: (re) => setDialogResult(
                                        'wilaya', _controllerWilaya, re)));
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: bborderColor, width: 2))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Wilaya',
                                style: fontInputStyle,
                              ),
                              Text(
                                _controllerWilaya.text == ''
                                    ? 'Chagua Wilaya'
                                    : json.decode(_controllerWilaya.text
                                        .toString())['district_name'],
                                style: inputHintStyle,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: FormField(builder: (FormFieldState<dynamic> state) {
                      return InkWell(
                        onTap: () {
                          if (districtId == null) {
                            Flushbar(
                              title: "Chagua Wilaya kwanza",
                              message: 'ili uweze kuchagua wadi  yake',
                              duration: Duration(seconds: 4),
                            )..show(context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => MikoaDialog(
                                    dialogType: 'wadi',
                                    reginalId: reginalId,
                                    districtId: districtId,
                                    onSubmit: (re) => setDialogResult(
                                        'wadi', _controllerWadi, re)));
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: bborderColor, width: 2))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Wadi',
                                style: fontInputStyle,
                              ),
                              Text(
                                _controllerWadi.text == ''
                                    ? 'Chagua Wadi'
                                    : json.decode(_controllerWadi.text
                                        .toString())['ward_name'],
                                style: inputHintStyle,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: FormField(
                        initialValue: _controllerAina.text,
                        builder: (FormFieldState<dynamic> state) {
                          return InkWell(
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) => MikoaDialog(
                                    dialogType: 'aina',
                                    onSubmit: (re) => setDialogResult(
                                        'aina', _controllerAina, re))),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: bborderColor, width: 2))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Chagua Aina',
                                    style: fontInputStyle,
                                  ),
                                  Text(
                                    _controllerAina.text.toString() == ' '
                                        ? 'Aina ya uharibifu'
                                        : json.decode(_controllerAina.text
                                            .toString())['name'],
                                    style: inputHintStyle,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: bborderColor, width: 2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Jina La Barabara',
                          style: fontInputStyle,
                        ),
                        TextFormField(
                            controller: _controllerJina,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: inputHintStyle,
                                hintText: 'Mf:Dodoma - Mpwapwani'),
                            style: inputHintStyle,
                            validator: (val) =>
                                val.isEmpty ? 'value is required' : null,
                            onSaved: (val) => {}),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: bborderColor, width: 2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Maelezo',
                          style: fontInputStyle,
                        ),
                        TextFormField(
                            controller: _controllerMaelezo,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: inputHintStyle,
                                hintText: 'Andika Maelezo Hapa'),
                            style: inputHintStyle,
                            validator: (val) =>
                                val.isEmpty ? 'value is required' : null,
                            onSaved: (val) => {}),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: bborderColor, width: 2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Kazi yako ni nini',
                          style: fontInputStyle,
                        ),
                        TextFormField(
                            controller: _controllerKazi,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: inputHintStyle,
                                hintText: 'Andika kazi yako'),
                            style: inputHintStyle,
                            // validator: (val) =>
                            //     val.isEmpty ? 'value is required' : null,
                            onSaved: (val) => {}),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: bborderColor, width: 2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Namba ya simu Kama unaitaji mrejesho',
                          style: fontInputStyle,
                        ),
                        TextFormField(
                          controller: _controllerPhone, maxLines: null,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: inputHintStyle,
                              hintText: 'Mf:0784XXXXXX'),
                          style: inputHintStyle,
                          validator: Functions().validateMobile,
                          // onSaved: (val) => {}
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: bborderColor, width: 2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Picha Ya Tukio',
                          style: fontInputStyle,
                        ),
                        FormField(
                            // autovalidate: true,
                            initialValue: _controllerPicture.text,
                            onSaved: (value) {
                              setState(() {
                                _controllerPicture.text = value;
                              });
                            },
                            // validator: (val) =>
                            //     val.isEmpty ? 'Picture  is required' : null,
                            builder: (FormFieldState<dynamic> state) {
                              return InkWell(
                                  onTap: () => imageSourceOption(state),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        color: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                state.value.toString().length <
                                                        1
                                                    ? IconButton(
                                                        color: iconColorGreen,
                                                        icon: Icon(
                                                            Icons.add_a_photo),
                                                        onPressed: () => {},
                                                      )
                                                    : Container(),
                                                state.value.toString().length >
                                                        10
                                                    ? state.value
                                                            .toString()
                                                            .startsWith(
                                                                'https:')
                                                        ? Image.network(
                                                            state.value,
                                                            fit: BoxFit.cover,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                60,
                                                          )
                                                        : Image.file(
                                                            File(state.value),
                                                            fit: BoxFit.cover,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                60,
                                                            // height: 400.0,
                                                          )
                                                    // Image.memory(
                                                    //     base64Decode(state.value
                                                    //         .toString()
                                                    //         .split(',')[1]),
                                                    //     fit: BoxFit.cover,
                                                    //     width: MediaQuery.of(
                                                    //                 context)
                                                    //             .size
                                                    //             .width -
                                                    //         60,
                                                    //     // height: 400.0,
                                                    //   )
                                                    : Text(
                                                        'Piga Picha',
                                                        style: TextStyle(
                                                            // color: Colors.white70,
                                                            fontSize: 14),
                                                      ),
                                              ],
                                            ),
                                            state.value.toString().length > 10
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      IconButton(
                                                        color: iconColorGreen,
                                                        icon: Icon(
                                                            Icons.add_a_photo),
                                                        onPressed: () => {
                                                          imageSourceOption(
                                                              state)
                                                        },
                                                      ),
                                                      IconButton(
                                                        color: iconColorGreen,
                                                        icon:
                                                            Icon(Icons.delete),
                                                        //TODO : add remove picture

                                                        onPressed: () => {},
                                                      ),
                                                    ],
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: bborderColor, width: 2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Video Ya Tukio',
                          style: fontInputStyle,
                        ),
                        _controllerVideo.text.length > 6
                            ? Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Chewie(
                                  videoCtr,
                                  autoInitialize: true,
                                  // autoPlay: true,
                                  // looping: false,

                                  // Try playing around with some of these other options:
                                  // showControls: false,
                                  materialProgressColors:
                                      new ChewieProgressColors(
                                    playedColor: Colors.red,
                                    handleColor: Colors.blue,
                                    backgroundColor: Colors.grey,
                                    bufferedColor: Colors.lightGreen,
                                  ),
                                  placeholder: new Container(
                                    color: Colors.grey,
                                  ),
                                  // autoInitialize: true,
                                ),
                              )
                            : Container(),
                        FormField(
                            // autovalidate: true,
                            initialValue: _controllerVideo.text,
                            onSaved: (value) {},
                            // validator: (val) =>
                            //     val.isEmpty ? 'Video is required' : null,
                            builder: (FormFieldState<dynamic> state) {
                              return InkWell(
                                  onTap: () async {
                                    videoSourceOption(state);
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        color: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            _controllerVideo.text.isEmpty ==
                                                        false &&
                                                    _controllerVideo
                                                            .text.length >
                                                        5
                                                ? Column(
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          IconButton(
                                                            color:
                                                                iconColorGreen,
                                                            icon: Icon(
                                                                Icons.videocam),
                                                            onPressed: () => {
                                                              videoSourceOption(
                                                                  state)
                                                            },
                                                          ),
                                                          IconButton(
                                                            color:
                                                                iconColorGreen,
                                                            icon: Icon(
                                                                Icons.delete),
                                                            //TODO : add remove picture

                                                            onPressed: () => {},
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                _controllerVideo.text.length < 5
                                                    ? Row(
                                                        children: <Widget>[
                                                          IconButton(
                                                            color:
                                                                iconColorGreen,
                                                            icon: Icon(
                                                                Icons.videocam),
                                                            onPressed: () => {},
                                                          ),
                                                          Text(
                                                            'Rekodi Video',
                                                            style: TextStyle(
                                                                color:
                                                                    iconColorGreen,
                                                                fontSize: 14),
                                                          )
                                                        ],
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () => {uploadData(context)},
                          child: new Container(
                            //width: 100.0,
                            height: 50.0,
                            // margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: new BoxDecoration(
                              color: widget.formData['status']
                                  ? Color(0XFFf1ce1b).withOpacity(0.2)
                                  : Color(0XFFf1ce1b),
                              // border: new Border.all(color: Colors.white, width: 2.0),
                              // borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: new Center(child: Text('Tuma Taarifa')),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => {
                            if (widget.formData['status'])
                              {
                                Flushbar(
                                  title: "Taarifa Ilikwisha Tumwa",
                                  message:
                                      'taarifa ikitumwa haiwezi rekebishwa',
                                  duration: Duration(seconds: 5),
                                )..show(context),
                              }
                            else
                              {updateForm()}
                          },
                          child: new Container(
                            //width: 100.0,
                            height: 50.0,
                            // margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: new BoxDecoration(
                              color: widget.formData['status']
                                  ? Color(0XFFf1ce1b).withOpacity(0.2)
                                  : Color(0XFFf1ce1b),
                              // border: new Border.all(color: Colors.white, width: 2.0),
                              // borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: new Center(child: Text('Rekebisha Taarifa')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void uploadData(context) {
    try {
      if (widget.formData['status']) {
        Flushbar(
          title: "Taarifa Ilikwisha Tumwa",
          message: 'taarifa ikitumwa haiwezi rekebishwa',
          duration: Duration(seconds: 5),
        )..show(context);
        return;
      }
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => LoadingDialog());
      apiService.singleUploadingData(widget.formData, context);
    } catch (e) {}
  }

  // Image source option dialog
}
