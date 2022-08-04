import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_screen/global/global.dart';
import 'package:home_screen/home/home_screen.dart';
import 'package:home_screen/medicine_tracking/add_medicine.dart';

class medicine_home extends StatefulWidget {
  const medicine_home({Key? key}) : super(key: key);

  @override
  State<medicine_home> createState() => _medicine_homeState();
}

class _medicine_homeState extends State<medicine_home> {
  var id = "";
  final Stream<QuerySnapshot> doctorStream = FirebaseFirestore.instance
      .collection('users')
      .doc(sharedPreferences!.getString("uid"))
      .collection('medicine_tracking')
      .snapshots();
  var delete = "";

  Future deleteFromDatabase(id) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection('medicine_tracking')
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medicine Tracking",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, right: 16, left: 16, bottom: 4),
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[],
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: doctorStream,
                    builder: (context, snapshot) {
                      final List storeMedicines = [];
                      snapshot.data?.docs.map((DocumentSnapshot document) {
                        Map a = document.data() as Map<String, dynamic>;
                        storeMedicines.add(a);
                      }).toList();

                      return Container(
                        height: 1000,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: storeMedicines.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  // deleteFromDatabase(
                                  //     storeMedicines[index]["id"]);
                                },
                                onLongPress: () {
                                  // deleteFromDatabase(storeMedicines[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                          offset: Offset(0, 1),
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        ("Medicine:  ") +
                                                            storeMedicines[
                                                                    index]
                                                                ['medi_name'],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        storeMedicines[index]
                                                                ['dosage'] +
                                                            ("  MG"),
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[500],
                                                            //fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: AnimatedContainer(
                                              height: 35,
                                              padding: EdgeInsets.all(5),
                                              duration:
                                                  Duration(milliseconds: 300),
                                              child: Center(
                                                child: Icon(
                                                  Icons.medication_outlined,
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color:
                                                          Colors.grey.shade200),
                                                  child: Text(
                                                    ("Intervals:  ") +
                                                        storeMedicines[index]
                                                            ['interval'],
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: Colors.amber),
                                                  child: Text(
                                                    storeMedicines[index]
                                                        ['time'],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    })
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NewEntry()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(50, 27),
          bottomRight: Radius.elliptical(50, 27),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 0.2,
            color: Theme.of(context).accentColor,
            offset: Offset(0, 3.5),
          )
        ],
        color: Theme.of(context).accentColor,
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Reminders",
                style: TextStyle(
                  fontFamily: "Angel",
                  fontSize: 64,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Divider(
            color: Color(0xFFB0F3CB),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
              child: Text(
                "Total number of Reminders",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 5),
            child: Center(
              child: Text(
                "0",
                style: TextStyle(
                  fontFamily: "Neu",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
