// ignore_for_file: file_names, camel_case_types

import 'package:cekgigi/app/konsultasi/keterangan%20dokter/sisidokternya.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:slide_to_act/slide_to_act.dart';

class KeteranganDokter extends StatefulWidget {
  const KeteranganDokter(this.image,
      this.iddokter,this.idpasien,{

    Key? key,
  }) : super(key: key);
  final String image;
final String iddokter;
final int idpasien;
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
                      const Duration(seconds: 1),
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
                        const SizedBox(
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
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class Sliderrr extends StatelessWidget {
  const Sliderrr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Builder(
              builder: (context) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
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
                        const Duration(seconds: 1),
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
                        const Duration(seconds: 1),
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
                        const Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    alignment: Alignment.centerRight,
                    child: const Text(
                      'Unlock',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    sliderButtonIcon: const Icon(Icons.lock),
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
                        const Duration(seconds: 1),
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
                        const Duration(seconds: 1),
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
                        const Duration(seconds: 1),
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
                        const Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    borderRadius: 16,
                    animationDuration: const Duration(seconds: 1),
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
                        const Duration(seconds: 1),
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
                        const Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                    submittedIcon: const Icon(
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
                        const Duration(seconds: 1),
                        () => _key.currentState?.reset(),
                      );
                    },
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
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
