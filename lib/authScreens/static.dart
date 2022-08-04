import 'package:flutter/material.dart';

List<Map<String, Object>> WALKTHROUGH_ITEMS = [
  {
    'image': 'assets/images/wt1.png',
    'button_text': 'Next',
    'description_rich': RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Get list of best doctor nearby you',
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black))
    ])),
    'title': RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Search Doctors',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Gothic',
              color: Color.fromRGBO(235, 87, 87, 1))),
    ])),
  },
  {
    'image': 'assets/images/wt2.png',
    'button_text': 'Next',
    'description_rich': RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Book an appointment with a right doctor',
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black)),
    ])),
    'title': RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Book Appointment',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Gothic',
              color: Color.fromRGBO(235, 87, 87, 1))),
    ]))
  },
  {
    'image': 'assets/images/wt3.png',
    'button_text': 'Next',
    'description_rich': RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Search and book diagnostic test',
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black))
    ])),
    'title': RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Book Diagonostic',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Gothic',
              color: Color.fromRGBO(235, 87, 87, 1))),
    ])),
  },
];
