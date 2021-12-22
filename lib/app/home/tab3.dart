// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'EditProfile.dart';

class Tab3 extends StatefulWidget {
  const Tab3({Key? key}) : super(key: key);

  @override
  _Tab3State createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userdata = firestore.collection('user');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user!.email;

    final ButtonStyle KebijakanPrivasiButton = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: Colors.white,
      minimumSize: Size(MediaQuery.of(context).size.width, 48),
      padding: EdgeInsets.symmetric(horizontal: 0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('RocketEdu'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFEF1E6),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Akun',
                              style: GoogleFonts.pathwayGothicOne(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ],
                        ),

                        // ignore: deprecated_member_use
                        FlatButton(
                            textColor: Color(0xFF9A9483),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registrasi()),
                              );
                            },
                            child: Text('Edit')),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'email: ',
                            style: GoogleFonts.pathwayGothicOne(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          Text(
                            emaila.toString(),
                            style: GoogleFonts.pathwayGothicOne(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: userdata.doc(emaila.toString()).snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          String nama;
                          nama = data['nama'];
                          String noHP;
                          noHP = data['nomorhp'];

                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 4, right: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'nama :  ',
                                      style: GoogleFonts.pathwayGothicOne(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      nama,
                                      style: GoogleFonts.pathwayGothicOne(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4, right: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'nomor HP: ',
                                      style: GoogleFonts.pathwayGothicOne(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      noHP,
                                      style: GoogleFonts.pathwayGothicOne(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(.2),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Informasi',
                          style: GoogleFonts.pathwayGothicOne(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      style: KebijakanPrivasiButton,
                      child: Text(
                        'Kritik dan Saran',
                        style: GoogleFonts.pathwayGothicOne(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        style: KebijakanPrivasiButton,
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                              top: 8,
                                              bottom: 4),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            height: 48,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Hubungi Kami',
                                              style:
                                                  GoogleFonts.pathwayGothicOne(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.white),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF5d1a77),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  7 /
                                                  8,
                                              child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: Row(
                                                    children: [
                                                      Icon(LineIcons.whatSApp),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        'WhatsApp',
                                                        style: GoogleFonts
                                                            .pathwayGothicOne(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 18),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  7 /
                                                  8,
                                              child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: Row(
                                                    children: [
                                                      Icon(LineIcons.phone),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        'Telepon',
                                                        style: GoogleFonts
                                                            .pathwayGothicOne(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 18),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  7 /
                                                  8,
                                              child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.mail),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        'kontakident@gmail.com',
                                                        style: GoogleFonts
                                                            .pathwayGothicOne(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 18),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        )
                                      ]),
                                );
                              });
                        },
                        child: Text(
                          'Kontak',
                          style: GoogleFonts.pathwayGothicOne(
                              fontWeight: FontWeight.w500, fontSize: 18),
                          textAlign: TextAlign.left,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      style: KebijakanPrivasiButton,
                      child: Text(
                        'Kenapa iDent ?',
                        style: GoogleFonts.pathwayGothicOne(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
