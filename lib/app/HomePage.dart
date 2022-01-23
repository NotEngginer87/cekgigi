// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, non_constant_identifier_names

import 'package:cekgigi/app/blog/SelectBlog.dart';
import 'package:cekgigi/app/home/fav_blog.dart';
import 'package:cekgigi/app/home/infopasien.dart';
import 'package:cekgigi/app/home/keuntungan.dart';
import 'package:cekgigi/app/home/tab3/FAQ.dart';
import 'package:cekgigi/app/home/tombol2.dart';
import 'package:cekgigi/app/home/tab3/whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

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
                          Expanded(
                              child: Container(
                                  color: Colors.teal.shade900,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                    ),
                                    child: SelectBlog(),
                                  )))
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
