// ignore_for_file: non_constant_identifier_names

import 'package:cekgigi/app/home/EditProfil.dart';
import 'package:cekgigi/app/konsultasi/keterangan%20dokter/sisidokternya.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class RiwayatKonsultasi extends StatefulWidget {
  const RiwayatKonsultasi({Key? key}) : super(key: key);

  @override
  _RiwayatKonsultasiState createState() => _RiwayatKonsultasiState();
}

class _RiwayatKonsultasiState extends State<RiwayatKonsultasi> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference riwayatkonsultasi = firestore.collection('user');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user?.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Konsultasi'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal.shade900,
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: Container(
            color: Colors.teal.shade900,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              child:

              StreamBuilder<QuerySnapshot>(
                stream: riwayatkonsultasi
                    .doc(email)
                    .collection('riwayatkonsultasi')
                    .doc('datapasien')
                    .collection('datapasien')
                    .snapshots(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data.docs
                            .map<Widget>((e) => RiwayatCard(
                          e.data()['idpasien'],
                          e.data()['iddokter'],
                          e.data()['kegiatan'],
                        ))
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
              ),))

      ),
    );
  }

  Widget RiwayatCard(
    int idpasien,
    String iddokter,
    String kegiatan,
  ) =>
      StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('listpasien')
            .doc(idpasien.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            int id = data['Aid'];
            String nama = data['Anama'];
            String umur = data['Aumur'];

            return Center(
                child: Padding(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 12, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                  ),
                                  child: Text(
                                    '#' + id.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nama,
                                      style: GoogleFonts.poppins(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      umur + ' tahun',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DetailKasus(idpasien, iddokter, kegiatan);
                        },
                      ));
                    },
                  )
                ],
              ),
            ));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
}

class DetailKasus extends StatefulWidget {
  const DetailKasus(this.idpasien, this.iddokter, this.kegiatan, {Key? key})
      : super(key: key);
  final int idpasien;
  final String iddokter;
  final String kegiatan;

  @override
  _DetailKasusState createState() => _DetailKasusState();
}

class _DetailKasusState extends State<DetailKasus> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Konsultasi'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal.shade900,
      ),
      body: Column(
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
                child:
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
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
                              icon: LineIcons.book,
                              text: 'Data Pasien',
                            ),
                            GButton(
                              icon: LineIcons.image,
                              text: 'Keluhan',
                            ),
                            GButton(
                              icon: LineIcons.stethoscope,
                              text: 'Data Dokter',
                            ),
                          ],
                          selectedIndex: _selectedIndex,
                          onTabChange: (index) {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),)),


          (_selectedIndex == 0)
              ? Expanded(
                  child: ListView(
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('listpasien')
                          .doc(widget.idpasien.toString())
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          int id = data['Aid'];
                          String nama = data['Anama'];
                          String gender = data['Agender'];
                          String umur = data['Aumur'];
                          String alamat = data['Aalamat'];
                          String noHP = data['AnoHP'];

                          String agama = data['Bagama'];
                          String pekerjaan = data['Bpekerjaan'];
                          String statusperkawinan = data['Bstatusperkawinan'];
                          String suku = data['Bsuku'];

                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 12,
                                        bottom: 12),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('ID pasien : '),
                                            Text(id.toString()),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('nama : '),
                                            Text(nama),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Jenis Kelamin : '),
                                            Text(gender),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Umur : '),
                                            Text(umur),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              child: Text('Alamat : '),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              child: Text(
                                                alamat,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('No HP : '),
                                            Text(noHP),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 12,
                                        bottom: 12),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Pekerjaan : '),
                                            Text(pekerjaan),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Agama : '),
                                            Text(agama),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Status Perkawinan : '),
                                            Text(statusperkawinan),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Suku : '),
                                            Text(suku),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))
              : (_selectedIndex == 1)
                  ? Expanded(
                      child: ListView(
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('listpasien')
                              .doc(widget.idpasien.toString())
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;

                              String gambarkeluhan = data['Cgambarkeluhan'];
                              String keluhan = data['Ckeluhan'];

                              return Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Card(
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        elevation: 4,
                                        child: InkWell(
                                          child: Hero(
                                            tag: 'foto',
                                            child: Image(
                                              image:
                                                  NetworkImage(gambarkeluhan),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5 *
                                                  4 /
                                                  3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return LihatFoto(
                                                  foto: gambarkeluhan);
                                            }));
                                          },
                                        )),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 12,
                                            bottom: 12),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const SizedBox(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text('Keluhan : '),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            130,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(keluhan),
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ))
                  : Expanded(
                      child: ListView(
                      children: [
                        infodokternya(widget.iddokter),
                      ],
                    )),
        ],
      ),
    );
  }
}
