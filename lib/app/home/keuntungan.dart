// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../story.dart';
import 'keuntungan/caramenggunakan.dart';

class keuntungancard extends StatelessWidget {
  const keuntungancard(this.judul, this.imgurl, this.deskripsi, {Key? key})
      : super(key: key);

  final String? judul;
  final String? imgurl;
  final String? deskripsi;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 10,
      child: SizedBox(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
              child: SizedBox(
                child: Text(
                  judul!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pathwayGothicOne(
                      fontWeight: FontWeight.w500, fontSize: 24),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              height: MediaQuery.of(context).size.width - 90,
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
            SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
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
          ],
        ),
      ),
    );
  }
}

class keuntunganmenggunakanaplikasi extends StatelessWidget {
  const keuntunganmenggunakanaplikasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference cardimg = firestore.collection('card');

    Widget buildkeuntunganCard(String? imgurl) => Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Ink.image(
                image: NetworkImage(
                  imgurl!,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const KeuntunganiDentStory();
                    }));
                  },
                ),
                height: 180,
                width: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        );
    Widget buildHelpCard(String? imgurl) => Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Ink.image(
                image: NetworkImage(
                  imgurl!,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const TutorialiDentStory();
                    }));
                  },
                ),
                height: 180,
                width: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        );

    return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('kenali iDent lebih dekat : ',
                  style: GoogleFonts.pathwayGothicOne(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
            ),
            Row(children: [
              StreamBuilder<DocumentSnapshot>(
                stream: cardimg.doc('keuntungan').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    var imgurl = data['imgurl'];

                    return buildkeuntunganCard(
                      imgurl,
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: cardimg.doc('cara').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    var imgurl = data['imgurl'];

                    return buildHelpCard(imgurl);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ])
          ],
        ));
  }
}

class kenapaharusmenggunakan extends StatelessWidget {
  const kenapaharusmenggunakan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference kenapaharus = firestore.collection('keuntungan');

    return Scaffold(
      appBar: AppBar(
          title: const Text('Cara Menggunakan iDent'),
          backgroundColor: const Color(0xFF5d1a77),
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white70,
              child: ListView(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child:Align(
                        alignment: Alignment.center,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 16, right: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(.15),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
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
                                          style: GoogleFonts.pathwayGothicOne(
                                              fontWeight: FontWeight.w500,
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
                            Align(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: kenapaharus.snapshots(),
                                builder: (_, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                        children: snapshot.data.docs
                                            .map<Widget>((e) =>
                                            menggunakancard(
                                                e.data()['imgurl'],
                                                e.data()['deskripsi']))
                                            .toList());
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                              alignment: Alignment.center,
                            ),

                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
