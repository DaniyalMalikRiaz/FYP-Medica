import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:home_screen/global/global.dart';
import 'package:home_screen/medical_card/medical_card.dart';
import 'package:home_screen/userAccount/settings.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();

  var userName = "";
  var userPhone = "";
  var userLocation = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final userNameController = TextEditingController();
  final userPhoneController = TextEditingController();
  final userLocationController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    userPhoneController.dispose();
    userLocationController.dispose();

    super.dispose();
  }

  clearText() {
    userNameController.clear();
    userPhoneController.clear();
    userLocationController.clear();
  }

  Future addToDatabase() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .set({
      // "userName": userNameController.text,
      // "userPhone": userPhoneController.text,
      "userLocation": userLocationController.text,
    }, SetOptions(merge: true));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Update User Profile"),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Color(0xFF264CD2),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => settingsPage()));
            },
          )),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(sharedPreferences!.getString("uid"))
              .snapshots(),
          builder: (context, snapshot) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autofocus: false,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: '${data['userName']}',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userNameController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autofocus: false,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: '${data['userPhone']}',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userPhoneController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userLocationController,
                      ),
                    ),
                    Gap(50),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  userName = userNameController.text;
                                  userPhone = userPhoneController.text;
                                  userLocation = userLocationController.text;
                                  addToDatabase();
                                  clearText();
                                });
                              }
                            },
                            child: Text(
                              'Change Details',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
