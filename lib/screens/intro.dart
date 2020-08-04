import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
          title: "Menu Kuu",
          styleTitle: TextStyle(
              color:  Color(0XFF294f36),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono'),
          description:
              "Hapa chagua Toa Taarifa kama unahitaji kutuma taarifa za uharibifu.\n",
          styleDescription: TextStyle(
              color:  Color(0XFF294f36),
              fontSize: 20.0,
              fontStyle: FontStyle.italic,
              fontFamily: 'Raleway'),
          pathImage: "assets/images/home.jpeg",
          widthImage: 100),
    );
    slides.add(
      new Slide(
        title: "Fomu ya Taarifa",
        styleTitle: TextStyle(
            color:  Color(0XFF294f36),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Hii fomu inatakiwa ijazwe yote isipokuwa sehemu ya simu ambayo ni ridhaa yako wewe kuiweka au la",
        styleDescription: TextStyle(
            color:  Color(0XFF294f36),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/taarifa form.jpeg",
      ),
    );
    slides.add(
      new Slide(
        title: "Marekebisho Ya Taarifa",
        styleTitle: TextStyle(
            color:  Color(0XFF294f36),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Taarifa ambayo haijatumwa inaweza kurekebishwa",
        styleDescription: TextStyle(
            color:  Color(0XFF294f36),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/taarifa form.jpeg",
      ),
    );
    slides.add(
      new Slide(
        title: "Taarifa Ulizo kusanya",
        styleTitle: TextStyle(
            color:  Color(0XFF294f36),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Hapa utaona taarifa zote ambazo ulishawahi kutuma",
        styleDescription: TextStyle(
            color:  Color(0XFF294f36),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/taarifa list.jpeg",
      ),
    );
  }

  void onDonePress() {
    // Back to the first tab
    this.goToTab(0);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0XFFf1ce1b),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0XFFf1ce1b),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0XFFf1ce1b),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 500.0,
                height: 500.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          leading: BackButton(),
          title: Text('Jinsi Ya Kutumia'),
          gradient: LinearGradient(colors: [
            Color(0XFF7f933d),
             Color(0XFF294f36),
            Color(0XFF2e5536),
          ]),
        ),
        body: IntroSlider(
          // List slides
          slides: this.slides,

          // Skip button
          renderSkipBtn: this.renderSkipBtn(),
          colorSkipBtn: Color(0x33ffcc5c),
          highlightColorSkipBtn: Color(0XFFf1ce1b),

          // Next button
          renderNextBtn: this.renderNextBtn(),

          // Done button
          renderDoneBtn: this.renderDoneBtn(),
          onDonePress: this.onDonePress,
          colorDoneBtn: Color(0x33ffcc5c),
          highlightColorDoneBtn: Color(0XFFf1ce1b),

          // Dot indicator
          colorDot: Color(0XFFf1ce1b),
          sizeDot: 13.0,
          typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

          // Tabs
          listCustomTabs: this.renderListCustomTabs(),
          backgroundColorAllSlides: Colors.white,
          refFuncGoToTab: (refFunc) {
            this.goToTab = refFunc;
          },

          // Show or hide status bar
          shouldHideStatusBar: true,

          // On tab change completed
          onTabChangeCompleted: this.onTabChangeCompleted,
        ));
  }
}
