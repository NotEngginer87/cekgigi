// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names

import 'package:cekgigi/app/konsultasi/rekammedis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../style.dart';

class event extends StatefulWidget {
  const event({Key? key}) : super(key: key);

  @override
  _eventState createState() => _eventState();
}

class _eventState extends State<event> {
  Widget buildEventCard(
    int cbak,
    int calnow,
    String? urlgambar,
    String? judul,
    String? juduldeskripsi1,
    String? juduldeskripsi2,
    String? deskripsi,
    String? deskripsi2,
    int? dbak,
    String? mbak,
    int? ybak,
    String penyelenggara,
    String slider,
  ) =>
      Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: (calnow <= cbak)
            ? Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Ink.image(
                        image: NetworkImage('$urlgambar'),
                        height: 120,
                        width: 240,
                        fit: BoxFit.fitWidth,
                        child: InkWell(onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12,
                                        bottom: 12,
                                        left: 12,
                                        right: 12),
                                    child: ListView(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(.2),
                                                  )
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8,
                                                    bottom: 8,
                                                    left: 12,
                                                    right: 12),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Tanggal Kegiatan : ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                        Text(
                                                          dbak.toString() +
                                                              ' ' +
                                                              mbak.toString() +
                                                              ' ' +
                                                              ybak.toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(.2),
                                                  )
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 12,
                                                    right: 12),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      '$juduldeskripsi1',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      juduldeskripsi2!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      deskripsi!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      deskripsi2!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(.2),
                                                  )
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 16,
                                                  right: 16,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Bekerja Sama dengan : ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        ElevatedButton(
                                                            style:
                                                                untukKonsultasiButton,
                                                            onPressed: () {},
                                                            child: Text(
                                                                penyelenggara))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Builder(
                                          builder: (context) {
                                            final GlobalKey<SlideActionState>
                                                _key = GlobalKey();
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: SlideAction(
                                                outerColor:
                                                    Colors.teal.shade900,
                                                innerColor: Colors.white,
                                                key: _key,
                                                text: 'Ikuti ' + slider,
                                                textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                                onSubmit: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RekamMedis(
                                                                  'sekmit')));
                                                  Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () => _key.currentState
                                                        ?.reset(),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
      );

  Widget buildComingSoonCard2(
    int cbak,
    int calnow,
    String? urlgambar,
    String? judul,
    String? juduldeskripsi1,
    String? juduldeskripsi2,
    String? deskripsi,
    String? deskripsi2,
    int? dbak,
    String? mbak,
    int? ybak,
  ) =>
      Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: (calnow <= cbak)
            ? Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Ink.image(
                        image: NetworkImage('$urlgambar'),
                        height: 120,
                        width: 240,
                        fit: BoxFit.fitWidth,
                        child: InkWell(onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12,
                                        bottom: 12,
                                        left: 12,
                                        right: 12),
                                    child: ListView(
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(.2),
                                                  )
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 12,
                                                    right: 12),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      '$juduldeskripsi1',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      juduldeskripsi2!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      deskripsi!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      deskripsi2!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final GlobalKey<SlideActionState>
                                                _key = GlobalKey();
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: SlideAction(
                                                outerColor:
                                                    Colors.teal.shade900,
                                                innerColor: Colors.white,
                                                key: _key,
                                                text: 'Kembali',
                                                textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                                onSubmit: () {
                                                  Navigator.pop(context);
                                                  Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () => _key.currentState
                                                        ?.reset(),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
      );

  final ButtonStyle ButtonWarna = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Color(0xFF5d1a77),
    elevation: 10,
    minimumSize: Size(150, 48),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference tevent = firestore.collection('tanggal_event');

    int? dbak, mbak, ybak, cbak;
    String? mmbak;
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('event : ',
                      style: GoogleFonts.pathwayGothicOne(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                StreamBuilder<DocumentSnapshot>(
                  stream: tevent.doc('baksos').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      String? urlgambar;
                      urlgambar = data['imgurl'];
                      String? judul_event;
                      judul_event = data['judulevent'];
                      String? juduldeskripsi1;
                      juduldeskripsi1 = data['juduldeskripsi1'];
                      String? juduldeskripsi2;
                      juduldeskripsi2 = data['juduldeskripsi2'];
                      String? deskripsi;
                      deskripsi = data['deskripsi'];
                      String? deskripsi2;
                      deskripsi2 = data['deskripsi2'];
                      dbak = data['tanggal'];
                      mbak = data['bulan'];
                      ybak = data['tahun'];
                      String penyelenggara = data['penyelenggara'];
                      String slider = data['slider'];
                      cbak = 365 * ybak! + 30 * mbak! + dbak!;
                      DateTime NOW = DateTime.now();

                      int ynn, mnn, dnn;
                      ynn = NOW.year;
                      mnn = NOW.month;
                      dnn = NOW.day;
                      int calnow;
                      calnow = ynn * 365 + mnn * 30 + dnn;
                      if (mbak == 1) mmbak = 'Januari';
                      if (mbak == 2) mmbak = 'Februari';
                      if (mbak == 3) mmbak = 'Maret';
                      if (mbak == 4) mmbak = 'April';
                      if (mbak == 5) mmbak = 'Mei';
                      if (mbak == 6) mmbak = 'Juni';
                      if (mbak == 7) mmbak = 'Juli';
                      if (mbak == 8) mmbak = 'Agustus';
                      if (mbak == 9) mmbak = 'September';
                      if (mbak == 10) mmbak = 'Oktober';
                      if (mbak == 11) mmbak = 'November';
                      if (mbak == 12) mmbak = 'Desember';

                      return buildEventCard(
                          cbak!,
                          calnow,
                          urlgambar,
                          judul_event,
                          juduldeskripsi1,
                          juduldeskripsi2,
                          deskripsi,
                          deskripsi2,
                          dbak,
                          mmbak,
                          ybak,
                          penyelenggara,
                          slider);
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: tevent.doc('sekmit').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      String? urlgambar;
                      urlgambar = data['imgurl'];
                      String? judul_event;
                      judul_event = data['judulevent'];
                      String? juduldeskripsi1;
                      juduldeskripsi1 = data['juduldeskripsi1'];
                      String? juduldeskripsi2;
                      juduldeskripsi2 = data['juduldeskripsi2'];
                      String? deskripsi;
                      deskripsi = data['deskripsi'];
                      String? deskripsi2;
                      deskripsi2 = data['deskripsi2'];
                      dbak = data['tanggal'];
                      mbak = data['bulan'];
                      ybak = data['tahun'];
                      cbak = 365 * ybak! + 30 * mbak! + dbak!;
                      DateTime NOW = DateTime.now();
                      String penyelenggara = data['penyelenggara'];
                      String slider = data['slider'];

                      int ynn, mnn, dnn;
                      ynn = NOW.year;
                      mnn = NOW.month;
                      dnn = NOW.day;
                      int calnow;
                      calnow = ynn * 365 + mnn * 30 + dnn;
                      if (mbak == 1) mmbak = 'Januari';
                      if (mbak == 2) mmbak = 'Februari';
                      if (mbak == 3) mmbak = 'Maret';
                      if (mbak == 4) mmbak = 'April';
                      if (mbak == 5) mmbak = 'Mei';
                      if (mbak == 6) mmbak = 'Juni';
                      if (mbak == 7) mmbak = 'Juli';
                      if (mbak == 8) mmbak = 'Agustus';
                      if (mbak == 9) mmbak = 'September';
                      if (mbak == 10) mmbak = 'Oktober';
                      if (mbak == 11) mmbak = 'November';
                      if (mbak == 12) mmbak = 'Desember';

                      return buildEventCard(
                        cbak!,
                        calnow,
                        urlgambar,
                        judul_event,
                        juduldeskripsi1,
                        juduldeskripsi2,
                        deskripsi,
                        deskripsi2,
                        dbak,
                        mmbak,
                        ybak,
                        penyelenggara,
                        slider,
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: tevent.doc('comingsoon').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      String? urlgambar;
                      urlgambar = data['imgurl'];
                      String? judul_event;
                      judul_event = data['judulevent'];
                      String? juduldeskripsi1;
                      juduldeskripsi1 = data['juduldeskripsi1'];
                      String? juduldeskripsi2;
                      juduldeskripsi2 = data['juduldeskripsi2'];
                      String? deskripsi;
                      deskripsi = data['deskripsi'];
                      String? deskripsi2;
                      deskripsi2 = data['deskripsi2'];
                      dbak = data['tanggal'];
                      mbak = data['bulan'];
                      ybak = data['tahun'];
                      cbak = 365 * ybak! + 30 * mbak! + dbak!;
                      DateTime NOW = DateTime.now();

                      int ynn, mnn, dnn;
                      ynn = NOW.year;
                      mnn = NOW.month;
                      dnn = NOW.day;
                      int calnow;
                      calnow = ynn * 365 + mnn * 30 + dnn;
                      if (mbak == 1) mmbak = 'Januari';
                      if (mbak == 2) mmbak = 'Februari';
                      if (mbak == 3) mmbak = 'Maret';
                      if (mbak == 4) mmbak = 'April';
                      if (mbak == 5) mmbak = 'Mei';
                      if (mbak == 6) mmbak = 'Juni';
                      if (mbak == 7) mmbak = 'Juli';
                      if (mbak == 8) mmbak = 'Agustus';
                      if (mbak == 9) mmbak = 'September';
                      if (mbak == 10) mmbak = 'Oktober';
                      if (mbak == 11) mmbak = 'November';
                      if (mbak == 12) mmbak = 'Desember';

                      return buildComingSoonCard2(
                        cbak!,
                        calnow,
                        urlgambar,
                        judul_event,
                        juduldeskripsi1,
                        juduldeskripsi2,
                        deskripsi,
                        deskripsi2,
                        dbak,
                        mmbak,
                        ybak,
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ]),
            ),
          ],
        ));
  }
}
