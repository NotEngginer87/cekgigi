// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';

import 'KeteranganDokter.dart';

class dokterCard extends StatelessWidget {
  final String? id;
  final String? nama;
  final String? nip;
  final String? gelar;
  final String? urlgambar;
  final String? asal;
  final int pasien;
  final String? username;
  final String? password;
  final String? waktuawal;
  final String? waktuakhir;
  final int rating;
  final bool indikatorhidup;
  final bool indikatoronline;
  final int idpasien;
  final String kegiatan;

  const dokterCard(
      this.id,
      this.nama,
      this.nip,
      this.gelar,
      this.urlgambar,
      this.asal,
      this.pasien,
      this.username,
      this.password,
      this.waktuawal,
      this.waktuakhir,
      this.rating,
      this.indikatorhidup,
      this.indikatoronline,
      this.idpasien,
      this.kegiatan,);

  @override
  Widget build(BuildContext context) {
    if ((indikatoronline == true) && (indikatorhidup == true)) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        child: Ink.image(
                          image: NetworkImage(
                            urlgambar!,
                          ),
                          height: 150,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 150,
                      width: 100,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 120) *
                                  0.8,
                              child: Text(nama!,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 120) *
                                  0.8,
                              child: Text(gelar!,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.grey)),
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 120) *
                                  0.8,
                              child: Text(asal!,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.grey)),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color:
                                                          Colors.green.shade900,
                                                    )),
                                              ),
                                              Text(' - ',
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color:
                                                        Colors.green.shade900,
                                                  )),
                                              SizedBox(
                                                child: Text(
                                                    waktuakhir.toString(),
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
                                            child: Text('5',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Colors.green.shade900,
                                                )),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KeteranganDokter(
                              urlgambar!,
                              id!,
                              idpasien,
                          kegiatan,
                            )),
                  );
                },
              ),
            )),
      );
    } else {
      return Container();
    }
  }
}

class dokterShimerCard extends StatelessWidget {
  final String? id;
  final String? nama;
  final String? nip;
  final String? gelar;
  final String? urlgambar;
  final String? asal;
  final int pasien;
  final String? username;
  final String? password;
  final String? waktuawal;
  final String? waktuakhir;
  final int rating;
  final bool indikatorhidup;
  final bool indikatoronline;

  final String? namapasien;
  final String? alamat;
  final String? agama;
  final String? telepon;
  final String? pekerjaan;
  final String? suku;
  final String? gender;
  final String? umur;
  final String? keluhan;
  final String? gambar;

  //// Pointer to Update Function
  final Function? onUpdate;
  //// Pointer to Delete Function
  final Function? onDelete;

  const dokterShimerCard(
    this.id,
    this.nama,
    this.nip,
    this.gelar,
    this.urlgambar,
    this.asal,
    this.pasien,
    this.username,
    this.password,
    this.waktuawal,
    this.waktuakhir,
    this.rating,
    this.indikatorhidup,
    this.indikatoronline, {
    this.onUpdate,
    this.onDelete,
    this.namapasien,
    this.alamat,
    this.agama,
    this.telepon,
    this.pekerjaan,
    this.suku,
    this.gender,
    this.umur,
    this.keluhan,
    this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    if ((indikatoronline == true) && (indikatorhidup == true)) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        child: Shimmer.fromColors(
            child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 4,
                            child: Ink.image(
                              image: NetworkImage(
                                '$urlgambar',
                              ),
                              height: 150,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: 150,
                          width: 100,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: [
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          120) *
                                      0.8,
                                  child: Text(nama!,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.black)),
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          120) *
                                      0.8,
                                  child: Text(gelar!,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          120) *
                                      0.8,
                                  child: Text(asal!,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.grey)),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                                child: Text('5',
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
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () async {},
                  ),
                )),
            baseColor: Colors.red,
            highlightColor: Colors.yellow),
      );
    } else {
      return Container();
    }
  }
}

class SelectDokter extends StatelessWidget {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController urlgambarController = TextEditingController();

  final int idpasien;
  final String kegiatan;
  SelectDokter(
    this.idpasien,
    this.kegiatan,
  );

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('doktergigi');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Dokter Gigi'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    StreamBuilder(
                        stream:
                            users.orderBy('id', descending: false).snapshots(),
                        builder: (_, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Column(
                                  children: snapshot.data.docs
                                      .map<Widget>((e) => Column(
                                            children: [
                                              if (e.data()['indikatoronline'] ==
                                                  true)
                                                if (e.data()[
                                                        'indikatorhidup'] ==
                                                    true)
                                                  dokterCard(
                                                    e.data()['id'],
                                                    e.data()['nama'],
                                                    e.data()['nip'],
                                                    e.data()['gelar'],
                                                    e.data()['urlgambar'],
                                                    e.data()['asal'],
                                                    e.data()['pasien'],
                                                    e.data()['username'],
                                                    e.data()['password'],
                                                    e.data()['waktuawal'],
                                                    e.data()['waktuakhir'],
                                                    e.data()['rating'],
                                                    e.data()['indikatorhidup'],
                                                    e.data()['indikatoronline'],
                                                    idpasien,
                                                    kegiatan,
                                                  ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                          left: 16,
                                          right: 16),
                                      child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: const Text(
                                            'Jika tidak ada dokter yang bisa dipilih, tunggulah paling lama sekitar 20 menit lagi',
                                            style: TextStyle(fontSize: 16),
                                            textAlign: TextAlign.justify,
                                          )),
                                    )),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Column(
                                  children: snapshot.data.docs
                                      .map<Widget>((e) => Column(
                                            children: [
                                              if (e.data()['indikatoronline'] ==
                                                  true)
                                                if (e.data()[
                                                        'indikatorhidup'] ==
                                                    true)
                                                  dokterShimerCard(
                                                    e.data()['id'],
                                                    e.data()['nama'],
                                                    e.data()['nip'],
                                                    e.data()['gelar'],
                                                    e.data()['urlgambar'],
                                                    e.data()['asal'],
                                                    e.data()['pasien'],
                                                    e.data()['username'],
                                                    e.data()['password'],
                                                    e.data()['waktuawal'],
                                                    e.data()['waktuakhir'],
                                                    e.data()['rating'],
                                                    e.data()['indikatorhidup'],
                                                    e.data()['indikatoronline'],
                                                  ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                          left: 16,
                                          right: 16),
                                      child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: const Text(
                                            'Jika tidak ada dokter yang bisa dipilih, tunggulah paling lama sekitar 20 menit lagi',
                                            style: TextStyle(fontSize: 16),
                                            textAlign: TextAlign.justify,
                                          )),
                                    )),
                              ],
                            );
                          }
                        }),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
