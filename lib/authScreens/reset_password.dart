import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:home_screen/authScreens/signin.dart';
import 'package:home_screen/global/global.dart';
import 'package:home_screen/medical_card/medical_card.dart';
import 'package:home_screen/userAccount/settings.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final _formKey = GlobalKey<FormState>();
  final userEmailController = TextEditingController();

  Future resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: userEmailController.text);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Reset Password"),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Color(0xFF264CD2),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Signin()));
            },
          )),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 150, horizontal: 15),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 50),
                child: TextFormField(
                  autofocus: true,
                  enabled: true,
                  decoration: InputDecoration(
                    labelText: "Enter Email",
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: userEmailController,
                ),
              ),
              Gap(25),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        resetPassword();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Reset Link Sent')));
                      },
                      child: Text(
                        'Send Reset Link',
                        style: TextStyle(fontSize: 18.0),
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
  }
}
