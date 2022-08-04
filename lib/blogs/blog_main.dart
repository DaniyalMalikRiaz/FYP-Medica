import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:home_screen/blogs/add_blog.dart';
import 'package:home_screen/home/home_screen.dart';
import 'package:home_screen/medical_card/styles.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key? key}) : super(key: key);

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  final Stream<QuerySnapshot> blogStream =
      FirebaseFirestore.instance.collection('blogs').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          "Blogs",
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
                    stream: blogStream,
                    builder: (context, snapshot) {
                      final List storeBlogs = [];
                      snapshot.data?.docs.map((DocumentSnapshot document) {
                        Map a = document.data() as Map<String, dynamic>;
                        storeBlogs.add(a);
                      }).toList();

                      return Container(
                        height: 1000,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: storeBlogs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {},
                                onLongPress: () {},
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
                                                        ("Title:  ") +
                                                            storeBlogs[index]
                                                                ['title'],
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
                                                        ("Blog:  ") +
                                                            storeBlogs[index]
                                                                ['text'],
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
                                                  Icons.bookmark,
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
                                                    ("Author:  ") +
                                                        storeBlogs[index]['by'],
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
                                                      color: Colors.lightGreen),
                                                  child: Text(
                                                    ("Tags:  ") +
                                                        storeBlogs[index]
                                                            ['tags'],
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
      floatingActionButton: Builder(builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(140, 200, 50, 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(SnackBar(content: Text('Add a Blog')));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AddBlog()));
                  },
                  backgroundColor: Theme.of(context).accentColor,
                  icon: Icon(Icons.add),
                  label: Text('Add a Blog'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
