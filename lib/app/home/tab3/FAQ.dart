import 'package:cekgigi/api/DatabaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pasien = firestore.collection('user');
    CollectionReference faq = firestore.collection('FAQ');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user!.email;

    return Scaffold(
        appBar: AppBar(
          title: const Text('FAQ'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.teal.shade900,
        ),
        body: Container(
            color: Colors.teal.shade900,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                child: Expanded(
                  child: ListView(children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: faq.snapshots(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                              children: snapshot.data.docs
                                  .map<Widget>((e) => FAQCARD(
                                        e.data()['id'],
                                        e.data()['pertanyaan'],
                                        e.data()['jawaban'],
                                        e.data()['expand'],
                                      ))
                                  .toList());
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
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
                  ]),
                ))));
  }
}

class FAQCARD extends StatefulWidget {
  const FAQCARD(this.id, this.pertanyaan, this.jawaban, this.expand, {Key? key})
      : super(key: key);
  final int id;
  final String pertanyaan;
  final String jawaban;
  final bool expand;

  @override
  _FAQCARDState createState() => _FAQCARDState();
}

class _FAQCARDState extends State<FAQCARD> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user!.email;

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 4, bottom: 12, left: 12, right: 12),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .doc(email.toString())
                  .collection('FAQ')
                  .doc(widget.id.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  int id = data['id'];
                  bool expand = data['expand'];

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.pertanyaan),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  DatabaseServices.expandFAQ(
                                      widget.id, expand, email!);
                                });
                              },
                              icon: Icon(Icons.add)),
                        ],
                      ),
                      (expand) ? Text(widget.jawaban) : Container(),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
    );
  }
}
