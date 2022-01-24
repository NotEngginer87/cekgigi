// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, non_constant_identifier_names

import 'package:cekgigi/app/home/fav_blog.dart';
import 'package:cekgigi/app/home/infopasien.dart';
import 'package:cekgigi/app/home/keuntungan.dart';
import 'package:cekgigi/app/home/tab3/FAQ.dart';
import 'package:cekgigi/app/home/tombol2.dart';
import 'package:cekgigi/app/home/tab3/whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../api/DatabaseServices.dart';
import 'blog/BlogDepan.dart';
import 'home/event.dart';
import 'home/tab3/kontak.dart';
import 'home/tab3/tab3.dart';

class HalamanRumah extends StatefulWidget {
  const HalamanRumah({Key? key}) : super(key: key);

  @override
  _HalamanRumahState createState() => _HalamanRumahState();
}

class _HalamanRumahState extends State<HalamanRumah> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle Buttonstyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: Colors.white,

      minimumSize: Size(MediaQuery.of(context).size.width, 48),
      padding: EdgeInsets.symmetric(horizontal: 8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Container(
        color: Colors.grey.shade50,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: (_selectedIndex == 0)
                ? ListView(
                    children: [
                      infopasien(),
                      Container(
                        color: Colors.white,
                        height: 150,
                        child: Stack(
                          children: [
                            Container(
                              height: 75,
                              color: Colors.teal.shade900,
                            ),
                            tomboltombol(),
                          ],
                        ),
                      ),
                      event(),
                      FavBlog(),
                      keuntunganmenggunakanaplikasi(),
                      WhatsappSupport(),
                    ],
                  )
                : (_selectedIndex == 1)
                    ? ListView(
                        children: [
                          infopasien(),
                          Container(
                              color: Colors.teal.shade900,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                ),
                                child: SelectBlog2(),
                              ))
                        ],
                      )
                    : ListView(
                        children: [
                          infopasien(),
                          Container(
                              color: Colors.teal.shade900,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,

                                ),
                                child: Column(

                                  children: [
                                    Tab3(),

                                    Padding(
                                      padding: EdgeInsets.only(left: 16, right: 16),
                                      child: ElevatedButton(
                                          style: Buttonstyle,
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => FAQ()));
                                          }, child: Text('FAQ')),
                                    ),
                                    SizedBox(height: 12,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16, right: 16),
                                      child: ElevatedButton(
                                          style: Buttonstyle,
                                          onPressed: (){
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return kontak();
                                                });
                                          }, child: Text('kontak iDent')),
                                    ),

                                    SizedBox(height: 12,),
                                  ],
                                ),
                              ))
                        ],
                      )),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.book,
                    text: 'Blog',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profil',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}




class BlogPopulerCard extends StatelessWidget {
  final String? urlgambar1;
  final String? id;
  final bool posting;

  // ignore: prefer_const_constructors_in_immutables
  BlogPopulerCard(
      this.id,
      this.urlgambar1,
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

  const BlogCard(
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
                    style: GoogleFonts.pathwayGothicOne(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black),
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
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
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
      },
    );
  }
}
