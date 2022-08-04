import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:home_screen/blogs/blog_main.dart';
import 'package:home_screen/global/global.dart';
import 'package:home_screen/home/home_screen.dart';

class AddBlog extends StatefulWidget {
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final titleController = TextEditingController();
  final nameController = TextEditingController();
  final tagsController = TextEditingController();
  final textController = TextEditingController();

  Future addToDatabase() async {
    FirebaseFirestore.instance.collection("blogs").doc().set({
      "title": titleController.text,
      "by": nameController.text,
      "tags": tagsController.text,
      "text": textController.text,
    }, SetOptions(merge: true));
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
            "Add New Blog",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Blogs()));
            },
          )),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          children: <Widget>[
            PanelTitle(
              title: "Title",
              isRequired: true,
            ),
            TextFormField(
              maxLength: 20,
              style: TextStyle(
                fontSize: 16,
              ),
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            PanelTitle(
              title: "Author Name",
              isRequired: true,
            ),
            TextFormField(
              controller: nameController,
              style: TextStyle(
                fontSize: 16,
              ),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            PanelTitle(
              title: "Tags - Seperated by ,",
              isRequired: false,
            ),
            TextFormField(
              controller: tagsController,
              style: TextStyle(
                fontSize: 16,
              ),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            PanelTitle(
              title: "Text",
              isRequired: true,
            ),
            TextFormField(
              maxLength: 200,
              controller: textController,
              style: TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
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
                      "ADD",
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
                          return Blogs();
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
