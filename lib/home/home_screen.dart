import 'package:flutter/material.dart';
import 'package:home_screen/blogs/blog_main.dart';
import 'package:home_screen/emergency_call/emergency.dart';
import 'package:home_screen/findPage/chest_doctor.dart';
import 'package:home_screen/findPage/child_doctor.dart';
import 'package:home_screen/findPage/dentist_doctor.dart';
import 'package:home_screen/findPage/find_doctors.dart';
import 'package:home_screen/findPage/general_doctor.dart';
import 'package:home_screen/findPage/nearMe_doctor.dart';
import 'package:home_screen/findPage/skin_doctor.dart';
import 'package:home_screen/global/global.dart';
import 'package:home_screen/history/history_taking.dart';
import 'dart:math';
import 'package:home_screen/home/theme.dart';
import 'package:home_screen/home/light_color.dart';
import 'package:home_screen/home/extention.dart';
import 'package:home_screen/home/text_styles.dart';
import 'package:home_screen/home/menu_selection.dart';
import 'package:home_screen/medical_card/medical_card.dart';
import 'package:home_screen/medicine_tracking/medicine_home.dart';
//import 'package:home_screen/medical_card/medical_card2.dart';
import 'package:home_screen/userAccount/settings.dart';
//import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static double headerHeight = 228.5;
  var _currentIndex = 0;
  bool check = false;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Theme.of(context).accentColor,
              height: headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      sharedPreferences!.getString("name")!,
                      // sharedPreferences!.getString("email")!,
                      // 'Daniyal Malik',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    )),
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 30.0,
                        // backgroundImage: NetworkImage(
                        //     'https://randomuser.me/api/portraits/men/81.jpg'),
                        child: Icon(
                          Icons.person,
                          color: Colors.amber,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => settingsPage()));
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.coronavirus_rounded,
                      color: Colors.green,
                    ),
                    Text(
                      'Welcome to your Health App',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        menu_selection(
                            image: 'assets/images/doctor.png',
                            title: 'Find Doctors',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FindPage()));
                            }),
                        SizedBox(
                          width: 40,
                        ),
                        menu_selection(
                            image: 'assets/images/pill.png',
                            title: 'Medicine Tracking',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => medicine_home()));
                            }),
                        SizedBox(
                          height: 2,
                        ),
                        // menu_selection(
                        //     image: 'assets/images/appointment.png',
                        //     title: 'Prescription',
                        //     ontap: () {}),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        menu_selection(
                            image: 'assets/images/doctor.png',
                            title: 'History Taking',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HistoryTaking()));
                            }),
                        SizedBox(
                          height: 2,
                        ),
                        menu_selection(
                            image: 'assets/images/doctor.png',
                            title: 'Emergency',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Call()));
                            }),
                        SizedBox(
                          height: 2,
                        ),
                        menu_selection(
                            image: 'assets/images/doctor.png',
                            title: 'Blog',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Blogs()));
                            }),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Health Card", style: TextStyles.title.bold),
                      Text(
                        "View",
                        style: TextStyles.titleNormal
                            .copyWith(color: Theme.of(context).primaryColor),
                      ).p(8).ripple(() {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicalCard()));
                      })
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    height: 125,
                    margin: const EdgeInsets.only(left: 15.0),
                    child: CardSection(
                      image: AssetImage(
                        'assets/images/person2.png',
                      ),
                      name: sharedPreferences!.getString("name")!,
                      age: "",
                      info: sharedPreferences!.getString("email")!,
                      mr: sharedPreferences!.getString("phone")!,
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Doctors", style: TextStyles.title.bold),
                      GestureDetector(
                        child: Text(
                          "See All",
                          style: TextStyles.titleNormal
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FindPage()));
                        },
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        menu_selection(
                            image: 'assets/images/doctorsPNG.png',
                            title: 'Near Me',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NearMe()));
                            }),
                        SizedBox(
                          height: 2,
                        ),
                        menu_selection(
                            image: 'assets/images/doctorsPNG.png',
                            title: 'General Physician',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => General()));
                            }),
                        SizedBox(
                          height: 2,
                        ),
                        menu_selection(
                            image: 'assets/images/doctorsPNG.png',
                            title: 'Dentist',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dentist()));
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        menu_selection(
                            image: 'assets/images/doctorsPNG.png',
                            title: 'Skin Specialist',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Skin()));
                            }),
                        SizedBox(
                          height: 2,
                        ),
                        menu_selection(
                            image: 'assets/images/doctorsPNG.png',
                            title: 'Cardio',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChestPage()));
                            }),
                        SizedBox(
                          height: 2,
                        ),
                        menu_selection(
                            image: 'assets/images/doctorsPNG.png',
                            title: 'Child Specialist',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Child()));
                            }),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: OnTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            title: Text("Emergency"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Account"),
          ),
        ],
      ),
    );
  }

  Widget _categoryCard(String title, String subtitle,
      {required Color color, required Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    return AspectRatio(
      aspectRatio: 6 / 7,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 7,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -2,
                  left: -15,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    //backgroundImage: AssetImage('assets/images/pill.png'),
                    radius: 40,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(title, style: titleStyle).hP8,
                    ),
                    SizedBox(height: 20),
                    Flexible(
                      child: Text(
                        subtitle,
                        textAlign: TextAlign.left,
                        style: subtitleStyle,
                      ),
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChestPage()));
        }, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  void OnTabTapped(int index) {
    _currentIndex = index;

    if (_currentIndex == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Call()));
    } else {
      if (_currentIndex == 2) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => settingsPage()));
      }
    }
  }
}

enum ClipType { bottom, semiCircle, halfCircle, multiple }

class MyCustomClipper extends CustomClipper<Path> {
  ClipType clipType;

  MyCustomClipper({required this.clipType});

  @override
  getClip(Size size) {
    var path = new Path();
    if (clipType == ClipType.bottom) {
      createBottom(size, path);
    } else if (clipType == ClipType.semiCircle) {
      createSemiCirle(size, path);
    } else if (clipType == ClipType.halfCircle) {
      createHalfCircle(size, path);
    } else if (clipType == ClipType.multiple) {
      createMultiple(size, path);
    }
    path.close();
    return path;
  }

  createSemiCirle(Size size, Path path) {
    path.lineTo(size.width / 1.40, 0);

    var firstControlPoint = new Offset(size.width / 1.30, size.height / 2.5);
    var firstEndPoint = new Offset(size.width / 1.85, size.height / 1.85);

    var secondControlPoint = new Offset(size.width / 4, size.height / 1.45);
    var secondEndPoint = new Offset(0, size.height / 1.75);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(0, size.height / 1.75);
  }

  createBottom(Size size, Path path) {
    path.lineTo(0, size.height / 1.19);
    var secondControlPoint = new Offset((size.width / 2), size.height);
    var secondEndPoint = new Offset(size.width, size.height / 1.19);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
  }

  createHalfCircle(Size size, Path path) {
    path.lineTo(size.width / 2, 0);
    var firstControlPoint = new Offset(size.width / 1.10, size.height / 2);
    var firstEndPoint = new Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(0, size.height);
  }

  createMultiple(Size size, Path path) {
    path.lineTo(0, size.height);

    var curXPos = 0.0;
    var curYPos = size.height;
    Random rnd = new Random();

    var increment = size.width / 40;
    while (curXPos < size.width) {
      curXPos += increment;
      curYPos = curYPos == size.height
          ? size.height - rnd.nextInt(50 - 0)
          : size.height;
      path.lineTo(curXPos, curYPos);
    }
    path.lineTo(size.width, 0);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CardSection extends StatelessWidget {
  final String name;
  final String age;
  final String info;
  final String mr;
  final ImageProvider image;

  CardSection(
      {required this.name,
      required this.age,
      required this.info,
      required this.mr,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        width: 500,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          color: Colors.white,
        ),
        child: Stack(
          overflow: Overflow.clip,
          children: <Widget>[
            Positioned(
              child: ClipPath(
                clipper: MyCustomClipper(clipType: ClipType.semiCircle),
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: LightColor.red.withOpacity(0.1),
                  ),
                  height: 120,
                  width: 120,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'MR: ' + mr,
                        style: TextStyle(
                            fontSize: 15, color: LightColor.textPrimary),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.textPrimary),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '$age $info',
                              style: TextStyle(
                                  fontSize: 15, color: LightColor.textPrimary),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: Container(
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            shape: BoxShape.rectangle,
                            color: Color(0xFFF0F4F8),
                          ),
                          width: 44,
                          height: 44,
                          child: Center(
                            child: Icon(
                              Icons.health_and_safety_outlined,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        onTap: () {
                          debugPrint("Button clicked. Handle button setState");
                        },
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
  }
}
