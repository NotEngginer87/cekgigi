// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class blogstl extends StatefulWidget {
  blogstl({
    Key? key,
    this.bab,
    this.judul,
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
    this.terbaca,
  }) : super(key: key);
  final String? bab;
  final String? judul;
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
  final String? penulis;
  final int? terbaca;

  @override
  _blogstlState createState() => _blogstlState();
}

class _blogstlState extends State<blogstl> {
  int k1 = 0;
  int k2 = 0;
  int k3 = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.text1 != '') {
      k1 += 1;
    }
    if (widget.text2 != '') {
      k1 += 1;
    }
    if (widget.text3 != '') {
      k1 += 1;
    }
    if (widget.text4 != '') {
      k1 += 1;
    }
    if (widget.text5 != '') {
      k1 += 1;
    }
    if (widget.text6 != '') {
      k1 += 1;
    }
    if (widget.text7 != '') {
      k2 += 1;
    }
    if (widget.text8 != '') {
      k2 += 1;
    }
    if (widget.text9 != '') {
      k2 += 1;
    }
    if (widget.text10 != '') {
      k2 += 1;
    }
    if (widget.sumber1 != '') {
      k3 += 1;
    }
    if (widget.sumber2 != '') {
      k3 += 1;
    }
    if (widget.sumber3 != '') {
      k3 += 1;
    }

    return Scaffold(
      body: Hero(
        tag: 'blog',
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 24,
              ),
              stretchTriggerOffset: 200,
              foregroundColor: Colors.black,
              expandedHeight: MediaQuery.of(context).size.width,
              collapsedHeight: 56,
              floating: false,
              pinned: true,
              snap: false,
              elevation: 2,
              forceElevated: false,
              stretch: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  widget.bab!,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
                background: Image.network(
                  widget.urlgambar1!,
                  fit: BoxFit.fitWidth,
                ),
                collapseMode: CollapseMode.parallax,
                
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(_buildList()),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> listItems = [];

    listItems.add(Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.bab!,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.teal.shade900),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.judul!,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'sudah dibaca : ' + widget.terbaca.toString() + ' kali',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
          Divider(),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 8,
          ),
          (k1 > 0)
              ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    (widget.text1 != '')
                        ? Column(
                      children: [
                        Text(
                          widget.text1!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                        : Container(),
                    (widget.text2 != '')
                        ? Column(
                      children: [
                        Text(
                          widget.text2!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                        : Container(),
                    (widget.text3 != '')
                        ? Column(
                      children: [
                        Text(
                          widget.text3!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                        : Container(),
                    (widget.text4 != '')
                        ? Column(
                      children: [
                        Text(
                          widget.text4!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                        : Container(),
                    (widget.text5 != '')
                        ? Column(
                      children: [
                        Text(
                          widget.text5!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                        : Container(),
                    (widget.text6 != '')
                        ? Column(
                      children: [
                        Text(
                          widget.text6!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                        : Container(),
                  ],
                ),
              )
            ],
          )
              : Container(),
          SizedBox(
            height: 8,
          ),
          (widget.urlgambar2 != '')
              ? Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 10,
            child: Image.network(
              widget.urlgambar2!,
              height: MediaQuery.of(context).size.width - 60,
              width: MediaQuery.of(context).size.width - 20,
              fit: BoxFit.fitWidth,
            ),
          )
              : Container(),
          SizedBox(
            height: 10,
          ),
          (k2 > 0)
              ? Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    (widget.text7 != '')
                        ? Column(
                      children: [
                        Text(
                          widget.text7!,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                        : Container(),
                    (widget.text8 != '')
                        ? Column(
                      children: [
                        Text(
                          widget.text8!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                        : Container(),
                    (widget.text9 != '')
                        ? Column(
                      children: [
                        Text(
                          widget.text9!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                        : Container(),
                    (widget.text10 != '')
                        ? Column(
                      children: [
                        Text(
                          widget.text10!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                        : Container(),
                  ],
                ),
              )
            ],
          )
              : Container(),
          SizedBox(
            height: 8,
          ),
          (k3 > 0)
              ? Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'sumber :',
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                (widget.sumber1 != '')
                    ? Column(
                  children: [
                    Text(
                      widget.sumber1!,
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.teal.shade900),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                )
                    : Container(),
                (widget.sumber2 != '')
                    ? Column(
                  children: [
                    Text(
                      widget.sumber2!,
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.teal.shade900),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                )
                    : Container(),
                (widget.sumber3 != '')
                    ? Column(
                  children: [
                    Text(
                      widget.sumber3!,
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.teal.shade900),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                )
                    : Container(),
              ],
            ),
          )
              : Container(),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    ));

    return listItems;
  }
}