import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:home_screen/global/global.dart';
import 'package:home_screen/medical_card/medical_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({Key? key}) : super(key: key);

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  Future setData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snapshot) async {
      await sharedPreferences!
          .setString("userAge", snapshot.data()!["userAge"]);
      await sharedPreferences!
          .setString("userGender", snapshot.data()!["userGender"]);
    });
  }

  final _formKey = GlobalKey<FormState>();

  var userAge = "";
  var userGender = "";
  var userBloodGroup = "";
  var userAllergies = "";
  var userDisease = "";
  var userWeight = "";
  var userHeight = "";
  var userAvgBP = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final userAgeController = TextEditingController();
  final userGenderController = TextEditingController();
  final userBloodGroupController = TextEditingController();
  final userAllergiesController = TextEditingController();
  final userDiseaseController = TextEditingController();
  final userWeightController = TextEditingController();
  final userHeightController = TextEditingController();
  final userAvgBPController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userAgeController.dispose();
    userGenderController.dispose();
    userBloodGroupController.dispose();
    userAllergiesController.dispose();
    userDiseaseController.dispose();
    userWeightController.dispose();
    userHeightController.dispose();
    userAvgBPController.dispose();

    super.dispose();
  }

  clearText() {
    userAgeController.clear();
    userGenderController.clear();
    userBloodGroupController.clear();
    userAllergiesController.clear();
    userDiseaseController.clear();
    userWeightController.clear();
    userHeightController.clear();
    userAvgBPController.clear();
  }

  Future addToDatabase() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection('records')
        .doc('medicalCard')
        .set({
      "userAge": userAgeController.text,
      "userGender": userGenderController.text,
      "userBloodGroup": userBloodGroupController.text,
      "userAllergies": userAllergiesController.text,
      "userDisease": userDiseaseController.text,
      "userWeight": userWeightController.text,
      "userHeight": userHeightController.text,
      "userAvgBP": userAvgBPController.text,
    }, SetOptions(merge: true));
  }

  Future readDataAndSetDataLocally() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection('records')
        .doc('medicalCard')
        .get()
        .then((snapshot) async {
      await sharedPreferences!
          .setString("userAge", snapshot.data()!["userAge"]);
      await sharedPreferences!
          .setString("userGender", snapshot.data()!["userGender"]);
      await sharedPreferences!
          .setString("userBloodGroup", snapshot.data()!["userBloodGroup"]);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add to Medical Card"),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Color(0xFF264CD2),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MedicalCard()));
            },
          )),
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
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
                        decoration: InputDecoration(
                          labelText: 'Age',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userAgeController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userGenderController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Blood Group',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userBloodGroupController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Allergies',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userAllergiesController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Diseases',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userDiseaseController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Weight',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userWeightController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Height',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userHeightController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Average Blood Pressure',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: userAvgBPController,
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
                                  userAge = userAgeController.text;
                                  userGender = userGenderController.text;
                                  userBloodGroup =
                                      userBloodGroupController.text;
                                  userAllergies = userAllergiesController.text;
                                  userDisease = userDiseaseController.text;
                                  userWeight = userWeightController.text;
                                  userHeight = userHeightController.text;
                                  userAvgBP = userAvgBPController.text;
                                  addToDatabase();
                                  readDataAndSetDataLocally();
                                  //setData();
                                  clearText();
                                });
                              }
                            },
                            child: Text(
                              'Add Details',
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
