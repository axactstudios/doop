import 'dart:async';
import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doop/screen/activity_page/activity_page.dart';
import 'package:doop/screen/onboarding/onboarding_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

int len = 0;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dance Out of Poverty',
      theme: ThemeData(
        textTheme: _buildTextTheme(context),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/onboarding': (BuildContext context) => OnBoardingPage(),
        '/activity': (BuildContext context) => ActivityPage(),
      },
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/onboarding': (BuildContext context) => OnBoardingPage(),
        '/activity': (BuildContext context) => ActivityPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Dance Out Of Poverty',
      theme: ThemeData(
        fontFamily: 'Cabin',
        scaffoldBackgroundColor: kWhiteColor,
        primaryColor: kPrimaryColor,
        // ignore: deprecated_member_use
        textTheme: TextTheme(
          // ignore: deprecated_member_use
          headline: TextStyle(fontWeight: FontWeight.bold),
          button: TextStyle(fontWeight: FontWeight.bold),
          // ignore: deprecated_member_use
          title: TextStyle(fontWeight: FontWeight.bold),
          // ignore: deprecated_member_use
          body1: TextStyle(color: kTextColor),
        ),
      ),
      home: MyApp1(),
    );
  }
}

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> with SingleTickerProviderStateMixin {
  FirebaseAuth mAuth = FirebaseAuth.instance;

  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height >= 775.0
            ? MediaQuery.of(context).size.height
            : 775.0,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [MyColors.loginGradientStart, MyColors.loginGradientEnd],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              AvatarGlow(
                endRadius: 90,
                duration: Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 2),
                startDelay: Duration(seconds: 1),
                child: Material(
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: kTextColor,
                      child: Image.asset('assets/cropped-logo.png'),
                      radius: 50.0,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              DelayedAnimation(
                child: Text(
                  "Welcome",
                  style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 35,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
                delay: delayedAmount + 1000,
              ),
              DelayedAnimation(
                child: Text(
                  "Dance Out Of Poverty",
                  style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 29,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
                delay: delayedAmount + 2000,
              ),
              SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/sinhayana_logo.png',
                        height: 100,
                      ),
                    )),
                delay: delayedAmount + 3000,
              ),
              SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
              SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                child: Text(
                  "Made with love<3".toUpperCase(),
                  style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
                delay: delayedAmount + 5000,
              ),
            ],
          ),
        ),
      )
          //  Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
          //     SizedBox(
          //       height: 20.0,
          //     ),
          //      Center(

          //   ),
          //   ],

          // ),
          ),
    );
  }

  Widget get _animatedButtonUI => InkWell(
        onTap: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Container(
          height: 60,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              'Proceed',
              style: GoogleFonts.josefinSans(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  DelayedAnimation({@required this.child, this.delay});

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _controller,
    );
  }
}

class TabIndicationPainter extends CustomPainter {
  Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  final PageController pageController;

  TabIndicationPainter(
      {this.dxTarget = 125.0,
      this.dxEntry = 25.0,
      this.radius = 21.0,
      this.dy = 25.0,
      this.pageController})
      : super(repaint: pageController) {
    painter = new Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController.position;
    double fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);

    double pageOffset = pos.extentBefore / fullExtent;

    bool left2right = dxEntry < dxTarget;
    Offset entry = new Offset(left2right ? dxEntry : dxTarget, dy);
    Offset target = new Offset(left2right ? dxTarget : dxEntry, dy);

    Path path = new Path();
    path.addArc(
        new Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(
        new Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(
        new Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);
    canvas.drawShadow(path, Color(0xFFfbab66), 3.0, true);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}

class MyColors {
  const MyColors();

  static const Color loginGradientEnd = const Color(0xFFfab300);
  static const Color loginGradientStart = const Color(0xFFfab300);
  static const Color cardBackground = const Color(0xFFfab300);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

const kPrimaryColor = Color(0xFFfab300);
const kSecondaryColor = Color(0xFFfab300);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF000000);
const kTextColor = Color(0xFF1D150B);
const kBorderColor = Color(0xFFDDDDDD);

ThemeData buildLightTheme(BuildContext context) {
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
//    primarySwatch: white,
    primaryColorBrightness: Brightness.light,
    accentColorBrightness: Brightness.light,

    indicatorColor: Colors.white,

    canvasColor: Colors.white,
    bottomAppBarColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
  );
  return base.copyWith(
    textTheme: _buildTextTheme(context),
    primaryTextTheme: _buildTextTheme(context),
    accentTextTheme: _buildTextTheme(context),
  );
}

TextTheme _buildTextTheme(BuildContext context) {
  var textTheme = Theme.of(context).textTheme;

  return GoogleFonts.josefinSansTextTheme(textTheme).copyWith(
    display1: GoogleFonts.josefinSans(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
    headline: GoogleFonts.josefinSans(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
    subhead: GoogleFonts.josefinSans(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    title: GoogleFonts.josefinSans(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    body1: GoogleFonts.josefinSans(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
    ),
    button: GoogleFonts.josefinSans(
        fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
    subtitle: GoogleFonts.josefinSans(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
  );
}
