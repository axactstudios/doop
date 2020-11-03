import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doop/model/volunteer.dart';
import 'package:flutter/material.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<String> locations = ['Delhi', 'Noida'];
  String locationValue = 'Delhi';
  List<Volunteer> volunteers = List<Volunteer>();
  String date =
      '${DateTime.now().year.toString()}${DateTime.now().month.toString()}${DateTime.now().day.toString()}';
  String groupValue = 'none';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFfab300).withOpacity(0.7),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Filter volunteers by location'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: DropdownButtonFormField(
                            value: locationValue,
                            icon: Icon(Icons.arrow_downward),
                            decoration: InputDecoration(
                              labelText: "Select Location",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            items: locations.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                locationValue = newValue;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Available Volunteers',
                    style: TextStyle(
                        color: Color.fromRGBO(196, 141, 0, 1), fontSize: 20),
                  ),
                ),
                StreamBuilder(
                    stream: Firestore.instance.collection('Users').snapshots(),
                    builder: (BuildContext context, snap) {
                      volunteers.clear();
                      if (snap.hasData && !snap.hasError && snap.data != null) {
                        for (int i = 0; i < snap.data.documents.length; i++) {
                          if (snap.data.documents[i]['city'] == locationValue) {
                            Volunteer v = Volunteer(
                                snap.data.documents[i]['name'],
                                snap.data.documents[i]['mCondition'],
                                snap.data.documents[i]['age'],
                                snap.data.documents[i]['pName'],
                                snap.data.documents[i]['address'],
                                snap.data.documents[i]['city'],
                                snap.data.documents[i]['bDate'],
                                snap.data.documents[i]['mail'],
                                snap.data.documents[i]['instruction'],
                                snap.data.documents[i]['pUrl']);
                            volunteers.add(v);
                          }
                        }
                      } else {
                        print('no data');
                      }

                      return Expanded(
                        child: Container(
                          // color: Colors.black,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                itemCount: volunteers.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      volunteers[index].pURL)),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Text(
                                                      volunteers[index].name)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                        value: 'present',
                                                        groupValue: groupValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            groupValue = value;
                                                          });
                                                          Firestore.instance
                                                              .collection(
                                                                  'Users')
                                                              .where('mail',
                                                                  isEqualTo:
                                                                      volunteers[
                                                                              index]
                                                                          .email)
                                                              .getDocuments()
                                                              .then((value) =>
                                                                  value
                                                                      .documents
                                                                      .forEach(
                                                                          (element) {
                                                                    var docId =
                                                                        element
                                                                            .documentID;
                                                                    Firestore
                                                                        .instance
                                                                        .collection(
                                                                            'Users')
                                                                        .document(
                                                                            docId)
                                                                        .updateData({
                                                                      date.toString():
                                                                          'present'
                                                                    });
                                                                  }));
                                                        }),
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                        child: Text('Present')),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                        value: 'absent',
                                                        groupValue: groupValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            groupValue = value;
                                                          });

                                                          Firestore.instance
                                                              .collection(
                                                                  'Users')
                                                              .where('mail',
                                                                  isEqualTo:
                                                                      volunteers[
                                                                              index]
                                                                          .email)
                                                              .getDocuments()
                                                              .then((value) =>
                                                                  value
                                                                      .documents
                                                                      .forEach(
                                                                          (element) {
                                                                    var docId =
                                                                        element
                                                                            .documentID;
                                                                    Firestore
                                                                        .instance
                                                                        .collection(
                                                                            'Users')
                                                                        .document(
                                                                            docId)
                                                                        .updateData({
                                                                      date.toString():
                                                                          'absent'
                                                                    });
                                                                  }));
                                                        }),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      child: Text(
                                                        'Absent',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
