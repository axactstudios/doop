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
                          snap.data.documents[i]['city'],
                          snap.data.documents[i]['bDate'],
                          snap.data.documents[i]['mail'],
                          snap.data.documents[i]['instruction'],
                          snap.data.documents[i]['pUrl']);
                      volunteers.add(v);
                    }
                  }
                  return volunteers.length == 0
                      ? Container()
                      : Container(
                          child: Column(
                            children: [
                              Text(
                                'Volunteers',
                                style: TextStyle(
                                    color: Color.fromRGBO(196, 141, 0, 1),
                                    fontSize: 24),
                              ),
                              Expanded(
                                child: Container(
                                  // height: pHeight * 0.8,
                                  child: ListView.builder(
                                      itemCount: volunteers.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: InkWell(
                                            onTap: () {
                                              _scaffoldKey.currentState
                                                  .showBottomSheet((context) {
                                                return StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        StateSetter state) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black26,
                                                            blurRadius:
                                                                30.0, // soften the shadow
                                                            spreadRadius:
                                                                3.0, //extend the shadow
                                                            offset: Offset(
                                                              0.0, // Move to right 10  horizontally
                                                              0.0, // Move to bottom 10 Vertically
                                                            ),
                                                          )
                                                        ],
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    margin: EdgeInsets.fromLTRB(
                                                        20, 20, 20, 40),
                                                    padding: EdgeInsets.all(15),
                                                    height: pHeight,
                                                    width: pWidth,
                                                    child: Column(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Volunteer Details',
                                                                style: TextStyle(
                                                                    color: Color(0xFFfab300),
                                                                    // color: Theme
                                                                    //     .MyColors
                                                                    //     .themeColor,

                                                                    fontSize: 24,
                                                                    fontWeight: FontWeight.bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  size: 40,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      true);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        5),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          300,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(5)),
                                                                        child: Image
                                                                            .network(
                                                                          volunteers[i]
                                                                              .pURL,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Text(
                                                                      'Name: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          pWidth *
                                                                              0.6,
                                                                      child:
                                                                          Text(
                                                                        volunteers[i]
                                                                            .name,
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFF808080),
                                                                            fontFamily:
                                                                                'nunito',
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Age: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          pWidth *
                                                                              0.6,
                                                                      child:
                                                                          Text(
                                                                        volunteers[i]
                                                                            .age,
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFF808080),
                                                                            fontFamily:
                                                                                'nunito',
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Address: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          pWidth *
                                                                              0.6,
                                                                      child:
                                                                          Text(
                                                                        volunteers[i]
                                                                            .address,
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFF808080),
                                                                            fontFamily:
                                                                                'nunito',
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Email: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          pWidth *
                                                                              0.6,
                                                                      child:
                                                                          Text(
                                                                        volunteers[i]
                                                                            .email,
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFF808080),
                                                                            fontFamily:
                                                                                'nunito',
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Birth date: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          pWidth *
                                                                              0.6,
                                                                      child:
                                                                          Text(
                                                                        volunteers[i]
                                                                            .bdate,
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFF808080),
                                                                            fontFamily:
                                                                                'nunito',
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Parent\'s Name: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          pWidth *
                                                                              0.6,
                                                                      child:
                                                                          Text(
                                                                        volunteers[i]
                                                                            .pName,
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFF808080),
                                                                            fontFamily:
                                                                                'nunito',
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Medical Conditions-',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontFamily:
                                                                              'nunito',
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      volunteers[
                                                                              i]
                                                                          .mCondition,
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFF808080),
                                                                          fontFamily:
                                                                              'nunito',
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Specific Instructions-',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontFamily:
                                                                              'nunito',
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      volunteers[
                                                                              i]
                                                                          .instructions,
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFF808080),
                                                                          fontFamily:
                                                                              'nunito',
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                              });
                                            },
                                            child: Card(
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15)),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Container(
                                                          height:
                                                              pHeight * 0.16,
                                                          width: pHeight * 0.08,
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                              volunteers[i]
                                                                  .pURL,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                '${volunteers[i].name}',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        pHeight *
                                                                            0.03),
                                                              ),
                                                              Text(
                                                                volunteers[i]
                                                                    .address,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      pHeight *
                                                                          0.02,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.75),
                                                                ),
                                                              ),
                                                              Text(
                                                                volunteers[i]
                                                                    .email,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      pHeight *
                                                                          0.02,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.55),
                                                                ),
                                                              ),
                                                              Text(
                                                                'Age: ${volunteers[i].age}',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      pHeight *
                                                                          0.02,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.55),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Positioned(
                                                  //     right: 0,
                                                  //     top: 0,
                                                  //     child: Container(
                                                  //       child: Padding(
                                                  //         padding:
                                                  //             const EdgeInsets
                                                  //                 .all(8.0),
                                                  //         child: Text(
                                                  //           volunteers[i]
                                                  //               .address,
                                                  //           style: TextStyle(
                                                  //               color: Colors
                                                  //                   .white),
                                                  //         ),
                                                  //       ),
                                                  //       decoration:
                                                  //           BoxDecoration(
                                                  //         color:
                                                  //             Color(0xFFfab300),
                                                  //         borderRadius:
                                                  //             BorderRadius.only(
                                                  //                 topLeft: Radius
                                                  //                     .circular(
                                                  //                         5),
                                                  //                 bottomRight: Radius
                                                  //                     .circular(
                                                  //                         5)),
                                                  //       ),
                                                  //     )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        );
                }),
          ),
        ),
      ),
    );
  }
}
