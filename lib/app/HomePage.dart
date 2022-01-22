// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:cekgigi/app/blog/SelectBlog.dart';
import 'package:cekgigi/app/home/fav_blog.dart';
import 'package:cekgigi/app/home/infopasien.dart';
import 'package:cekgigi/app/home/keuntungan.dart';
import 'package:cekgigi/app/home/tombol2.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'home/event.dart';
import 'home/tab3.dart';

class HalamanRumah extends StatefulWidget {
  const HalamanRumah({Key? key}) : super(key: key);

  @override
  _HalamanRumahState createState() => _HalamanRumahState();
}

class _HalamanRumahState extends State<HalamanRumah> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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

                  ],
                )
              : (_selectedIndex == 1)
                  ? ListView(
                      children: [
                        infopasien(),
                        SelectBlog(),
                      ],
                    )
                  : ListView(
            children: [
              infopasien(),
              Tab3(),
            ],
          )
        ),
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
