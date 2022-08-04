import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_screen/data/database.dart';
import 'package:home_screen/doctorProfile/doctor_profile.dart';
import 'package:home_screen/home/home_screen.dart';
import 'package:home_screen/home/text_styles.dart';
import 'package:home_screen/home/extention.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:home_screen/home/light_color.dart';
import 'package:home_screen/home/theme.dart';

class ChestPage extends StatefulWidget {
  const ChestPage({Key? key}) : super(key: key);

  @override
  _ChestPageState createState() => _ChestPageState();
}

class _ChestPageState extends State<ChestPage> {
  String searchResult = "";
  final Stream<QuerySnapshot> doctorStream = FirebaseFirestore.instance
      .collection('doctors')
      .where('specialization', isEqualTo: "Cardio")
      .snapshots();
  static double headerHeight = 100;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      appBar: AppBar(
          title: Text(
            "Cardio Doctors",
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
      body: Stack(
        children: [
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Theme.of(context).accentColor,
              height: headerHeight,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, right: 16, left: 16, bottom: 4),
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Doctors", style: TextStyles.title.bold),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: doctorStream,
                    builder: (context, snapshot) {
                      final List storedocs = [];
                      snapshot.data?.docs.map((DocumentSnapshot document) {
                        Map a = document.data() as Map<String, dynamic>;
                        storedocs.add(a);
                      }).toList();
                      return Container(
                        height: 1000,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: storedocs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  print('Tapped Doctor');
                                  //setState(() {});
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DoctorProfile(
                                              id: snapshot
                                                  .data!.docs[index].id)));
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
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.asset(
                                                        'assets/images/profilepicture.png'),
                                                  ),
                                                ),
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
                                                        ('Dr. ') +
                                                            storedocs[index]
                                                                ['name'],
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
                                                        storedocs[index]
                                                            ['specialization'],
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
                                            onTap: () {
                                              print('Tapped Heart');
                                              setState(() {});
                                            },
                                            child: AnimatedContainer(
                                              height: 35,
                                              padding: EdgeInsets.all(5),
                                              duration:
                                                  Duration(milliseconds: 300),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color:
                                                          Colors.red.shade100)),
                                              child: Center(
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
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
                                                    storedocs[index]
                                                        ['qualification'],
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Age 34',
                                              style: TextStyle(
                                                  color: Colors.grey.shade800,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );

                              // return Card(
                              //   child: ListTile(
                              //     title: Text(storedocs[index]['name']),
                              //     subtitle:
                              //         Text(storedocs[index]['specialization']),
                              //     leading: CircleAvatar(
                              //       backgroundColor: Colors.blue,
                              //     ),
                              //   ),
                              // );
                            }),
                      );
                    })
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.call),
            title: Text("Emergency"),
            selectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.chat),
            title: Text("Chat"),
            selectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Account"),
            selectedColor: Colors.grey,
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
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 4,
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
        ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  Card _searchInput() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          cursorColor: Colors.black54,
          decoration: InputDecoration(
              icon: Icon(Icons.search, color: Colors.black),
              border: InputBorder.none,
              hintText: 'Search ...'),
        ),
      ),
    );
  }
}
