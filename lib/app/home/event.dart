// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          int? ybak) =>
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
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                              top: 8,
                                              bottom: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 180,
                                                height: 48,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  dbak.toString() +
                                                      ' ' +
                                                      mbak.toString() +
                                                      ' ' +
                                                      ybak.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF5d1a77),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 4,
                                              bottom: 4),
                                          child: Card(
                                            color: Color(0xFF5d1a77),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '$juduldeskripsi1',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    juduldeskripsi2!,
                                                    style: TextStyle(
                                                        color: Colors.white,
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
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    deskripsi2!,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 4,
                                              bottom: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              (judul == 'BAKSOSWIL FKG UNAND')
                                                  ? ElevatedButton(
                                                      style: ButtonWarna,
                                                      onPressed: () {},
                                                      child: Text(
                                                          'Konsultasi Gratis'),
                                                    )
                                                  : (judul == 'SEKMIT 2021')
                                                      ? ElevatedButton(
                                                          style: ButtonWarna,
                                                          onPressed: () {},
                                                          child: Text(
                                                              'Ikuti sekmit'),
                                                        )
                                                      : ElevatedButton(
                                                          style: ButtonWarna,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text('Kembali'),
                                                        ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0,
                                        ),
                                      ]),
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
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('event : ',
                  style: GoogleFonts.pathwayGothicOne(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
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
                          ybak);
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
                          ybak);
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
