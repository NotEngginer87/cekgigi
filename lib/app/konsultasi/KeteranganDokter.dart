// ignore_for_file: file_names, camel_case_types

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:slide_to_act/slide_to_act.dart';

class KeteranganDokter extends StatefulWidget {
  const KeteranganDokter({
    required this.image,
    required this.iddokter,
    Key? key,
  }) : super(key: key);
  final String image;
  final String iddokter;
  @override
  _KeteranganDokterState createState() => _KeteranganDokterState();
}

class _KeteranganDokterState extends State<KeteranganDokter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: const Align(
              alignment: Alignment.center,
              child: Text('haha'),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Expanded(
                    child: ListView(
                      children: [
                        dokternya(widget.iddokter),
                        komentarnya(widget.iddokter),
                      ],
                    ),
                  )),
            ),
          ),
          Builder(
            builder: (context) {
              final GlobalKey<SlideActionState> _key = GlobalKey();
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SlideAction(
                  key: _key,
                  text: 'konsultasi',
                  onSubmit: () {
                    Future.delayed(
                      Duration(seconds: 1),
                      () => _key.currentState?.reset(),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class dokternya extends StatefulWidget {
  const dokternya(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;
  @override
  _dokternyaState createState() => _dokternyaState();
}

class _dokternyaState extends State<dokternya> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');
    return StreamBuilder<DocumentSnapshot>(
      stream: dokter.doc(widget.iddokter).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;

          String nama = data['nama'];
          String gelar = data['gelar'];
          String gambar = data['urlgambar'];
          String waktuawal = data['waktuawal'];
          String waktuakhir = data['waktuakhir'];
          int rating = data['rating'];
          int exp = data['exp'];
          String klinik1 = data['klinik1'];
          String klinik2 = data['klinik2'];
          String klinik3 = data['klinik3'];
          String awaltimeklinik1 = data['awaltimeklinik1'];
          String awaltimeklinik2 = data['awaltimeklinik2'];
          String awaltimeklinik3 = data['awaltimeklinik3'];
          String akhirtimeklinik1 = data['akhirtimeklinik1'];
          String akhirtimeklinik2 = data['akhirtimeklinik2'];
          String akhirtimeklinik3 = data['akhirtimeklinik3'];
          String kampusS1 = data['kampusS1'];
          String kampusS2 = data['kampusS2'];
          String kampusS3 = data['kampusS3'];
          String kampusSpesialis = data['kampusSpesialis'];
          String kampusprofesi = data['kampusprofesi'];

          String kampusS1tamat = data['kampusS1tamat'];
          String kampusS2tamat = data['kampusS2tamat'];
          String kampusS3tamat = data['kampusS3tamat'];
          String kampusSpesialistamat = data['kampusSpesialistamat'];
          String kampusprofesitamat = data['kampusprofesitamat'];

          return Padding(
            padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                nama,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                gelar,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    elevation: 4,
                                    child: Container(
                                        color: Colors.pink.shade100,
                                        width: 64,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                LineIcons.stethoscope,
                                                size: 24,
                                                color: Colors.red.shade800,
                                              ),
                                              SizedBox(
                                                child: Text(
                                                    exp.toString() + 'th',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 12,
                                                      color:
                                                      Colors.red.shade900,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    elevation: 4,
                                    child: Container(
                                        color: Colors.greenAccent.shade100,
                                        width: 120,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                LineIcons.clock,
                                                size: 24,
                                                color: Colors.green.shade900,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    child: Text(
                                                        waktuawal.toString(),
                                                        style:
                                                        GoogleFonts.poppins(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 12,
                                                          color: Colors
                                                              .green.shade900,
                                                        )),
                                                  ),
                                                  Text(' - ',
                                                      style:
                                                      GoogleFonts.poppins(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 12,
                                                        color: Colors
                                                            .green.shade900,
                                                      )),
                                                  SizedBox(
                                                    child: Text(
                                                        waktuakhir.toString(),
                                                        style:
                                                        GoogleFonts.poppins(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 12,
                                                          color: Colors
                                                              .green.shade900,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    elevation: 4,
                                    child: Container(
                                        color: Colors.yellow.shade100,
                                        width: 52,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                LineIcons.star,
                                                size: 24,
                                                color: Colors.yellow.shade800,
                                              ),
                                              SizedBox(
                                                child: Text(rating.toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 12,
                                                      color:
                                                      Colors.green.shade900,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 4,
                          child: Ink.image(
                            image: NetworkImage(gambar),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius:
                                BorderRadius.all(Radius.circular(12)),
                              ),
                              child: const Icon(
                                Icons.local_hospital,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  klinik1,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      awaltimeklinik1,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      ' - ',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      akhirtimeklinik1,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius:
                                BorderRadius.all(Radius.circular(12)),
                              ),
                              child: const Icon(
                                Icons.local_hospital,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  klinik2,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      awaltimeklinik2,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      ' - ',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      akhirtimeklinik2,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius:
                                BorderRadius.all(Radius.circular(12)),
                              ),
                              child: const Icon(
                                Icons.local_hospital,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  klinik3,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      awaltimeklinik3,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      ' - ',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      akhirtimeklinik3,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius:
                                BorderRadius.all(Radius.circular(12)),
                              ),
                              child: const Icon(
                                Icons.school,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Education',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down), onPressed: () {

                            },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: const Icon(
                                    Icons.school_outlined,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sarjana',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      kampusS1tamat + ' ' + kampusS1,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: const Icon(
                                    Icons.school_outlined,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Profesi Dokter Gigi',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      kampusprofesitamat + ' ' + kampusprofesi,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            (kampusS2 != null)
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                  ),
                                  child: const Icon(
                                    Icons.school_outlined,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Magister',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      kampusS2tamat + ' ' + kampusS2,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Container(),
                            const SizedBox(
                              height: 8,
                            ),
                            (kampusS3 != null)
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                  ),
                                  child: const Icon(
                                    Icons.school_outlined,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Doktoral',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      kampusS3tamat + ' ' + kampusS3,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Container(),
                            const SizedBox(
                              height: 8,
                            ),
                            (kampusSpesialis != null)
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                  ),
                                  child: const Icon(
                                    Icons.school_outlined,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Spesialis',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      kampusSpesialistamat +
                                          ' ' +
                                          kampusSpesialis,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Container(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}


class komentarnya extends StatelessWidget {
  const komentarnya(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');
    return StreamBuilder<QuerySnapshot>(
      stream: dokter.doc(iddokter).collection('komentar').snapshots(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Komentar terbaru',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        Column(
                            children: snapshot.data.docs
                                .map<Widget>((e) => KomentarCard(
                                      e.data()['nama'],
                                      e.data()['komentar'],
                                      e.data()['urlgambar'],
                                      e.data()['rate'],
                                    ))
                                .toList()),
                      ],
                    ),
                  ),
                ],
              ));
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class KomentarCard extends StatelessWidget {
  final String nama;
  final String komentar;
  final int rate;
  final String urlgambar;

  // ignore: prefer_const_constructors_in_immutables
  KomentarCard(
    this.nama,
    this.komentar,
    this.urlgambar,
    this.rate, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 24,
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 4,
                  child: Ink.image(
                    image: NetworkImage(
                      urlgambar,
                    ),
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        for (int i = 1; i <= rate; i++)
                          Icon(
                            LineIcons.starAlt,
                            size: 20,
                            color: Colors.yellow.shade800,
                          ),
                        for (int i = 1; i <= 5 - rate; i++)
                          Icon(
                            LineIcons.star,
                            size: 20,
                            color: Colors.yellow.shade800,
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 128,
                      child: Text(
                        nama,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 88,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 128,
                  child: Text(
                    komentar,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                )
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class Sliderrr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(),
                );
              },
            ),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    key: _key,
                    onSubmit: () {
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    key: _key,
                    onSubmit: () {
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    innerColor: Colors.black,
                    outerColor: Colors.white,
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    key: _key,
                    onSubmit: () {
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Unlock',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    sliderButtonIcon: Icon(Icons.lock),
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    key: _key,
                    onSubmit: () {
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    height: 100,
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    key: _key,
                    onSubmit: () {
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    sliderButtonIconSize: 48,
                    sliderButtonYOffset: -20,
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    key: _key,
                    onSubmit: () {
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    elevation: 24,
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    key: _key,
                    onSubmit: () {
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    borderRadius: 16,
                    animationDuration: Duration(seconds: 1),
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    key: _key,
                    onSubmit: () {
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    reversed: true,
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    key: _key,
                    onSubmit: () {
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    submittedIcon: Icon(
                      Icons.done_all,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    key: _key,
                    onSubmit: () {
                      Future.delayed(
                        Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    sliderRotate: false,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
