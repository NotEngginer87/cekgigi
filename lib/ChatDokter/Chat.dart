// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, unnecessary_null_comparison

import 'package:cekgigi/api/DatabaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';

import '../app/konsultasi/KeteranganDokter.dart';
import '../app/konsultasi/keterangan dokter/sisidokternya.dart';




import 'dart:io';
import 'package:path/path.dart';

import '../../api/DatabaseServices.dart';



class Chat extends StatefulWidget {
  const Chat(this.iddokter, {Key? key}) : super(key: key);

  final String iddokter;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool switchmengetik = false;

  bool opendialogbox = false;

  String? imageUrl;
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
                        color: Colors.teal.shade900,
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
                                    icon: const Icon(Icons.arrow_back,color: Colors.white,)),
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

                                const SizedBox(width: 18,),
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
            reverse: true,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: StreamBuilder<QuerySnapshot>(
                  stream: pasien
                      .doc(email)
                      .collection('chat')
                      .doc(widget.iddokter)
                      .collection('chat')
                      .orderBy('countchattime', descending: false)
                      .snapshots(),
                  builder: (_, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                              children: snapshot.data.docs
                                  .map<Widget>((e) => Balloonchat(
                                        e.data()['chat'],
                                        e.data()['id'],
                                        e.data()['countchattime'],
                                        e.data()['status'],
                                      ))
                                  .toList()));
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
          (opendialogbox == true)
              ? Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 1,
                                blurStyle: BlurStyle.outer,
                              )
                            ],
                          ),
                          width: MediaQuery.of(context).size.width - 40,
                          height: MediaQuery.of(context).size.width / 4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 2, right: 2, top: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 1,
                                            blurStyle: BlurStyle.outer,
                                          )
                                        ],
                                      ),
                                      height:
                                          MediaQuery.of(context).size.width / 9,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            LineIcons.stethoscope,
                                            size: 24,
                                            color: Colors.black,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('konsultasi'),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 1,
                                            blurStyle: BlurStyle.outer,
                                          )
                                        ],
                                      ),
                                      height:
                                          MediaQuery.of(context).size.width / 9,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            LineIcons.medicalNotes,
                                            size: 24,
                                            color: Colors.black,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('riwayat'),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 1,
                                            blurStyle: BlurStyle.outer,
                                          )
                                        ],
                                      ),
                                      height:
                                          MediaQuery.of(context).size.width / 9,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            LineIcons.calendarAlt,
                                            size: 24,
                                            color: Colors.black,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('Atur Jadwal'),
                                  ],
                                )),
                              ],
                            ),
                          ))),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          (opendialogbox == false)
                              ? opendialogbox = true
                              : opendialogbox = false;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                      )),
                  flex: 1,
                ),
                Expanded(
                  child: CupertinoTextFormFieldRow(
                    controller: ControllerChat,
                    keyboardType: TextInputType.text,
                  ),
                  flex: 8,
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
                        count += 5000000;
                        int year = DateTime.now().year;
                        int month = DateTime.now().month;
                        int day = DateTime.now().day;
                        int hour = DateTime.now().hour;
                        int minutes = DateTime.now().minute;
                        int second = DateTime.now().second;

                        int countt = second +
                            minutes * 100 +
                            hour * 10000 +
                            day * 1000000 +
                            month * 100000000 +
                            year * 10000000000;

                        return IconButton(
                            onPressed: () {
                              if (ControllerChat.text != '') {
                                DatabaseServices.updatechat(
                                  email!,
                                  widget.iddokter,
                                  count.toString(),
                                  ControllerChat.text,
                                  countt,
                                  'pasien',
                                );
                                DatabaseServices.updatecountchataccount(
                                    email, widget.iddokter);
                                DatabaseServices.updatechatdokter(
                                  email,
                                  widget.iddokter,
                                  count.toString(),
                                  ControllerChat.text,
                                  countt,
                                  'dokter',
                                );
                              }
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

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);

      var file = File(image!.path);

      final fileName = basename(file.path);
      final destination = 'user/fotokonsultasi/$fileName';

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child(destination)
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}

class Balloonchat extends StatelessWidget {
  const Balloonchat(this.text, this.id, this.countchattime, this.status,
      {Key? key})
      : super(key: key);
  final String text;
  final String id;
  final int countchattime;
  final String status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Align(
            alignment: (status == 'pasien')
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color:
                  (status == 'pasien') ? Colors.teal.shade900 : Colors.black87,
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )),
            )));
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
        backgroundColor: Colors.teal.shade900,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.teal.shade900,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
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
            ),),
      ),
    );
  }
}

class ChatMenu extends StatefulWidget {
  const ChatMenu({Key? key}) : super(key: key);

  @override
  _ChatMenuState createState() => _ChatMenuState();
}

class _ChatMenuState extends State<ChatMenu> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pasien = firestore.collection('user');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user?.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('chat'),
        backgroundColor: Colors.teal.shade900,
      ),
      body: Container(
        color: Colors.teal.shade900,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: pasien.doc(email).collection('chat').snapshots(),
                  builder: (_, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          children: snapshot.data.docs
                              .map<Widget>((e) => ListChat(
                            e.data()['iddokter'],
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
              ],
            ),
          )),
      ),


    );
  }
}

class ListChat extends StatelessWidget {
  const ListChat(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');
    return StreamBuilder<DocumentSnapshot>(
      stream: dokter.doc(iddokter).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          String nama = data['nama'];
          String gelar = data['gelar'];
          String gambar = data['urlgambar'];

          return Container(
            color: Colors.grey.shade50,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Column(
                  children: [

                    const Divider(height: 2,),
                    InkWell(
                      child: Container(
                        color: Colors.grey.shade50,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  elevation: 4,
                                  child: Ink.image(
                                    image: NetworkImage(gambar),
                                    height: 64,
                                    width: 64,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
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
                                          color: Colors.black),
                                    ),
                                    Text(
                                      gelar,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Chat(iddokter)));
                      },
                    ),
                    const Divider(height: 2,),
                  ],
                )),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
