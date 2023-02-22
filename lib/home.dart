import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  void deleteUser(DocId) {
    donor.doc(DocId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Blood Donation Application',
            style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red[900],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          child: Icon(
            Icons.bloodtype,
            size: 45,
            color: Colors.red,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        body: StreamBuilder(
            stream: donor.orderBy('name').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot donorSnap =
                        snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.yellow[100],
                            boxShadow: [BoxShadow(color: Colors.blueGrey)]),
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    donorSnap['group'],
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 23, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  donorSnap['name'],
                                  style: GoogleFonts.aBeeZee(fontSize: 18),
                                  // TextStyle(
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  donorSnap['phone'].toString(),
                                  style: GoogleFonts.podkova(fontSize: 18),
                                ),
                              ],
                            ),
                            Row(children: [
                              IconButton(
                                onPressed: (() {
                                  Navigator.pushNamed(context, '/update',
                                      arguments: {
                                        'name': donorSnap['name'],
                                        'phone': donorSnap['phone'],
                                        'group': donorSnap['group'].toString(),
                                        'id': donorSnap.id,
                                      });
                                }),
                                icon: Icon(Icons.edit),
                                color: Colors.green[600],
                              ),
                              IconButton(
                                onPressed: (() {
                                  deleteUser(donorSnap.id);
                                  const delUser = SnackBar(
                                    content: Text('Deleted Successfully'),
                                    padding: EdgeInsets.all(15),
                                    backgroundColor: Colors.red,
                                    elevation: 5.0,
                                    duration: Duration(seconds: 2),
                                    // behavior: SnackBarBehavior.floating,
                                    // margin: EdgeInsets.all(5),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(delUser);
                                }),
                                icon: Icon(Icons.delete),
                                color: Colors.red[800],
                              )
                            ])
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            }));
  }
}
