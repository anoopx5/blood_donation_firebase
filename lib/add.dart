import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
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
  void addDonor() {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroup,
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Donor Details',
          style: GoogleFonts.aBeeZee(),
        ),
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
              label: Text('Mobile Number'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DropdownButtonFormField(
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
                addDonor();
                Navigator.pop(context);
              }),
              child: Text('Submit', style: GoogleFonts.aBeeZee(fontSize: 20))),
        )
      ]),
    );
  }
}
