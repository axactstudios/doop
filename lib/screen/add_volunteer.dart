import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:path/path.dart' as p;

class AddVoulnteer extends StatefulWidget {
  @override
  _AddVoulnteerState createState() => _AddVoulnteerState();
}

class _AddVoulnteerState extends State<AddVoulnteer> {
  TextEditingController nameC = new TextEditingController(text: '');

  TextEditingController emailC = new TextEditingController(text: '');
  TextEditingController pwC = new TextEditingController(text: '');
  TextEditingController age = new TextEditingController(text: '');
  TextEditingController bDate = new TextEditingController(text: '');
  TextEditingController pName = new TextEditingController(text: '');
  TextEditingController address = new TextEditingController(text: '');
  TextEditingController city = new TextEditingController(text: '');

  TextEditingController mCondition = new TextEditingController(text: '');
  TextEditingController instruction = new TextEditingController(text: '');
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String url;

  @override
  void initState() {
    // TODO: implement initState
    nameC.clear();
    emailC.clear();
    pwC.clear();
    age.clear();
    bDate.clear();
    pName.clear();
    address.clear();
    city.clear();
    mCondition.clear();
    instruction.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffFFFFFF),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        backgroundColor: Color(0xFFfab300),
        onPressed: () {
          if (selectedIndex == 0)
            Navigator.pop(context);
          else if (selectedIndex == 1)
            setState(() {
              selectedIndex = 0;
            });
          else if (selectedIndex == 2)
            setState(() {
              selectedIndex = 1;
            });
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: selectedIndex == 0
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add A Volunteer',
                        style:
                            TextStyle(color: Color(0xFFfab300), fontSize: 24),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Stack(children: [
                            Center(
                                child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              height: 100,
                              width: 100,
                              child: CircleAvatar(
                                backgroundColor:
                                    Color(0xfffab300).withOpacity(0.8),
                                backgroundImage: NetworkImage(
                                  url == null
                                      ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRMBQ6VlVnAxYVtNDOiH2OYKaqmD75HZP47lw&usqp=CAU'
                                      : url,
                                ),
                              ),
                            )),
                            InkWell(
                              onTap: () async {
                                filePicker(context, this, _scaffoldKey);
                              },
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Colors.black),
                                    child: Icon(
                                      Icons.upload_sharp,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xfffab300).withOpacity(0.7),
                            border: Border.all(color: Color(0xFFfab300)),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: emailC,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 10, top: 0, right: 15),
                                hintText: 'Email'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xfffab300).withOpacity(0.7),
                            border: Border.all(color: Color(0xFFfab300)),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            obscureText: true,
                            controller: pwC,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 10, top: 0, right: 15),
                                hintText: 'Password'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xfffab300).withOpacity(0.7),
                            border: Border.all(color: Color(0xFFfab300)),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: nameC,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 10, top: 0, right: 15),
                                hintText: 'Name'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xfffab300).withOpacity(0.7),
                            border: Border.all(color: Color(0xFFfab300)),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: age,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 10, top: 0, right: 15),
                                hintText: 'Age'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xfffab300).withOpacity(0.7),
                            border: Border.all(color: Color(0xFFfab300)),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: bDate,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 10, top: 0, right: 15),
                                hintText: 'Birth Date'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xfffab300).withOpacity(0.7),
                            border: Border.all(color: Color(0xFFfab300)),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: pName,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 10, top: 0, right: 15),
                                hintText: 'Parent\'s Name'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            color: Color(0xfffab300).withOpacity(0.7),
                            border: Border.all(color: Color(0xFFfab300)),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: address,
                            minLines: 5,
                            maxLines: 10,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 10, top: 10, right: 15),
                                hintText: 'Address'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            color: Color(0xfffab300).withOpacity(0.7),
                            border: Border.all(color: Color(0xFFfab300)),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: city,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 10, top: 10, right: 15),
                                hintText: 'City'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              color: Color(0xfffab300),
                              border: Border.all(color: Color(0xFFfab300)),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Move To \nQuestionnaire',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                )
              : selectedIndex == 1
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.2),
                            child: Text(
                              'Any medical conditions? List any allergies or illness candidate may have',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                color: Color(0xfffab300).withOpacity(0.7),
                                border: Border.all(color: Color(0xFFfab300)),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: mCondition,
                                minLines: 5,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 10,
                                        top: 10,
                                        right: 15),
                                    hintText: 'Your Answer'),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = 2;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                  color: Color(0xfffab300),
                                  border: Border.all(color: Color(0xFFfab300)),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Next',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.2),
                            child: Text(
                              'Anything you want instructor to be extra careful about?',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                color: Color(0xfffab300).withOpacity(0.7),
                                border: Border.all(color: Color(0xFFfab300)),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: instruction,
                                minLines: 5,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 10,
                                        top: 10,
                                        right: 15),
                                    hintText: 'Your Answer'),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          InkWell(
                            onTap: () async {
                              await _createUser(emailC.text, pwC.text, context);
                              Fluttertoast.showToast(
                                  msg: 'Volunteer has been registered',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER);
                              Navigator.pop(context);
                              // Navigator
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                  color: Color(0xfffab300),
                                  border: Border.all(color: Color(0xFFfab300)),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Register',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  _createUser(String email, String pw, context) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: pw)
        .then((authResult) async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.sendEmailVerification();
      Fluttertoast.showToast(
          msg: 'Verification link has been sent to your email address!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);

      final databaseReference = Firestore.instance;
      await databaseReference.collection('Users').add({
        'name': nameC.text,
        'id': user.uid,
        'mail': emailC.text,
        'pUrl': url,
        // 'lname': lName.text,
        'age': age.text,
        'bDate': bDate.text,
        'pName': pName.text,
        'address': address.text,
        'city': city.text,
        'mCondition': mCondition.text,
        'instruction': instruction.text
      });
      setState(() {
        // n = name.text;
      });
      nameC.clear();
      // lName.clear();
      emailC.clear();
      pwC.clear();
      // R.Router.navigator.pushNamed(R.Router.setLocationScreen);
//      FirebaseAuth.instance.signOut();
    }).catchError((err) {
      print(err);
      if (err == 'ERROR_EMAIL_ALREADY_IN_USE') {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('This email is already in use'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
      if (err == 'ERROR_MISSING_EMAIL') {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Please Enter Email'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
      if (err == 'ERROR_WEAK_PASSWORD') {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Password should be of 6 or more characters'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
      if (err == 'ERROR_INVALID_EMAIL') {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Enter a valid email.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
    });
    //     : showCupertinoDialog(
    //   context: context,
    //   builder: (context) {
    //     return CupertinoAlertDialog(
    //       title: Text('Passwords don\'t match!'),
    //       actions: <Widget>[
    //         CupertinoDialogAction(
    //           child: Text('OK'),
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //         )
    //       ],
    //     );
    //   },
    // );
  }

  ProgressDialog pr;

  bool _isLoading = false;

  double _progress = 0;

  void _uploadFile(File file, String filename, context, state, key) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://doopdashboard.appspot.com/');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    StorageReference storageReference;
    storageReference = _storage
        .ref()
        .child("Users/${DateTime.now().millisecondsSinceEpoch}/profileImage");

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      textDirection: TextDirection.ltr,
      isDismissible: false,
    );
    pr.style(
      progressWidget: CircularProgressIndicator(),
      message: 'Uploading photo...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    await pr.show();
    uploadTask.events.listen((event) {
      state.setState(() {
        _isLoading = true;
        _progress = (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble()) *
            100;
        print('${_progress.toStringAsFixed(2)}%');
        pr.update(
          progress: double.parse(_progress.toStringAsFixed(2)),
          maxProgress: 100.0,
        );
      });
    }).onError((error) {
      key.currentState.showSnackBar(new SnackBar(
        content: new Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    });

    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    url = (await downloadUrl.ref.getDownloadURL());

    Fluttertoast.showToast(
        msg: 'Upload Complete', gravity: ToastGravity.BOTTOM);
    state.setState(() async {
      print("URL is $url");
      await pr.hide();
    });
  }

  File file;

  String fileName = '';

  Future filePicker(BuildContext context, state, key) async {
    try {
      print(1);
      file = await ImagePicker.pickImage(source: ImageSource.gallery);
      print(1);
      state.setState(() {
        fileName = p.basename(file.path);
      });
      print(fileName);
      Fluttertoast.showToast(msg: 'Uploading...', gravity: ToastGravity.BOTTOM);
      state.setState(() {});
      _uploadFile(file, fileName, context, state, key);
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
