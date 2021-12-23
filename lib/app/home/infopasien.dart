// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:cekgigi/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class infopasien extends StatefulWidget {
  const infopasien({Key? key}) : super(key: key);

  @override
  _infopasienState createState() => _infopasienState();
}

class _infopasienState extends State<infopasien> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userdata = firestore.collection('user');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user!.email;

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: StreamBuilder<DocumentSnapshot>(
        stream: userdata.doc(emaila.toString()).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            String nama;
            nama = data['nama'];
            String imageUrl;
            imageUrl = data['imageurl'];

            return Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'hello',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          nama,
                          style: GoogleFonts.pathwayGothicOne(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Card(
                          elevation: 4,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                            child: Image(
                              image: NetworkImage(imageUrl),
                              height: 48,
                              width: 48,
                              fit: BoxFit.cover,
                            ),
                          )),
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Registrasi();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
