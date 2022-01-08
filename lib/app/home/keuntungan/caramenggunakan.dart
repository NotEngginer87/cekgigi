// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class menggunakancard extends StatelessWidget {
  const menggunakancard(this.imgurl, this.deskripsi, {Key? key}) : super(key: key);

  final String? imgurl;
  final String? deskripsi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width) * 0.8,
          height: (MediaQuery.of(context).size.width) * 0.8,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [

                SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 4 - 60,
                  height: MediaQuery.of(context).size.width * 3 / 4 - 60,
                  child: Column(
                    children: [
                      Expanded(
                        child: Ink.image(
                          image: NetworkImage(imgurl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: SizedBox(
                        child: Text(
                          deskripsi!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}

class menggunakanaplikasi extends StatelessWidget {
  const menggunakanaplikasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference carakonsultasi = firestore.collection('carakonsultasi');
    CollectionReference carabacablog = firestore.collection('carabacablog');

    return Scaffold(
      appBar: AppBar(
          title: const Text('Cara Menggunakan iDent'),
          backgroundColor: const Color(0xFF5d1a77),
          centerTitle: true,
          titleTextStyle: GoogleFonts.pathwayGothicOne(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 24)
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFF5d1a77),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 16, right: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(.2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 16, right: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Colors.black.withOpacity(.15),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Center(
                                          child: Text(
                                            'Cara Menggunakan Layanan Konsultasi',
                                            textAlign: TextAlign.center,
                                            style:
                                            GoogleFonts.pathwayGothicOne(
                                                fontWeight:
                                                FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: carakonsultasi.snapshots(),
                                builder: (_, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                            children: snapshot.data.docs
                                                .map<Widget>((e) =>
                                                menggunakancard(
                                                    e.data()['imgurl'],
                                                    e.data()[
                                                    'deskripsi']))
                                                .toList()),
                                      ),
                                    );
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: const [
                                        Center(
                                          child: Center(
                                            child:
                                            CircularProgressIndicator(),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 16, right: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(.2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 16, right: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Colors.black.withOpacity(.15),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Center(
                                          child: Text(
                                            'Cara Membaca Artikel iDent',
                                            textAlign: TextAlign.center,
                                            style:
                                            GoogleFonts.pathwayGothicOne(
                                                fontWeight:
                                                FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: carabacablog.snapshots(),
                                builder: (_, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                            children: snapshot.data.docs
                                                .map<Widget>((e) =>
                                                menggunakancard(
                                                    e.data()['imgurl'],
                                                    e.data()[
                                                    'deskripsi']))
                                                .toList()),
                                      ),
                                    );
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: const [
                                        Center(
                                          child: Center(
                                            child:
                                            CircularProgressIndicator(),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
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