import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class menu_selection extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback ontap;
  const menu_selection(
      {Key? key, required this.image, required this.title, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      child: Column(
        children: [
          BouncingWidget(
            duration: Duration(milliseconds: 200),
            scaleFactor: 1,
            onPressed: ontap,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(1.0, 1.0), // shadow direction: bottom right
                    )
                  ],
                  image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.scaleDown,
                      scale: 0.75)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }
}
