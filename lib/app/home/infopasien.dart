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
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'hello',
                  style: TextStyle(color: Colors.white),
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: userdata.doc(emaila.toString()).snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      String nama;
                      nama = data['nama'];

                      return Text(
                        nama,
                        style: GoogleFonts.pathwayGothicOne(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
            Icon(
              LineIcons.cog,
              size: 32,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
