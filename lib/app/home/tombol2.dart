// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cekgigi/app/konsultasi/ChatDokter/ListDokteryangakandichat.dart';
import 'package:cekgigi/app/konsultasi/rekammedis.dart';
import 'package:cekgigi/app/riwayatkonsultasi.dart';
import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';

class tomboltombol extends StatefulWidget {
  const tomboltombol({Key? key}) : super(key: key);

  @override
  _tomboltombolState createState() => _tomboltombolState();
}

class _tomboltombolState extends State<tomboltombol> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 26, right: 26, top: 20, bottom: 20),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                blurStyle: BlurStyle.outer,
              )
            ],
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(left: 2, right: 2, top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.teal.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            blurStyle: BlurStyle.outer,
                          )
                        ],
                      ),
                      width: 54,
                      height: 54,
                      child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RiwayatKonsultasi()),
                            );
                          },
                          icon: Icon(
                            LineIcons.medicalNotes,
                            size: 24,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('riwayat'),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.teal.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            blurStyle: BlurStyle.outer,
                          )
                        ],
                      ),
                      width: 54,
                      height: 54,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RekamMedis('konsultasibiasa')),
                            );
                          },
                          icon: Icon(
                            LineIcons.stethoscope,
                            size: 24,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('konsultasi'),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.teal.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            blurStyle: BlurStyle.outer,
                          )
                        ],
                      ),
                      width: 54,
                      height: 54,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMenu()));
                          },
                          icon: Icon(
                            Icons.message_rounded,
                            size: 24,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Chat Dokter'),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
