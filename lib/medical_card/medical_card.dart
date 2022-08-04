import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_screen/global/global.dart';
import 'package:home_screen/home/home_screen.dart';
import 'package:home_screen/medical_card/add_record.dart';
import 'package:home_screen/medical_card/custom_divider.dart';
import 'package:home_screen/medical_card/styles.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart';

class MedicalCard extends StatelessWidget {
  const MedicalCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
          title: Text(
            "Heath Card",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Color(0xFF264CD2),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AddRecordPage()));
                },
                icon: Icon(Icons.add))
          ],
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          )),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(sharedPreferences!.getString("uid"))
              .collection('records')
              .doc('medicalCard')
              .snapshots(),
          builder: (context, snapshot) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
              children: [
                Gap(30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 86,
                      width: 86,
                      decoration: BoxDecoration(
                        color: Color(0xFFF37B67),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/images/wt1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          sharedPreferences!.getString("name")!,
                          style: Styles.headline1Style,
                        ),
                        Gap(2),
                        Text(
                          'Karachi',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500),
                        ),
                        Gap(8),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.green,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                padding: EdgeInsets.all(3),
                                child: Icon(
                                  Icons.coronavirus_rounded,
                                  color: Colors.green,
                                  size: 12,
                                ),
                              ),
                              Gap(3),
                              Text(
                                'Your Health Card',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Gap(6)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(6),
                        InkWell(
                          child: Text(
                            '',
                            style: Styles.textStyle.copyWith(
                                color: Styles.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Gap(8),
                Divider(
                  color: Colors.black,
                ),
                Gap(8),
                Stack(
                  children: [
                    Container(
                      height: 105,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Styles.primaryColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    Positioned(
                      right: -45,
                      top: -40,
                      child: Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 18, color: Color(0xFF264CD2)),
                            color: Colors.transparent),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: FittedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.health_and_safety_rounded,
                                color: Colors.green,
                                size: 40,
                              ),
                              backgroundColor: Colors.white,
                              maxRadius: 25,
                            ),
                            Gap(12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Your digital health card',
                                  style: Styles.headline2Style.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                Gap(2),
                                Text(
                                  'accepted nationwide',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.9)),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(25),
                Text(
                  'Heath Details',
                  style: Styles.headline2Style,
                ),
                Gap(10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Styles.bgColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 1,
                          spreadRadius: 1)
                    ],
                  ),
                  child: Column(
                    children: [
                      Gap(15),
                      Text(
                        'MR:  ${sharedPreferences!.getString("phone")}',
                        style: TextStyle(
                            fontSize: 45,
                            color: Styles.textColor,
                            fontWeight: FontWeight.w600),
                      ),
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${data['userAge']}',
                              style:
                                  Styles.subtitle1Style.copyWith(fontSize: 16)),
                          Text('${data['userGender']}',
                              style:
                                  Styles.subtitle1Style.copyWith(fontSize: 16)),
                        ],
                      ),
                      Gap(4),
                      Divider(
                        color: Colors.grey.shade300,
                      ),
                      Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Blood Group', style: Styles.headline3Style),
                              Gap(5),
                              Text('${data['userBloodGroup']}',
                                  style: Styles.subtitle1Style
                                      .copyWith(fontSize: 16)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Avg Blood Pressure',
                                  style: Styles.headline3Style),
                              Gap(5),
                              Text('${data['userAvgBP']}',
                                  style: Styles.subtitle1Style
                                      .copyWith(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      Gap(12),
                      customDivider(),
                      Gap(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Height', style: Styles.headline3Style),
                              Gap(5),
                              Text('${data['userHeight']}',
                                  style: Styles.subtitle1Style
                                      .copyWith(fontSize: 16)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Weight', style: Styles.headline3Style),
                              Gap(5),
                              Text('${data['userWeight']}',
                                  style: Styles.subtitle1Style
                                      .copyWith(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      Gap(12),
                      customDivider(),
                      Gap(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Allergies', style: Styles.headline3Style),
                              Gap(5),
                              Text('${data['userAllergies']}',
                                  style: Styles.subtitle1Style
                                      .copyWith(fontSize: 16)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Diseases', style: Styles.headline3Style),
                              Gap(5),
                              Text('${data['userDisease']}',
                                  style: Styles.subtitle1Style
                                      .copyWith(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      Gap(25),
                      InkWell(
                        child: Text(
                          'Consult a Doctor',
                          style: Styles.textStyle.copyWith(
                              color: Styles.primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Gap(20),
                    ],
                  ),
                ),
                Gap(10),
                ElevatedButton(
                  onPressed: _createPDF,
                  child: Text('Share'),
                )
              ],
            );
          }),
    );
  }

  Future<void> _createPDF() async {
    String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    PdfDocument document = PdfDocument();

    final PdfPageTemplateElement headerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
//Draw text in the header.
    headerTemplate.graphics.drawString(sharedPreferences!.getString("name")!,
        PdfStandardFont(PdfFontFamily.helvetica, 15),
        bounds: const Rect.fromLTWH(0, 15, 200, 20));
//Add the header element to the document.
    document.template.top = headerTemplate;
//Create a PDF page template and add footer content.
    final PdfPageTemplateElement footerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
//Draw text in the footer.
    footerTemplate.graphics.drawString(
        'This is a digital generated document and does not require any signature',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(0, 15, 200, 20));
//Set footer in the document.
    document.template.bottom = footerTemplate;

    final page = document.pages.add();

    page.graphics.drawString(
        'Medical Card', PdfStandardFont(PdfFontFamily.helvetica, 50));
    page.graphics.drawString(
        DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(400, 75, 0, 0));
    PdfOrderedList(
            items: PdfListItemCollection(<String>[
              'Name:' + sharedPreferences!.getString("name")!,
              'MR:  ${sharedPreferences!.getString("phone")}',
              'Age:  ${sharedPreferences!.getString("userAge")}',
              'Gender:  ${sharedPreferences!.getString("userGender")}',
              'BloodGroup:  ${sharedPreferences!.getString("userBloodGroup")}',
            ]),
            font: PdfStandardFont(PdfFontFamily.helvetica, 15,
                style: PdfFontStyle.regular),
            indent: 15,
            style: PdfNumberStyle.lowerRoman,
            format: PdfStringFormat(lineSpacing: 10))
        .draw(page: page, bounds: Rect.fromLTWH(0, 100, 0, 0));

    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'MedicalCard.pdf');
  }
}
