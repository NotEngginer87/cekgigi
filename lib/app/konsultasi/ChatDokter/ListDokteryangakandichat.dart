
// ignore_for_file: file_names

import 'package:cekgigi/api/DatabaseServices.dart';
import 'package:cekgigi/app/konsultasi/ChatDokter/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: const Text('Chat',textAlign: TextAlign.center,),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal.shade900,
      ),
      body: Container(
        color: Colors.teal.shade900,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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

    CollectionReference pasien = firestore.collection('user');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user?.email;

    return StreamBuilder<DocumentSnapshot>(
      stream: dokter.doc(iddokter).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;

          String nama = data['nama'];
          String gelar = data['gelar'];
          String gambar = data['urlgambar'];
          String id = data['id'];

          return Container(
            color: Colors.grey.shade50,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Column(
                  children: [
                    const Divider(
                      height: 2,
                    ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text('Hapus Chat'),
                                              content: const Text(
                                                  'Yakin ingin menghapus chat anda ?'),
                                              actions: <Widget>[
                                                StreamBuilder<DocumentSnapshot>(
                                                  stream: pasien
                                                      .doc(email)
                                                      .collection('chat')
                                                      .doc(iddokter)
                                                      .snapshots(),
                                                  builder: (context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot.hasData) {
                                                      Map<String, dynamic>
                                                      data =
                                                      snapshot.data!.data()
                                                      as Map<String,
                                                          dynamic>;

                                                      int banyakchatpasien =
                                                      data['count'];

                                                      return StreamBuilder<
                                                          DocumentSnapshot>(
                                                        stream: dokter
                                                            .doc(iddokter)
                                                            .collection('chat')
                                                            .doc(email)
                                                            .snapshots(),
                                                        builder: (context,
                                                            AsyncSnapshot
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            Map<String, dynamic>
                                                            data = snapshot
                                                                .data!
                                                                .data()
                                                            as Map<
                                                                String,
                                                                dynamic>;

                                                            int banyakchatdokter =
                                                            data['count'];

                                                            return TextButton(
                                                              onPressed: () {
                                                                DatabaseServices
                                                                    .deletechatdokter(
                                                                    email!,
                                                                    id,
                                                                    banyakchatpasien,
                                                                    banyakchatdokter);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'ya'),
                                                            );
                                                          }
                                                          return const Center(
                                                            child:
                                                            CircularProgressIndicator(),
                                                          );
                                                        },
                                                      );
                                                    }
                                                    return const Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    );
                                                  },
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('tidak'),
                                                ),
                                              ],
                                            ));
                                  },
                                  icon: const Icon(Icons.delete),
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
                                builder: (context) => Chat(iddokter)));
                      },
                    ),
                    const Divider(
                      height: 2,
                    ),
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

class LihatFoto extends StatelessWidget {
  const LihatFoto({
    Key? key,
    required this.foto,
  }) : super(key: key);
  final String? foto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: Hero(
            tag: 'fotochat',
            child: Container(
              child: (foto == null)
                  ? Image(
                image: const NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/foto_blog%2Fkosong.png?alt=media&token=652482ea-7fa4-451f-913a-912c83d3ebd1'),
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
              )
                  : Image(
                image: NetworkImage(foto!),
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            )));
  }
}
