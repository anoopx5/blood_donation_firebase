import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  void updateDonor(DocId) {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroup,
    };
    donor.doc(DocId).update(data).then((value) => Navigator.pop(context));
  }

  final BloodGroup = [
    'A',
    'A+',
    'A-',
    'B',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O',
    'O+',
    'O-',
  ];
  String? selectedGroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  final msg = SnackBar(
    content: Text('Success'),
  );

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['phone'].toString();
    selectedGroup = args['group'];
    final DocId = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Donor Details'),
        backgroundColor: Colors.red[900],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            style: GoogleFonts.aBeeZee(),
            controller: donorName,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  'Donor Name',
                  style: GoogleFonts.aBeeZee(),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            style: GoogleFonts.aBeeZee(),
            controller: donorPhone,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                'Mobile Number',
                style: GoogleFonts.aBeeZee(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DropdownButtonFormField(
              value: selectedGroup,
              decoration: InputDecoration(
                  label: Text(
                'Select Your Blood Group',
                style: GoogleFonts.aBeeZee(),
              )),
              items: BloodGroup.map((e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  )).toList(),
              onChanged: (val) {
                selectedGroup = val as String?;
              }),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[900]),
                  minimumSize: MaterialStateProperty.all(
                    Size(double.infinity, 50),
                  )),
              onPressed: (() {
                updateDonor(DocId);
                const snackdemo = SnackBar(
                  content: Text(
                    'Successfully Updated',
                  ),
                  padding: EdgeInsets.all(15),
                  backgroundColor: Colors.green,
                  elevation: 5.0,
                  duration: Duration(seconds: 2),
                  // behavior: SnackBarBehavior.floating,
                  // margin: EdgeInsets.all(5),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackdemo);
              }),
              child: Text('Update', style: GoogleFonts.aBeeZee(fontSize: 20))),
        )
      ]),
    );
  }
}
