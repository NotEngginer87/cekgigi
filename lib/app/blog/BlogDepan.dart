// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, duplicate_ignore, avoid_unnecessary_containers

import 'package:cekgigi/app/blog/tampilanblog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/DatabaseServices.dart';

class SelectBlog2 extends StatefulWidget {
  const SelectBlog2({Key? key}) : super(key: key);

  @override
  _SelectBlog2State createState() => _SelectBlog2State();
}

class _SelectBlog2State extends State<SelectBlog2> {
  int? hitungterbaca = 0;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference blog = firestore.collection('blog');
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 12, 10, 2),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Artikel terpopuler : ',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    )),
              ),
              SizedBox(
                height: 8,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: blog
                    .orderBy('terbaca', descending: true)
                    .limit(5)
                    .snapshots(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: snapshot.data.docs
                              .map<Widget>((e) => BlogPopulerCard(
                            e.data()['id'],
                            e.data()['urlgambar1'],
                            e.data()['bab'],
                            e.data()['posting'],
                          ))
                              .toList()),
                    );
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
              ),
              SizedBox(
                height: 8,
              ),
              StreamBuilder(
                stream: blog.snapshots(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    hitungterbaca = 0;
                    final docs = snapshot.data.docs;
                    for (int i = 0; i <= 20; i++) {
                      final countblogterbaca = docs[i].data()!;
                      final int sayang = countblogterbaca['terbaca'];

                      hitungterbaca = (hitungterbaca! + sayang);
                    }

                    return Text(
                        'Total Artikel yang Sudah Dibaca Sebanyak : ' +
                            (hitungterbaca!).toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal, fontSize: 18));
                  }

                  return Text("loading");
                },
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Artikel terbaru : ',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    )),
              ),
              StreamBuilder(
                stream: blog.snapshots(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data.docs
                          .map<Widget>((e) => BlogCard(
                        e.data()['id'],
                        e.data()['bab'],
                        e.data()['judul'],
                        e.data()['penulis'],
                        e.data()['urlgambar1'],
                        e.data()['terbaca'],
                        e.data()['posting'],
                      ))
                          .toList(),
                    );
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BlogPopulerCard extends StatelessWidget {
  final String? urlgambar1;
  final String? bab;
  final String? id;
  final bool posting;

  // ignore: prefer_const_constructors_in_immutables
  BlogPopulerCard(
      this.id,
      this.urlgambar1,
      this.bab,
      this.posting, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (posting == true)
            ? Padding(
          padding: EdgeInsets.only(
            left: 2,
            right: 2,
          ),
          child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: InkWell(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width,
                            child: Ink.image(
                              image: NetworkImage(
                                '$urlgambar1',
                              ),
                              colorFilter: ColorFilter.mode(
                                  Colors.grey, BlendMode.softLight),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        DatabaseServices.terbacaBlog(id);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => tampilanblog(id,bab,urlgambar1)));
                      }))),
        )
            : Container(),
      ],
    );
  }
}

class BlogCard extends StatelessWidget {
  final String? bab;
  final String? judul;
  final String? penulis;
  final String? urlgambar1;
  final String? id;
  final int terbaca;
  final bool posting;

  BlogCard(
      this.id,
      this.bab,
      this.judul,
      this.penulis,
      this.urlgambar1,
      this.terbaca,
      this.posting, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          (posting == true)
              ? Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              top: 12,
              bottom: 12,
            ),
            child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  child: Ink.image(
                    image: NetworkImage(
                      '$urlgambar1',
                    ),
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                )),
          )
              : Container(),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    bab!,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    judul!,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'sudah terbaca : ' + terbaca.toString(),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        DatabaseServices.terbacaBlog(id);
        Navigator.push(context, MaterialPageRoute(builder: (context) => tampilanblog(id,bab,urlgambar1)));

      },
    );
  }
}

