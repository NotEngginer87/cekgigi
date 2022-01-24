// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/DatabaseServices.dart';
import '../blog/tampilanblog.dart';

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
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          top: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('artikel populer : ',
                      style: GoogleFonts.pathwayGothicOne(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                ),
              ],
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
            )
          ],
        ));
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
                    height: MediaQuery.of(context).size.width * 0.36,
                    width: MediaQuery.of(context).size.width * 0.36,
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 2,
                        child: InkWell(
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width,
                                  child: Ink.image(
                                    image: NetworkImage(
                                      urlgambar1!,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          tampilanblog(id, bab, urlgambar1)));
                            }))),
              )
            : Container(),
      ],
    );
  }
}
