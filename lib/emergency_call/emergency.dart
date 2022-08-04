// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:home_screen/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Call extends StatefulWidget {
  const Call({Key? key}) : super(key: key);

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Make Call",
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
          )),
      body: Padding(
        padding: const EdgeInsets.all(90),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  launch("tel://+923110648630");
                },
                backgroundColor: Theme.of(context).accentColor,
                icon: Icon(Icons.health_and_safety_rounded),
                label: Text('General Emergency'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                onPressed: () {},
                backgroundColor: Theme.of(context).accentColor,
                icon: Icon(Icons.dashboard_customize_sharp),
                label: Text('Doctor On Panel'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  launch("tel://021111111823");
                },
                backgroundColor: Theme.of(context).accentColor,
                icon: Icon(Icons.car_repair),
                label: Text('Aman Ambulance'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  launch("tel://115");
                },
                backgroundColor: Theme.of(context).accentColor,
                icon: Icon(Icons.car_repair),
                label: Text('Edhi Ambulance'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  launch("tel://021111111134");
                },
                backgroundColor: Theme.of(context).accentColor,
                icon: Icon(Icons.car_repair),
                label: Text('Chipa Ambulance'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  launch("tel://03110648630");
                },
                backgroundColor: Theme.of(context).accentColor,
                icon: Icon(Icons.child_care),
                label: Text('Child Specialist'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
