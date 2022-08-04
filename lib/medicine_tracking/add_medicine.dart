import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:home_screen/global/global.dart';
import 'package:home_screen/home/home_screen.dart';

import 'convert_time.dart';
import 'medicine_home.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  final nameController = TextEditingController();
  final dosageController = TextEditingController();

  var _intervals = [
    3,
    6,
    8,
    12,
    24,
  ];
  var _selected = 0;

  Future addToDatabase() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection('medicine_tracking')
        .doc()
        .set({
      "medi_name": nameController.text,
      "dosage": dosageController.text,
      "interval": _selected.toString(),
      "time": _time.toString(),
    }, SetOptions(merge: true));
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        // ignore: unnecessary_statements
        "${convertTime(_time.hour.toString())}" +
            "${convertTime(_time.minute.toString())}";
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF3EB16F),
        ),
        centerTitle: true,
        title: Text(
          "Add New Tracker",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          children: <Widget>[
            PanelTitle(
              title: "Medicine Name",
              isRequired: true,
            ),
            TextFormField(
              maxLength: 12,
              style: TextStyle(
                fontSize: 16,
              ),
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            PanelTitle(
              title: "Dosage in mg",
              isRequired: false,
            ),
            TextFormField(
              controller: dosageController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 16,
              ),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            PanelTitle(
              title: "Interval Selection",
              isRequired: true,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "After every  ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DropdownButton<int>(
                    iconEnabledColor: Color(0xFF3EB16F),
                    hint: _selected == 0
                        ? Text(
                            "Select an Interval",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )
                        : null,
                    elevation: 5,
                    value: _selected == 0 ? null : _selected,
                    items: _intervals.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _selected = newVal!;
                      });
                    },
                  ),
                  Text(
                    _selected == 1 ? " hour" : " hours",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            PanelTitle(
              title: "Starting Time",
              isRequired: true,
            ),
            Container(
              height: 60,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 4),
                child: FlatButton(
                  color: Color(0xFF3EB16F),
                  shape: StadiumBorder(),
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: Center(
                    child: Text(
                      _clicked == false
                          ? "Pick Time"
                          : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.08,
                right: MediaQuery.of(context).size.height * 0.08,
              ),
              child: Container(
                width: 220,
                height: 70,
                child: FlatButton(
                  color: Color(0xFF3EB16F),
                  shape: StadiumBorder(),
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onPressed: () {
                    addToDatabase();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return medicine_home();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  final String type;
  final String name;
  final int iconValue;

  MedicineTypeColumn({
    required this.type,
    required this.name,
    required this.iconValue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //color: isSelected ? Color(0xFF3EB16F) : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.medication_sharp,
                  size: 75,
                  // color: isSelected ? Colors.white : Color(0xFF3EB16F),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                // color: isSelected ? Color(0xFF3EB16F) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
//color: isSelected ? Colors.white : Color(0xFF3EB16F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  PanelTitle({
    required this.title,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: Color(0xFF3EB16F)),
          ),
        ]),
      ),
    );
  }
}
