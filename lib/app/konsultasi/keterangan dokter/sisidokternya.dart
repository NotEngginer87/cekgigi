// ignore_for_file: camel_case_types, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class infodokternya extends StatefulWidget {
  const infodokternya(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;
  @override
  _infodokternyaState createState() => _infodokternyaState();
}

class _infodokternyaState extends State<infodokternya> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');
    return
      StreamBuilder<DocumentSnapshot>(
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


            return Padding(
              padding: const EdgeInsets.only(
                  top: 4, left: 20, right: 20, bottom: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 160,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(25)),
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
                                        borderRadius:
                                        BorderRadius.circular(24),
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
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Icon(
                                                  LineIcons.stethoscope,
                                                  size: 24,
                                                  color: Colors.red.shade800,
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                      exp.toString() + 'th',
                                                      style:
                                                      GoogleFonts.poppins(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 12,
                                                        color: Colors
                                                            .red.shade900,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(24),
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
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Icon(
                                                  LineIcons.clock,
                                                  size: 24,
                                                  color:
                                                  Colors.green.shade900,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                          waktuawal
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            fontSize: 12,
                                                            color: Colors
                                                                .green
                                                                .shade900,
                                                          )),
                                                    ),
                                                    Text(' - ',
                                                        style: GoogleFonts
                                                            .poppins(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 12,
                                                          color: Colors
                                                              .green.shade900,
                                                        )),
                                                    SizedBox(
                                                      child: Text(
                                                          waktuakhir
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            fontSize: 12,
                                                            color: Colors
                                                                .green
                                                                .shade900,
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
                                        borderRadius:
                                        BorderRadius.circular(24),
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
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Icon(
                                                  LineIcons.star,
                                                  size: 24,
                                                  color:
                                                  Colors.yellow.shade800,
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                      rating.toString(),
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

class edukasidokternya extends StatefulWidget {
  const edukasidokternya(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;
  @override
  _edukasidokternyaState createState() => _edukasidokternyaState();
}

class _edukasidokternyaState extends State<edukasidokternya> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');
    return StreamBuilder<DocumentSnapshot>(
      stream: dokter
          .doc(widget.iddokter)
          .collection('datakampus')
          .doc('datakampus')
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;

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

          String kampusS1keterangan = data['kampusS1keterangan'];
          String kampusS2keterangan = data['kampusS2keterangan'];
          String kampusS3keterangan = data['kampusS3keterangan'];
          String kampusSpesialisketerangan = data['kampusSpesialisketerangan'];
          String kampusprofesiketerangan = data['kampusprofesiketerangan'];

          return Padding(
            padding: const EdgeInsets.only(
                top: 4, left: 20, right: 20, bottom: 4),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration:  const BoxDecoration(
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
                          decoration:  BoxDecoration(
                            color: Colors.teal.shade800,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
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


                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Column(
                      children: [

                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration:  BoxDecoration(
                                color: Colors.teal.shade800,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
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
                                  'Sarjana - ' + kampusS1keterangan,
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
                              decoration:  BoxDecoration(
                                color: Colors.teal.shade800,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
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
                                  'Profesi - ' + kampusprofesiketerangan,
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
                        (kampusS2 != '')
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration:  BoxDecoration(
                                color: Colors.teal.shade800,
                                borderRadius: const BorderRadius.all(
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
                                  'Magister - ' + kampusS2keterangan,
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
                        (kampusS3 != '')
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration:  BoxDecoration(
                                color: Colors.teal.shade800,
                                borderRadius: const BorderRadius.all(
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
                                  'Doktoral - ' + kampusS3keterangan,
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
                        (kampusSpesialis != '')
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration:  BoxDecoration(
                                color: Colors.teal.shade800,
                                borderRadius: const BorderRadius.all(
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
                                  'Spesialis - ' + kampusSpesialisketerangan,
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
                    height: 8,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
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

class klinikdokternya extends StatefulWidget {
  const klinikdokternya(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;
  @override
  _klinikdokternyaState createState() => _klinikdokternyaState();
}

class _klinikdokternyaState extends State<klinikdokternya> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');
    return StreamBuilder<DocumentSnapshot>(
      stream: dokter
          .doc(widget.iddokter)
          .collection('klinik')
          .doc('y')
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;

          String klinik1 = data['klinik1'];
          String klinik2 = data['klinik2'];
          String klinik3 = data['klinik3'];
          String awaltimeklinik1 = data['awaltimeklinik1'];
          String awaltimeklinik2 = data['awaltimeklinik2'];
          String awaltimeklinik3 = data['awaltimeklinik3'];
          String akhirtimeklinik1 = data['akhirtimeklinik1'];
          String akhirtimeklinik2 = data['akhirtimeklinik2'];
          String akhirtimeklinik3 = data['akhirtimeklinik3'];

          return Padding(
            padding: const EdgeInsets.only(
                top: 4, left: 20, right: 20, bottom: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                              decoration: BoxDecoration(
                                color: Colors.teal.shade900,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
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
                            Text(
                              'Klinik',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      (klinik1 != '')
                          ? Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.teal.shade900,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12)),
                              ),
                              child: const Icon(
                                Icons.local_hospital_outlined,
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
                      )
                          : Container(),
                      const SizedBox(
                        height: 8,
                      ),
                      (klinik2 != '')
                          ? Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.teal.shade900,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12)),
                              ),
                              child: const Icon(
                                Icons.local_hospital_outlined,
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
                      )
                          : Container(),
                      const SizedBox(
                        height: 8,
                      ),
                      (klinik3 != '')
                          ? Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration:  BoxDecoration(
                                color: Colors.teal.shade900,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12)),
                              ),
                              child: const Icon(
                                Icons.local_hospital_outlined,
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
                      )
                          : Container(),
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

