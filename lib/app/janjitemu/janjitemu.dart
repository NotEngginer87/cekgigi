// ignore_for_file: avoid_print, camel_case_types, use_key_in_widget_constructors


import 'package:cekgigi/app/konsultasi/KeteranganDokter.dart';
import 'package:cekgigi/app/konsultasi/keterangan%20dokter/sisidokternya.dart';
import 'package:cekgigi/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ListDokterJanjiTemu extends StatefulWidget {
  const ListDokterJanjiTemu({Key? key}) : super(key: key);

  @override
  _ListDokterJanjiTemuState createState() => _ListDokterJanjiTemuState();
}

class _ListDokterJanjiTemuState extends State<ListDokterJanjiTemu> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokter Gigi'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal.shade900,
      ),
      body: Container(
          color: Colors.grey.shade50,
          child: Container(
              color: Colors.teal.shade900,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    StreamBuilder(
                        stream:
                            dokter.orderBy('id', descending: false).snapshots(),
                        builder: (_, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Column(
                                  children: snapshot.data.docs
                                      .map<Widget>((e) => Column(
                                            children: [
                                              if (e.data()['indikatoronline'] ==
                                                  true)
                                                if (e.data()[
                                                        'indikatorhidup'] ==
                                                    true)
                                                  dokterCardlist(
                                                    e.data()['id'],
                                                    e.data()['nama'],
                                                    e.data()['nip'],
                                                    e.data()['gelar'],
                                                    e.data()['urlgambar'],
                                                    e.data()['asal'],
                                                    e.data()['pasien'],
                                                    e.data()['username'],
                                                    e.data()['password'],
                                                    e.data()['waktuawal'],
                                                    e.data()['waktuakhir'],
                                                    e.data()['rating'],
                                                    e.data()['indikatorhidup'],
                                                    e.data()['indikatoronline'],
                                                  ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ],
                ),
              ))),
    );
  }
}

class dokterCardlist extends StatelessWidget {
  final String? id;
  final String? nama;
  final String? nip;
  final String? gelar;
  final String? urlgambar;
  final String? asal;
  final int pasien;
  final String? username;
  final String? password;
  final String? waktuawal;
  final String? waktuakhir;
  final int rating;
  final bool indikatorhidup;
  final bool indikatoronline;

  const dokterCardlist(
    this.id,
    this.nama,
    this.nip,
    this.gelar,
    this.urlgambar,
    this.asal,
    this.pasien,
    this.username,
    this.password,
    this.waktuawal,
    this.waktuakhir,
    this.rating,
    this.indikatorhidup,
    this.indikatoronline,
  );

  @override
  Widget build(BuildContext context) {
    if ((indikatoronline == true) && (indikatorhidup == true)) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        child: Ink.image(
                          image: NetworkImage(
                            urlgambar!,
                          ),
                          height: 150,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 150,
                      width: 100,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 120) *
                                  0.8,
                              child: Text(nama!,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 120) *
                                  0.8,
                              child: Text(gelar!,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.grey)),
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 120) *
                                  0.8,
                              child: Text(asal!,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.grey)),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 4,
                                child: Container(
                                    color: Colors.greenAccent.shade100,
                                    width: 120,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            LineIcons.clock,
                                            size: 24,
                                            color: Colors.green.shade900,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                    waktuawal.toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color:
                                                          Colors.green.shade900,
                                                    )),
                                              ),
                                              Text(' - ',
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color:
                                                        Colors.green.shade900,
                                                  )),
                                              SizedBox(
                                                child: Text(
                                                    waktuakhir.toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color:
                                                          Colors.green.shade900,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 4,
                                child: Container(
                                    color: Colors.yellow.shade100,
                                    width: 52,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            LineIcons.star,
                                            size: 24,
                                            color: Colors.yellow.shade800,
                                          ),
                                          SizedBox(
                                            child: Text('5',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Colors.green.shade900,
                                                )),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfoDokternyajanjitemu(id!)));
                },
              ),
            )),
      );
    } else {
      return Container();
    }
  }
}

class Janjitemu extends StatefulWidget {
  const Janjitemu(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;

  @override
  _JanjitemuState createState() => _JanjitemuState();
}

class _JanjitemuState extends State<Janjitemu> {
  final DatePickerController _controller = DatePickerController();

  @override
  void initState() {
    super.initState();
  }

  int currentstep = 0;

  TextEditingController nama = TextEditingController();
  TextEditingController noHP = TextEditingController();
  TextEditingController umurcontrol = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController agama = TextEditingController();
  TextEditingController pekerjaan = TextEditingController();
  TextEditingController suku = TextEditingController();
  TextEditingController keluhan = TextEditingController();
  TextEditingController jeniskelamin = TextEditingController();

  late bool switchnama = false;
  late bool switchgender = false;
  late bool switchumur = false;
  late bool switchnotelepon = false;
  late bool switchalamat = false;
  late bool switchnikah = false;
  late bool switchagama = false;
  late bool switchpekerjaan = false;
  late bool switchsuku = false;
  late bool switchkeluhan = false;
  late bool switchfoto = false;
  late bool consent = false;

  String? tanggal, bulan, tahun;
  String? gender;

  String? genderr;

  int? umur;
  int? tanggalawal = 0, bulanawal = 0, tahunawal = 0;

  bool? switchimpor;

  bool isLastStep2 = false;
  int selectedvalue = 0;
  late String jam;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Dokter Gigi'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade900,
        elevation: 0,
      ),
      body: Theme(
        data: ThemeData(
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: Colors.teal.shade900)),
        child: Container(
            color: Colors.grey.shade50,
            child: Container(
                color: Colors.teal.shade900,
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      "Atur Tanggal",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                    ),
                                    //Text(_selectedValue.toString()),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: DatePicker(
                                        DateTime.now(),
                                        width: 60,
                                        height: 80,
                                        controller: _controller,
                                        initialSelectedDate: DateTime.now(),
                                        selectionColor: Colors.black,
                                        selectedTextColor: Colors.white,
                                        inactiveDates: const [],
                                        onDateChange: (date) {
                                          // New date selected
                                          setState(() {
                                            tanggal = date.day.toString();
                                            bulan = date.month.toString();
                                            tahun = date.year.toString();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      'Waktu',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              color: (selectedvalue == 1)
                                                  ? Colors.teal.shade900
                                                  : Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Text('08.00',
                                                    style: TextStyle(
                                                      color:
                                                          (selectedvalue == 1)
                                                              ? Colors.white
                                                              : Colors.grey,
                                                    )),
                                              )),
                                          onTap: () {
                                            setState(() {
                                              selectedvalue = 1;

                                              jam = '08.00';
                                            });
                                          },
                                        ),
                                        InkWell(
                                          child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              color: (selectedvalue == 2)
                                                  ? Colors.teal.shade900
                                                  : Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Text('10.00',
                                                    style: TextStyle(
                                                      color:
                                                          (selectedvalue == 2)
                                                              ? Colors.white
                                                              : Colors.grey,
                                                    )),
                                              )),
                                          onTap: () {
                                            setState(() {
                                              selectedvalue = 2;
                                              jam = '10.00';
                                            });
                                          },
                                        ),
                                        InkWell(
                                          child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              color: (selectedvalue == 3)
                                                  ? Colors.teal.shade900
                                                  : Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Text('12.00',
                                                    style: TextStyle(
                                                      color:
                                                          (selectedvalue == 3)
                                                              ? Colors.white
                                                              : Colors.grey,
                                                    )),
                                              )),
                                          onTap: () {
                                            setState(() {
                                              selectedvalue = 3;
                                              jam = '12.00';
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, bottom: 4, top: 4),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      child: InkWell(
                                        child: Card(
                                          color: Colors.teal.shade900,
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Booking dokter',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          print(tanggal! +  bulan.toString() + tahun.toString());
                                          print(jam);
                                        },
                                      ))),
                            ],
                          ),
                        ],
                      ),
                    )))),
      ),
    );
  }
}

class InfoDokternyajanjitemu extends StatefulWidget {
  const InfoDokternyajanjitemu(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;
  @override
  _InfoDokternyajanjitemuState createState() => _InfoDokternyajanjitemuState();
}

class _InfoDokternyajanjitemuState extends State<InfoDokternyajanjitemu> {
  late String tanggal, bulan, tahun;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('info dokter'),
        backgroundColor: Colors.teal.shade900,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.teal.shade900,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      infodokternya(widget.iddokter),
                      edukasidokternya(widget.iddokter),
                      klinikdokternya(widget.iddokter),
                      komentarnya(widget.iddokter),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, bottom: 4, top: 4),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: InkWell(
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              style: untukKonsultasiButton,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return Janjitemu(widget.iddokter);
                                }));
                              },
                              child: const Text('Atur Janji Temu'),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Janjitemu(widget.iddokter);
                            }));
                          },
                        ))),
              ],
            )),
      ),
    );
  }
}