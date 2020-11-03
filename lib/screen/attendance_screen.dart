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
  DateTime date = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String groupValue = 'present';
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
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Row(
                    children: [
                      Text('Select Location'),
                      Container(
                        height: 100,
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
                SizedBox(
                  height: 20,
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
                          child: ListView.builder(
                              itemCount: volunteers.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Text(volunteers[index].name),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Radio(
                                        value: 'present',
                                        groupValue: groupValue,
                                        onChanged: (value) {
                                          setState(() {
                                            groupValue = value;
                                          });
                                          Firestore.instance
                                              .collection('Users')
                                              .where('mail',
                                                  isEqualTo:
                                                      volunteers[index].email)
                                              .getDocuments()
                                              .then((value) => value.documents
                                                      .forEach((element) {
                                                    element.data.update(
                                                        date.toString(),
                                                        (value) => 'Present');
                                                  }));
                                        }),
                                    Radio(
                                        value: 'absent',
                                        onChanged: (value) {
                                          setState(() {
                                            groupValue = value;
                                          });
                                          Future<Map<String, dynamic>>
                                              votedown() async {
                                            Map<String, dynamic> comdata =
                                                <String, dynamic>{
                                              date.toString(): 'Absent'
                                            };
                                            return comdata;
                                          }

                                          Firestore.instance
                                              .collection('Users')
                                              .where('mail',
                                                  isEqualTo:
                                                      volunteers[index].email)
                                              .getDocuments()
                                              .then((value) => value.documents
                                                      .forEach((element) {
                                                    // element.
                                                    // print(element.data);

                                                    element.data.addEntries([
                                                      MapEntry('key', 'value')
                                                    ]);
                                                    // element.data.addAll(
                                                    //     {'other': 'dfsf'});
                                                    print('updated');
                                                    // element.data.update(
                                                    //     date.toString(),
                                                    //     (value) => 'Absent');
                                                  }));
                                        }),
                                  ],
                                );
                              }),
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
