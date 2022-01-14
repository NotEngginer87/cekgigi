// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cekgigi/api/DatabaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../app/konsultasi/KeteranganDokter.dart';
import '../app/konsultasi/keterangan dokter/sisidokternya.dart';

class Chat extends StatefulWidget {
  const Chat(this.iduser, this.iddokter, {Key? key}) : super(key: key);

  final int iduser;
  final String iddokter;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool switchmengetik = false;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');
    CollectionReference pasien = firestore.collection('user');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user?.email;
    TextEditingController ControllerChat = TextEditingController();
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: dokter.doc(widget.iddokter).snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                String nama = data['nama'];
                String gelar = data['gelar'];
                String gambar = data['urlgambar'];

                return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: InkWell(
                      child: Container(
                        color: Colors.blue.shade500,
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back)),
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  elevation: 4,
                                  child: Ink.image(
                                    image: NetworkImage(gambar),
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nama,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      gelar,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(LineIcons.video),
                                  color: Colors.white,
                                  iconSize: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InfoDokternya(widget.iddokter)));
                      },
                    ));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Expanded(
              child: ListView(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: pasien
                      .doc(email)
                      .collection('chat')
                      .doc(widget.iddokter)
                      .collection('chat')
                      .orderBy('id', descending: false)
                      .snapshots(),
                  builder: (_, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: snapshot.data.docs
                              .map<Widget>((e) => Balloonchat(
                                    e.data()['chat'],
                                    e.data()['id'],
                                    e.data()['year'],
                                    e.data()['month'],
                                    e.data()['day'],
                                    e.data()['hour'],
                                    e.data()['minutes'],
                                    e.data()['second'],
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
                ),
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: ControllerChat,
                    keyboardType: TextInputType.text,
                  ),
                  flex: 9,
                ),
                Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: pasien
                        .doc(email)
                        .collection('chat')
                        .doc(widget.iddokter)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        int count = data['count'];
                        count += 1000000;
                        int year = DateTime.now().year;
                        int month = DateTime.now().month;
                        int day = DateTime.now().day;
                        int hour = DateTime.now().hour;
                        int minutes = DateTime.now().minute;
                        int second = DateTime.now().second;

                        return IconButton(
                            onPressed: () {
                              DatabaseServices.updatechat(
                                  email!,
                                  widget.iddokter,
                                  count.toString(),
                                  ControllerChat.text,
                                  year,
                                  month,
                                  day,
                                  hour,
                                  minutes,
                                  second);
                              DatabaseServices.updatecountchataccount(
                                  email, widget.iddokter);
                              ControllerChat.text = '';
                            },
                            icon: const Icon(Icons.send));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class Balloonchat extends StatelessWidget {
  const Balloonchat(this.text, this.id, this.year, this.month, this.day,
      this.hour, this.minutes, this.second,
      {Key? key})
      : super(key: key);
  final String text;
  final String id;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minutes;
  final int second;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(text),
          )),
    );
  }
}

class InfoDokternya extends StatefulWidget {
  const InfoDokternya(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;
  @override
  _InfoDokternyaState createState() => _InfoDokternyaState();
}

class _InfoDokternyaState extends State<InfoDokternya> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('info dokter'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                        infodokternya(widget.iddokter),
                        edukasidokternya(widget.iddokter),
                        klinikdokternya(widget.iddokter),
                        komentarnya(widget.iddokter),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
