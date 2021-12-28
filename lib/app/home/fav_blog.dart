import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/DatabaseServices.dart';

class FavBlog extends StatefulWidget {
  const FavBlog({Key? key}) : super(key: key);

  @override
  _FavBlogState createState() => _FavBlogState();
}

class _FavBlogState extends State<FavBlog> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference blog = firestore.collection('blog');
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20,top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('artikel populer : ',
                  style: GoogleFonts.pathwayGothicOne(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
            ),
            Container(
              child: StreamBuilder<QuerySnapshot>(
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
            )
          ],
        ));
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
      {this.onUpdate,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          (posting == true)
              ? Padding(
                  padding: EdgeInsets.only(
                    left: 2,
                    right: 2,
                  ),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.4,
                      width: MediaQuery.of(context).size.width * 0.4 ,
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
                              }))),
                )
              : Container(),
        ],
      ),
    );
  }
}
