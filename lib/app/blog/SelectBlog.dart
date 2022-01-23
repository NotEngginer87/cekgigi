// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, duplicate_ignore, avoid_unnecessary_containers

import 'package:cekgigi/app/blog/Blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/DatabaseServices.dart';

class SelectBlog extends StatefulWidget {
  const SelectBlog({Key? key}) : super(key: key);

  @override
  _SelectBlogState createState() => _SelectBlogState();
}

class _SelectBlogState extends State<SelectBlog> {
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
                    style: GoogleFonts.pathwayGothicOne(
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
                            e.data()['bab'],
                            e.data()['judul'],
                            e.data()['posting'],
                            e.data()['text1'],
                            e.data()['text2'],
                            e.data()['text3'],
                            e.data()['text4'],
                            e.data()['text5'],
                            e.data()['text6'],
                            e.data()['text7'],
                            e.data()['text8'],
                            e.data()['text9'],
                            e.data()['text10'],
                            e.data()['sumber1'],
                            e.data()['sumber2'],
                            e.data()['sumber3'],
                            e.data()['urlgambar1'],
                            e.data()['urlgambar2'],
                            e.data()['penulis'],
                            e.data()['id'],
                            onUpdate: () {
                              blog.doc(e.data()['id']).update(
                                  {'terbaca': e.data()['terbaca'] + 1});
                            },
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
              FutureBuilder(
                future: blog.get(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final docs = snapshot.data.docs;
                    for (int i = 0; i <= 20; i++) {
                      final countblogterbaca = docs[i].data()!;
                      final int sayang = countblogterbaca['terbaca'];

                      hitungterbaca = (hitungterbaca! + sayang);
                    }

                    return Text(
                        'Total Artikel yang Sudah Dibaca Sebanyak : ' +
                            (hitungterbaca!).truncate().toString(),
                        style: GoogleFonts.pathwayGothicOne(
                            fontWeight: FontWeight.normal, fontSize: 20));
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
                    style: GoogleFonts.pathwayGothicOne(
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
                        e.data()['bab'],
                        e.data()['judul'],
                        e.data()['posting'],
                        e.data()['text1'],
                        e.data()['text2'],
                        e.data()['text3'],
                        e.data()['text4'],
                        e.data()['text5'],
                        e.data()['text6'],
                        e.data()['text7'],
                        e.data()['text8'],
                        e.data()['text9'],
                        e.data()['text10'],
                        e.data()['sumber1'],
                        e.data()['sumber2'],
                        e.data()['sumber3'],
                        e.data()['urlgambar1'],
                        e.data()['urlgambar2'],
                        e.data()['penulis'],
                        e.data()['id'],
                        e.data()['terbaca'],
                        onUpdate: () {
                          blog.doc(e.data()['id']).update(
                              {'terbaca': e.data()['terbaca'] + 1});
                        },
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
  final String? bab;
  final String? judul;
  final String? penulis;
  final String? text1;
  final String? text2;
  final String? text3;
  final String? text4;
  final String? text5;
  final String? text6;
  final String? text7;
  final String? text8;
  final String? text9;
  final String? text10;
  final String? sumber1;
  final String? sumber2;
  final String? sumber3;
  final String? urlgambar1;
  final String? urlgambar2;
  final bool? posting;
  final String? id;

  //// Pointer to Update Function
  final Function? onUpdate;
  //// Pointer to Delete Function
  final Function? onDelete;

  // ignore: prefer_const_constructors_in_immutables
  BlogPopulerCard(
      this.bab,
      this.judul,
      this.posting,
      this.text1,
      this.text2,
      this.text3,
      this.text4,
      this.text5,
      this.text6,
      this.text7,
      this.text8,
      this.text9,
      this.text10,
      this.sumber1,
      this.sumber2,
      this.sumber3,
      this.urlgambar1,
      this.urlgambar2,
      this.penulis,
      this.id,
      {Key? key, this.onUpdate,
        this.onDelete}) : super(key: key);

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
                            child: Column(
                              children: [
                                Expanded(
                                  child: Ink.image(
                                    image: NetworkImage(
                                      '$urlgambar1',
                                    ),
                                    colorFilter: ColorFilter.mode(
                                        Colors.grey,
                                        BlendMode.softLight),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (onUpdate != null) onUpdate!();
                        DatabaseServices.terbacaBlog(id);
                        Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) {
                                return blogstl(
                                    bab: '$bab',
                                    judul: '$judul',
                                    text1: '$text1',
                                    text2: '$text2',
                                    text3: '$text3',
                                    text4: '$text4',
                                    text5: '$text5',
                                    text6: '$text6',
                                    text7: '$text7',
                                    text8: '$text8',
                                    text9: '$text9',
                                    text10: '$text10',
                                    sumber1: '$sumber1',
                                    sumber2: '$sumber2',
                                    sumber3: '$sumber3',
                                    urlgambar1: '$urlgambar1',
                                    urlgambar2: '$urlgambar2',
                                    penulis: '$penulis');
                              },
                            ));
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
  final String? text1;
  final String? text2;
  final String? text3;
  final String? text4;
  final String? text5;
  final String? text6;
  final String? text7;
  final String? text8;
  final String? text9;
  final String? text10;
  final String? sumber1;
  final String? sumber2;
  final String? sumber3;
  final String? urlgambar1;
  final String? urlgambar2;
  final bool? posting;
  final String? id;
  final int terbaca;

  //// Pointer to Update Function
  final Function? onUpdate;
  //// Pointer to Delete Function
  final Function? onDelete;

  BlogCard(
      this.bab,
      this.judul,
      this.posting,
      this.text1,
      this.text2,
      this.text3,
      this.text4,
      this.text5,
      this.text6,
      this.text7,
      this.text8,
      this.text9,
      this.text10,
      this.sumber1,
      this.sumber2,
      this.sumber3,
      this.urlgambar1,
      this.urlgambar2,
      this.penulis,
      this.id,
      this.terbaca,
      {Key? key, this.onUpdate,
        this.onDelete}) : super(key: key);

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
                  child: SizedBox(
                    child: Column(
                      children: [
                        Expanded(
                          child: Ink.image(

                            image: NetworkImage(
                              '$urlgambar1',
                            ),
                            height: 120,
                            width: 200,
                            fit: BoxFit.cover,

                          ),
                        ),
                      ],
                    ),
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
                    style: GoogleFonts.pathwayGothicOne(
                        fontWeight: FontWeight.w500, fontSize: 20,color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    judul!,
                    style: GoogleFonts.pathwayGothicOne(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'sudah terbaca : ' + terbaca.toString(),
                    style: GoogleFonts.pathwayGothicOne(
                        fontWeight: FontWeight.w500, fontSize: 16,color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: (){
        DatabaseServices.terbacaBlog(id);
        Navigator.push(context,
            MaterialPageRoute(
              builder: (context) {
                return blogstl(
                  bab: '$bab',
                  judul: '$judul',
                  text1: '$text1',
                  text2: '$text2',
                  text3: '$text3',
                  text4: '$text4',
                  text5: '$text5',
                  text6: '$text6',
                  text7: '$text7',
                  text8: '$text8',
                  text9: '$text9',
                  text10: '$text10',
                  sumber1: '$sumber1',
                  sumber2: '$sumber2',
                  sumber3: '$sumber3',
                  urlgambar1: '$urlgambar1',
                  urlgambar2: '$urlgambar2',
                  penulis: '$penulis',
                  terbaca: terbaca,

                );
              },
            ));
      },
    );
  }
}

class BlogCarda extends StatelessWidget {
  final String? bab;
  final String? judul;
  final String? penulis;
  final String? text1;
  final String? text2;
  final String? text3;
  final String? text4;
  final String? text5;
  final String? text6;
  final String? text7;
  final String? text8;
  final String? text9;
  final String? text10;
  final String? sumber1;
  final String? sumber2;
  final String? sumber3;
  final String? urlgambar1;
  final String? urlgambar2;
  final bool? posting;
  final String? id;

  //// Pointer to Update Function
  final Function? onUpdate;
  //// Pointer to Delete Function
  final Function? onDelete;

  BlogCarda(
      this.bab,
      this.judul,
      this.posting,
      this.text1,
      this.text2,
      this.text3,
      this.text4,
      this.text5,
      this.text6,
      this.text7,
      this.text8,
      this.text9,
      this.text10,
      this.sumber1,
      this.sumber2,
      this.sumber3,
      this.urlgambar1,
      this.urlgambar2,
      this.penulis,
      this.id,
      {Key? key, this.onUpdate,
        this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          (posting == true)
              ? Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width - 8,
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 10,
                    child: InkWell(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.3,
                                  height:
                                  MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Hero(
                                        tag: 'blog',
                                        child: Expanded(
                                          child: Ink.image(
                                            image: NetworkImage(
                                              '$urlgambar1',
                                            ),
                                            height: 120,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.6,
                                        child: Text(
                                          bab!,
                                          style: GoogleFonts
                                              .pathwayGothicOne(
                                              fontWeight:
                                              FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.6,
                                        child: Text(
                                          judul!,
                                          style: GoogleFonts
                                              .pathwayGothicOne(
                                              fontWeight:
                                              FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          if (onUpdate != null) onUpdate!();
                          DatabaseServices.terbacaBlog(id);
                        }))),
          )
              : Container(),
        ],
      ),
    );
  }
}