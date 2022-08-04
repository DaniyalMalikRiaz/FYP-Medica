import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_screen/global/global.dart';
import 'package:home_screen/home/home_screen.dart';

import 'package:home_screen/home/text_styles.dart';
import 'package:home_screen/home/extention.dart';
import 'package:home_screen/medical_card/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';

class HistoryTaking extends StatefulWidget {
  const HistoryTaking({Key? key}) : super(key: key);

  @override
  _HistoryTakingState createState() => _HistoryTakingState();
}

class _HistoryTakingState extends State<HistoryTaking> {
  String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
  int _index = 0;
  int currentStep = 0;

  final _formKey = GlobalKey<FormState>();

  var genderDropdown = "";

  final hAgeController = TextEditingController();
  final hGenderController = TextEditingController();
  final hWeightController = TextEditingController();
  final hNameController = TextEditingController();
  final hMStatusController = TextEditingController();
  final hLAdminssionController = TextEditingController();
  final hReasonController = TextEditingController();
  final hAllergiesController = TextEditingController();

  final hConditionsController = TextEditingController();
  final hMedicationsController = TextEditingController();
  final hMedicationListController = TextEditingController();
  final hTobacoController = TextEditingController();

  Future addToDatabase() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection('records')
        .doc('historyForm')
        .set({
      "historyName": hNameController.text,
      "hAge": hAgeController.text,
      "hGender": genderDropdown,
      "hMStatus": hMStatusController.text,
      "hWeight": hWeightController.text,
      "hLAdminssion": hLAdminssionController.text,
      "hReason": hReasonController.text,
      "hAllergies": hAllergiesController.text,
      "hConditions": hConditionsController.text,
      "hMedications": hMedicationsController.text,
      "hMedicationList": hMedicationListController.text,
      "hTobaco": hTobacoController.text,
    }, SetOptions(merge: true));
  }

  String dropdownValue = 'Gender';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "History",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Theme.of(context).accentColor,
          actions: [IconButton(onPressed: () => {}, icon: Icon(Icons.restore))],
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          )),
      body: Container(
        //color: Color(0xFF264CD2),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 15),
        child: Form(
          key: _formKey,
          child: Stepper(
            steps: _stepper(),
            currentStep: this.currentStep,
            onStepTapped: (step) {
              setState(() {
                this.currentStep = step;
              });
            },
            onStepContinue: () {
              setState(() {
                if (this.currentStep < this._stepper().length - 1) {
                  this.currentStep = this.currentStep + 1;
                } else {
                  print('complete');
                }
              });
              addToDatabase();
            },
          ),
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(90, 0, 5, 0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FloatingActionButton.extended(
                  onPressed: _createPDF,
                  backgroundColor: Theme.of(context).accentColor,
                  icon: Icon(Icons.picture_as_pdf),
                  label: Text('Share'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sent to doctor')));
                  },
                  backgroundColor: Theme.of(context).accentColor,
                  icon: Icon(Icons.send_rounded),
                  label: Text('Send to Doctor'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
        title: Text('Patient Profile', style: TextStyles.title.bold),
        content: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              controller: hNameController,
            ),
            TextFormField(
                decoration: InputDecoration(labelText: 'Gender'),
                controller: hGenderController),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 250, 0),
              child: DropdownButton<String>(
                value: dropdownValue,
                hint: Text("Gender"),
                icon: const Icon(Icons.arrow_downward),
                elevation: 12,
                alignment: AlignmentDirectional.center,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 1,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    //  hGenderController = newValue as TextEditingController;
                    genderDropdown = newValue;
                  });
                },
                items: <String>['Male', 'Female', 'Gender']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                controller: hAgeController),
            TextFormField(
                decoration: InputDecoration(labelText: 'Maritial Status'),
                controller: hMStatusController),
            TextFormField(
                decoration: InputDecoration(labelText: 'Weight'),
                controller: hWeightController),
          ],
        ),
        isActive: currentStep >= 0,
        state: StepState.indexed,
      ),
      Step(
        title: Text('Current Details', style: TextStyles.title.bold),
        content: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Last admission'),
              controller: hLAdminssionController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Reason'),
              controller: hReasonController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Allergies (If Any)'),
              controller: hAllergiesController,
            ),
          ],
        ),
        isActive: currentStep >= 1,
        state: StepState.indexed,
      ),
      Step(
        title: Text('Condition', style: TextStyles.title.bold),
        content: Column(
          children: [
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Conditions apply to you:'),
              controller: hConditionsController,
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Are yout aking any medications?'),
              controller: hMedicationsController,
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Name Medicatios (If Any)'),
              controller: hMedicationListController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Do you use tobaco?'),
              controller: hTobacoController,
            ),

            /*
            CheckboxListTile(
              title: const Text('Example 4'),
              value: false,
              onChanged: (Null) {},
              //secondary: const Icon(Icons.hourglass_empty),
            ),*/
          ],
        ),
        isActive: currentStep >= 2,
        state: StepState.indexed,
      )
    ];
    return _steps;
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();

    final PdfPageTemplateElement headerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
//Draw text in the header.
    headerTemplate.graphics.drawString(
        hNameController.text, PdfStandardFont(PdfFontFamily.helvetica, 15),
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
        'History Form', PdfStandardFont(PdfFontFamily.helvetica, 50));
    page.graphics.drawString(
        DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(400, 75, 0, 0));
    PdfOrderedList(
            items: PdfListItemCollection(<String>[
              'Age:' + hAgeController.text,
              'Gender:' + genderDropdown,
              'Weight:' + hWeightController.text,
              'Maritial Status:' + hMStatusController.text,
              'Last Admission:' + hLAdminssionController.text,
              'Reason:' + hReasonController.text,
              'Allergies:' + hAllergiesController.text,
              'Conditions:' + hConditionsController.text,
              'Taking Medications:' + hMedicationsController.text,
              'Medications:' + hMedicationListController.text,
              'Tobaco:' + hTobacoController.text,
            ]),
            font: PdfStandardFont(PdfFontFamily.helvetica, 15,
                style: PdfFontStyle.regular),
            indent: 15,
            style: PdfNumberStyle.lowerRoman,
            format: PdfStringFormat(lineSpacing: 10))
        .draw(page: page, bounds: Rect.fromLTWH(0, 100, 0, 0));

    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'HistorForm.pdf');
  }
}
