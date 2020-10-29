import 'package:doop/screen/add_volunteer.dart';
import 'package:doop/screen/view_all.dart';
import 'package:flutter/material.dart';

import 'activity_page_animation.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with TickerProviderStateMixin {
  AnimationController animationController;
  ActivityEnterAnimation activityEnterAnimation;

  @override
  void initState() {
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
            Navigator.pushNamed(context, "/onboarding");
            break;
        }
      });

    activityEnterAnimation = ActivityEnterAnimation(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Color(0xFF2e2d2d),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getLabelText(textTheme),
            Expanded(
              child: _getActivityList(size, textTheme),
            )
          ],
        ),
      ),
      floatingActionButton: _getFab(),
    );
  }

  _getActivityList(Size size, TextTheme textTheme) => Transform(
      transform: Matrix4.translationValues(
          -activityEnterAnimation.listXtranslation.value, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddVoulnteer()));
              },
              child: _getListItem(textTheme, 'Add Volunteer', Icons.add),
            ),
            InkWell(
              child:
                  _getListItem(textTheme, 'View All', Icons.supervisor_account),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewAll()));
              },
            ),
            _getListItem(textTheme, 'Bicycle', Icons.motorcycle),
          ],
        ),
      ));

  _getListItem(TextTheme textTheme, String label, IconData iconData) => Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Icon(
              iconData,
              color: Color(0xFFfab300),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              label,
              style: textTheme.subhead.copyWith(color: Color(0xFFfab300)),
            )
          ],
        ),
      );

  _getFab() => Transform(
        transform: Matrix4.translationValues(
            activityEnterAnimation.listXtranslation.value, 0, 0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
          onPressed: () {
            animationController.reverse();
            Scaffold.of(context).showSnackBar(
                new SnackBar(content: new Text('Button Clicked')));
          },
        ),
      );

  _getLabelText(TextTheme textTheme) => Padding(
        padding: EdgeInsets.only(top: 24, left: 24),
        child: Transform(
          transform: Matrix4.translationValues(
              -activityEnterAnimation.labelXtranslation.value, 0, 0),
          child: Text(
            "Select your activity",
            style: textTheme.caption.copyWith(color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
      );
}
