
import 'package:cekgigi/app/konsultasi/ChatDokter/Chat.dart';
import 'package:cekgigi/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class JanjiTemuHome extends StatefulWidget {
  const JanjiTemuHome({Key? key}) : super(key: key);

  @override
  _JanjiTemuHomeState createState() => _JanjiTemuHomeState();
}

class _JanjiTemuHomeState extends State<JanjiTemuHome> {
  int _selectedIndex2 = 1;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pasien = firestore.collection('user');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user?.email;

    return Column(
      children: [
        Container(
            color: Colors.teal.shade900,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 12, bottom: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: Colors.black,
                    iconSize: 24,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    duration: const Duration(milliseconds: 400),
                    tabBackgroundColor: Colors.grey[100]!,
                    color: Colors.black,
                    tabs: const [
                      GButton(
                        icon: LineIcons.clockAlt,
                        text: 'Pending',
                      ),
                      GButton(
                        icon: LineIcons.check,
                        text: 'Aktif',
                      ),
                      GButton(
                        icon: LineIcons.doubleCheck,
                        text: 'Selesai',
                      ),
                    ],
                    selectedIndex: _selectedIndex2,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex2 = index;
                      });
                    },
                  ),
                ),
              ),
            )),
        (_selectedIndex2 == 0)
            ? ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height - 152,
                ),
                child: ListView(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: pasien
                          .doc(email)
                          .collection('booking')
                          .orderBy('waktubooking', descending: true)
                          .snapshots(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                              children: snapshot.data.docs
                                  .map<Widget>(
                                      (e) => (e.data()['status'] == 'pending')
                                          ? CekBookingDokter(
                                              e.data()['tahun'],
                                              e.data()['bulan'],
                                              e.data()['tanggal'],
                                              e.data()['namahari'],
                                              e.data()['iddokter'],
                                              e.data()['idbooking'],
                                              e.data()['status'],
                                              e.data()['emailpasien'],
                                              e.data()['sesi'],
                                              e.data()['waktubooking'],
                                            )
                                          : Container())
                                  .toList());
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
                    )
                  ],
                ))
            : (_selectedIndex2 == 1)
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height - 152,
                    ),
                    child: ListView(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: pasien
                              .doc(email)
                              .collection('booking')
                              .orderBy('waktubooking', descending: true)
                              .snapshots(),
                          builder: (_, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                  children: snapshot.data.docs
                                      .map<Widget>((e) => ((e
                                                      .data()['waktubooking'] >=
                                                  DateTime.now().year * 10000 +
                                                      DateTime.now().month *
                                                          100 +
                                                      DateTime.now().day) &&
                                              ((e.data()['status'] ==
                                                  'sukses')))
                                          ? CekBookingDokter(
                                              e.data()['tahun'],
                                              e.data()['bulan'],
                                              e.data()['tanggal'],
                                              e.data()['namahari'],
                                              e.data()['iddokter'],
                                              e.data()['idbooking'],
                                              e.data()['status'],
                                              e.data()['emailpasien'],
                                              e.data()['sesi'],
                                              e.data()['waktubooking'],
                                            )
                                          : Container())
                                      .toList());
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
                        )
                      ],
                    ))
                : ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height - 152,
                    ),
                    child: ListView(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: pasien
                              .doc(email)
                              .collection('booking')
                              .orderBy('waktubooking', descending: true)
                              .snapshots(),
                          builder: (_, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                  children: snapshot.data.docs
                                      .map<Widget>((e) => ((e
                                                      .data()['waktubooking'] <
                                                  DateTime.now().year * 10000 +
                                                      DateTime.now().month *
                                                          100 +
                                                      DateTime.now().day) &&
                                              ((e.data()['status'] ==
                                                  'sukses')))
                                          ? CekBookingDokter(
                                              e.data()['tahun'],
                                              e.data()['bulan'],
                                              e.data()['tanggal'],
                                              e.data()['namahari'],
                                              e.data()['iddokter'],
                                              e.data()['idbooking'],
                                              e.data()['status'],
                                              e.data()['emailpasien'],
                                              e.data()['sesi'],
                                              e.data()['waktubooking'],
                                            )
                                          : Container())
                                      .toList());
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
                        )
                      ],
                    ),
                  ),
      ],
    );
  }
}

class CekBookingDokter extends StatelessWidget {
  const CekBookingDokter(
      this.tahun,
      this.bulan,
      this.tanggal,
      this.namahari,
      this.iddokter,
      this.idbooking,
      this.status,
      this.emailpasien,
      this.sesi,
      this.waktubooking,
      {Key? key})
      : super(key: key);

  final int tahun, bulan, tanggal;
  final String namahari;
  final String emailpasien;
  final String iddokter;
  final int idbooking;
  final String status;
  final int sesi;
  final int waktubooking;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');

    return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 4, top: 4),
        child: Column(
          children: [
            Card(
                color: Colors.teal.shade900,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: StreamBuilder(
                        stream: dokter.doc(iddokter).snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            String nama = data['nama'];
                            String urlgambar = data['urlgambar'];
                            String gelar = data['gelar'];

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Card(
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Ink.image(
                                            image: NetworkImage(
                                              urlgambar,
                                            ),
                                            height: 80,
                                            width: 64,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              nama,
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              gelar,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        namahari +
                                            ' ' +
                                            tanggal.toString() +
                                            ' - ' +
                                            bulan.toString() +
                                            ' - ' +
                                            tahun.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w100),
                                      ),
                                      StreamBuilder(
                                        stream: dokter
                                            .doc(iddokter)
                                            .collection('booking')
                                            .doc('ketentuan')
                                            .collection(namahari)
                                            .doc('waktu')
                                            .snapshots(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            Map<String, dynamic> data =
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>;
                                            String jam = data[sesi.toString()];
                                            return Text(
                                              'pukul : ' + jam,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            );
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: (status == 'sukses')
                                        ? (DateTime.now().year == tahun)
                                            ? (DateTime.now().month == bulan)
                                                ? (DateTime.now().day ==
                                                        tanggal)
                                                    ? untukKonsultasiButton
                                                    : untukKonsultasiButtongrey
                                                : untukKonsultasiButtongrey
                                            : untukKonsultasiButtongrey
                                        : untukKonsultasiButtongrey,
                                    child: (status == 'pending')
                                        ? const Text('Pending')
                                        : (waktubooking <
                                                DateTime.now().year * 10000 +
                                                    DateTime.now().month * 100 +
                                                    DateTime.now().day)
                                            ? const Text('selesai')
                                            : const Text('chat dokternya'),
                                    onPressed: () {
                                      (status == 'sukses')
                                          ? (DateTime.now().year == tahun)
                                              ? (DateTime.now().month == bulan)
                                                  ? (DateTime.now().day ==
                                                          tanggal)
                                                      ? Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Chat(
                                                                      iddokter)))
                                                      : Container()
                                                  : Container()
                                              : Container()
                                          : (waktubooking <
                                                  DateTime.now().year * 10000 +
                                                      DateTime.now().month *
                                                          100 +
                                                      DateTime.now().day)
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Chat(iddokter)))
                                              : null;

                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
