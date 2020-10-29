import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:doop/component/dots_indicator.dart';
import 'package:doop/component/progress_chart.dart';
import 'package:doop/component/triangle_top_blue_header.dart';
import 'package:doop/component/triangle_top_header.dart';
import 'package:doop/model/graph_entry.dart';
import 'package:doop/screen/onboarding/onboarding_animation.dart';

import '../../main.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  AnimationController animationController;
  OnBoardingEnterAnimation onBoardingEnterAnimation;

  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  List<Widget> _pages = <Widget>[
    _getPagerItem(),
    _getPagerItem(),
    _getPagerItem()
  ];

  @override
  void initState() {
    getLen();
    super.initState();
    animationController = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            break;
          case AnimationStatus.reverse:
            break;
          case AnimationStatus.completed:
            break;
          case AnimationStatus.dismissed:
            Navigator.pushNamed(context, "/activity");
            break;
        }
      });

    onBoardingEnterAnimation = OnBoardingEnterAnimation(animationController);

    animationController.forward();
  }

  getLen() async {
    var snap = Firestore.instance.collection("Users").snapshots();
    snap.forEach((element) {
      setState(() async {
        len = element.documents.length;
        print(element.documents.first.documentID);
      });
    });
    setState(() {
      print(
          "========================================================================================================================================$len");
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getLen();
    var size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _getTopBlueTriangle(size),
          _getTopTriangle(size),
          _getGraphLabel(size, textTheme),
          _setActivityData(
              textTheme,
              size.width * 0.1,
              size.height * 0.1,
              DailyActivityModel(label: "Visitors", valueUnitList: [
                UnitValueModel(value: "19", unit: ""),
              ]),
              onBoardingEnterAnimation.dailyActivity1translation.value),
          _setActivityData(
              textTheme,
              size.width * 0.45,
              size.height * 0.1,
              DailyActivityModel(label: "Active Volunteers", valueUnitList: [
                UnitValueModel(value: len.toString(), unit: "")
              ]),
              onBoardingEnterAnimation.dailyActivity1translation.value),
          _setActivityData(
              textTheme,
              size.width * 0.1,
              size.height * 0.22,
              DailyActivityModel(
                  label: "Locations",
                  valueUnitList: [UnitValueModel(value: "18", unit: "")]),
              onBoardingEnterAnimation.dailyActivity1translation.value),
          _setActivityData(
              textTheme,
              size.width * 0.45,
              size.height * 0.22,
              DailyActivityModel(
                  label: "Batches",
                  valueUnitList: [UnitValueModel(value: "0", unit: "")]),
              onBoardingEnterAnimation.dailyActivity1translation.value),
          _setActivityData(
              textTheme,
              size.width * 0.1,
              size.height * 0.34,
              DailyActivityModel(
                  label: "Attendance",
                  valueUnitList: [UnitValueModel(value: "70%", unit: "")]),
              onBoardingEnterAnimation.dailyActivity1translation.value),
          _createLineChart(size, textTheme),
          _createPagerIndicator(size),
          _getActivityPager(size, textTheme),
          _getFab(size),
        ],
      ),
    );
  }

  _getTopTriangle(Size size) => Positioned(
      left: 0,
      right: 0,
      bottom: size.height * 0.45,
      child: Transform(
        transform: Matrix4.translationValues(0,
            -onBoardingEnterAnimation.whiteCutBackgroundYtranslation.value, 0),
        child: TriangleTopHeader(
          child: Container(
            color: Colors.white,
            height: size.height,
          ),
        ),
      ));

  _getTopBlueTriangle(Size size) => Positioned(
      left: 0,
      right: 0,
      bottom: size.height * 0.3,
      child: Transform(
        transform: Matrix4.translationValues(
            onBoardingEnterAnimation.blueCutBackgroundYtranslation.value, 0, 0),
        child: TriangleTopBlueHeader(
          child: Container(
            color: Colors.white,
            height: size.height,
          ),
        ),
      ));

  _getFab(Size size) => Positioned(
        right: size.width * 0.16,
        top: size.height * 0.32,
        child: Transform(
          transform: Matrix4.translationValues(
              onBoardingEnterAnimation.fadeTranslation.value, 0, 0),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.orange,
            ),
            onPressed: () {
              animationController.reverse();
              Scaffold.of(context).showSnackBar(
                  new SnackBar(content: new Text('Button Clicked')));
            },
          ),
        ),
      );

  static _getPagerItem() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Upcoming Dance Programme",
            style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "3 days to go",
            style: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.access_time,
                color: Colors.white,
                size: 12,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "45 min",
                style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.flag,
                color: Colors.white,
                size: 12,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Opera",
                style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ],
          )
        ],
      );

  _getActivityPager(Size size, TextTheme textTheme) => Positioned(
      left: size.width * 0.6,
      right: 0,
      top: size.height * 0.4,
      bottom: size.height * 0.4,
      child: Transform(
        transform: Matrix4.translationValues(
            onBoardingEnterAnimation.pagerXtranslation.value, 0, 0),
        child: PageView.builder(
          physics: new AlwaysScrollableScrollPhysics(),
          controller: _controller,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index % _pages.length];
          },
        ),
      ));

  _getGraphLabel(Size size, TextTheme textTheme) => Positioned(
      left: size.width * 0.1,
      right: 0,
      top: size.height * 0.57,
      child: Transform(
        transform: Matrix4.translationValues(
            -onBoardingEnterAnimation.graphLabelXtranslation.value, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance",
              style: textTheme.headline.copyWith(color: Colors.black87),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Card(
                    shape: CircleBorder(),
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    "Weekly",
                    style: textTheme.subhead.copyWith(color: Colors.blue),
                  ),
                ),
                SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Card(
                    shape: CircleBorder(),
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    "Average",
                    style: textTheme.subhead.copyWith(color: Colors.red),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
              ],
            ),
          ],
        ),
      ));

  _setActivityData(TextTheme textTheme, double width, double height,
          DailyActivityModel dailyActivityModel, double animatedValue) =>
      Positioned(
          left: width,
          top: height,
          child: Transform(
            transform: Matrix4.translationValues(0, -animatedValue, 0),
            child: Opacity(
                opacity: animatedValue,
                child: _textValueUnitContainer(textTheme, dailyActivityModel)),
          ));

  _createLineChart(Size size, TextTheme textTheme) => Stack(
        children: [
          Positioned(
              top: size.height * 0.7,
              left: 0,
              right: 0,
              bottom: 0,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0, onBoardingEnterAnimation.graphYtranslation.value, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProgressChart(entriesList, Colors.blue),
                  ))),
          Positioned(
              top: size.height * 0.7,
              left: 0,
              right: 0,
              bottom: 0,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0, onBoardingEnterAnimation.graphYtranslation.value, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProgressChart(entriesList2, Colors.red),
                  ))),
        ],
      );

  _createPagerIndicator(Size size) => new Positioned(
        left: size.width * 0.45,
        top: size.height * 0.4,
        bottom: size.height * 0.4,
        child: Transform(
          transform: Matrix4.translationValues(
              onBoardingEnterAnimation.pagerXtranslation.value, 0, 0),
          child: new Center(
            child: new DotsIndicator(
              controller: _controller,
              itemCount: _pages.length,
              onPageSelected: (int page) {
                _controller.animateToPage(
                  page,
                  duration: _kDuration,
                  curve: _kCurve,
                );
              },
            ),
          ),
        ),
      );
}

Widget _textValueUnitContainer(
    TextTheme textTheme, DailyActivityModel dailyActivityModel) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      dailyActivityModel.valueUnitList != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: dailyActivityModel.valueUnitList.map((value) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${value.value}",
                      style: textTheme.title
                          .copyWith(color: Colors.black.withOpacity(0.7)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text(
                        "${value.unit}",
                        style:
                            textTheme.caption.copyWith(color: Colors.black54),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    )
                  ],
                );
              }).toList())
          : Offstage(),
      Text(
        dailyActivityModel.label,
        style: textTheme.caption.copyWith(color: Colors.black54),
      )
    ],
  );
}

class UnitValueModel {
  UnitValueModel({
    @required this.value,
    @required this.unit,
  });

  final String value;
  final String unit;
}

class DailyActivityModel {
  DailyActivityModel({
    @required this.label,
    @required this.valueUnitList,
  });

  final String label;
  final List<UnitValueModel> valueUnitList;
}

final List<GraphEntry> entriesList = [
  GraphEntry(DateTime.now(), 23, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 1)), 25, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 2)), 43, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 3)), 12, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 4)), 33, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 5)), 22, ""),
];
final List<GraphEntry> entriesList2 = [
  GraphEntry(DateTime.now(), 10, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 1)), 12, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 2)), 20, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 3)), 25, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 4)), 22, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 5)), 43, ""),
];
