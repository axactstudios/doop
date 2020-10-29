import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doop/model/volunteer.dart';
import 'package:flutter/material.dart';

class ViewAll extends StatefulWidget {
  @override
  _ViewAllState createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Volunteer> volunteers = new List<Volunteer>();

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffFFFFFF),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        backgroundColor: Color(0xFFfab300),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Container(
            child: StreamBuilder(
                stream: Firestore.instance.collection('Users').snapshots(),
                builder: (BuildContext context, snap) {
                  volunteers.clear();
                  var orderID, status;
                  if (snap.hasData && !snap.hasError && snap.data != null) {
                    for (int i = 0; i < snap.data.documents.length; i++) {
                      Volunteer v = Volunteer(
                          snap.data.documents[i]['name'],
                          snap.data.documents[i]['mCondition'],
                          snap.data.documents[i]['age'],
                          snap.data.documents[i]['pName'],
                          snap.data.documents[i]['address'],
                          snap.data.documents[i]['bDate'],
                          snap.data.documents[i]['mail'],
                          snap.data.documents[i]['instructions']);
                      volunteers.add(v);
                    }
                  }
                  return volunteers.length == 0
                      ? Container()
                      : Container(
                          child: ListView.builder(
                              itemCount: volunteers.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Image.network(
                                            'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png',
                                            height: pHeight * 0.16,
                                            width: pHeight * 0.1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${volunteers[i].name}',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: pHeight * 0.03),
                                                ),
                                                Text(
                                                  volunteers[i].address,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: pHeight * 0.025,
                                                    color: Colors.black
                                                        .withOpacity(0.75),
                                                  ),
                                                ),
                                                Text(
                                                  volunteers[i].email,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: pHeight * 0.02,
                                                    color: Colors.black
                                                        .withOpacity(0.55),
                                                  ),
                                                ),
                                                Text(
                                                  'Age: ${volunteers[i].age}',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: pHeight * 0.02,
                                                    color: Colors.black
                                                        .withOpacity(0.55),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                }),
          ),
        ),
      ),
    );
  }
}
