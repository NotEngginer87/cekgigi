// ignore_for_file: file_names, camel_case_types

import 'package:cekgigi/app/konsultasi/keterangan%20dokter/sisidokternya.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:cekgigi/style.dart';

import '../../ChatDokter/Chat.dart';
import '../../api/DatabaseServices.dart';
import 'konfirmasipembayaran.dart';

class KeteranganDokter extends StatefulWidget {
  const KeteranganDokter(
    this.image,
    this.iddokter,
    this.idpasien,
    this.kegiatan, {
    Key? key,
  }) : super(key: key);
  final String image;
  final String iddokter;
  final int idpasien;
  final String kegiatan;
  @override
  _KeteranganDokterState createState() => _KeteranganDokterState();
}

class _KeteranganDokterState extends State<KeteranganDokter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokter Gigi'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade900,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.teal.shade900,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Expanded(
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
                  )),
            ),
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: SizedBox(
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            SizedBox(
                              height: 8,
                            ),
                            Icon(
                              Icons.chat,
                              size: 36,
                            ),
                            Text('Chat'),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        )),
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  onTap: () async {
                    _onButtonPressedchat();
                  },
                ),
                InkWell(
                  child: SizedBox(
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            SizedBox(
                              height: 8,
                            ),
                            Icon(
                              Icons.video_call,
                              size: 36,
                            ),
                            Text('Video Call'),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        )),
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  onTap: () {
                    _onButtonPressedslider();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final bool _running = true;
  Stream<String> _clock() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));
      DateTime _now = DateTime.now();
      // This will be displayed on the screen as current time
      yield "${_now.hour} : ${_now.minute} : ${_now.second}";
    }
  }

  late bool max = false;

  void _onButtonPressedslider() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user?.email;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 12, right: 12),
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(.2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 12, right: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tanggal konsultasi : ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                DateTime.now().day.toString() +
                                    ' / ' +
                                    DateTime.now().month.toString() +
                                    ' / ' +
                                    DateTime.now().year.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Pukul : ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                              StreamBuilder(
                                stream: _clock(),
                                builder: (context, AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  return Text(
                                    snapshot.data!,
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w800),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(.2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 12, left: 12, right: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Harga : ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Biaya konsultasi : ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Rp 20.000,00',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            'Diskon : ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Promo iDent : ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Rp 20.000,00',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 12,
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Grand Total : ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Rp 0,00',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(.2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Syarat dan Ketentuan : ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _onButtonPressedSyaratdanKetentuan();
                                  },
                                  style: untukKonsultasiButton,
                                  child: const Text('klik'))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final GlobalKey<SlideActionState> _key = GlobalKey();
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SlideAction(
                          innerColor: Colors.teal.shade900,
                          outerColor: Colors.white,
                          key: _key,
                          text: 'konsultasi',
                          onSubmit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => konfirmasipembayaran(
                                        imageurl: widget.image,
                                        idpasien: widget.idpasien,
                                        iddokter: widget.iddokter,
                                      )),
                            );

                            DatabaseServices
                                .masukkanpasienkedatabasedokterigigi(
                                    widget.iddokter,
                                    widget.idpasien,
                                    widget.kegiatan);
                            DatabaseServices
                                .masukkandatakonsultasikedoktergigikeriwayat(
                                    emaila!,
                                    widget.iddokter,
                                    widget.idpasien,
                                    widget.kegiatan);
                            Future.delayed(
                              const Duration(seconds: 1),
                              () => _key.currentState?.reset(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onButtonPressedchat() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user?.email;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 12, right: 12),
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(.2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 12, right: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tanggal konsultasi : ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                DateTime.now().day.toString() +
                                    ' / ' +
                                    DateTime.now().month.toString() +
                                    ' / ' +
                                    DateTime.now().year.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Pukul : ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                              StreamBuilder(
                                stream: _clock(),
                                builder: (context, AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  return Text(
                                    snapshot.data!,
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w800),
                                  );
                                },
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(.2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 12, left: 12, right: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Harga : ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Biaya konsultasi : ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Rp 20.000,00',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            'Diskon : ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Promo iDent : ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Rp 20.000,00',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 12,
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Grand Total : ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Rp 0,00',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(.2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Syarat dan Ketentuan : ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              ElevatedButton(
                                  style: untukKonsultasiButton,
                                  onPressed: () {
                                    _onButtonPressedSyaratdanKetentuan();
                                  },
                                  child: const Text('klik'))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final GlobalKey<SlideActionState> _key = GlobalKey();
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SlideAction(
                          innerColor: Colors.teal.shade900,
                          outerColor: Colors.white,
                          key: _key,
                          text: 'konsultasi',
                          onSubmit: () {
                            DatabaseServices.setcountchataccount(
                                emaila!, widget.iddokter);
                            DatabaseServices.setchatdokter(
                                emaila, widget.iddokter);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chat(
                                        widget.iddokter,
                                      )),
                            );

                            DatabaseServices
                                .masukkanpasienkedatabasedokterigigi(
                                    widget.iddokter,
                                    widget.idpasien,
                                    widget.kegiatan);
                            DatabaseServices
                                .masukkandatakonsultasikedoktergigikeriwayat(
                                    emaila,
                                    widget.iddokter,
                                    widget.idpasien,
                                    widget.kegiatan);
                            Future.delayed(
                              const Duration(seconds: 1),
                              () => _key.currentState?.reset(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onButtonPressedSyaratdanKetentuan() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(.2),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Syarat dan Ketentuan : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Column(
                          children: const [
                            Text(
                              '        Setelah mengisi formulir, Anda akan diarahkan ke tampilan video call untuk melakukan konsultasi secara langsung bersama dokter gigi. Jika anda memilih untuk keluar aplikasi atau kembali ke halaman sebelumnya, maka data tidak akan terekam, dan Anda diminta untuk mengisi form kembali',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                '        Kami sangat menjunjung tinggi kode etik dokter dan dokter gigi serta demi menjaga privasi pasien, konsultasi hanya akan bersifat dua arah, antara Anda dengan dokter gigi di dalam video call. ',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '        Kami selaku developer iDent menjamin jawaban Anda tidak akan terekam oleh pihak ketiga dan hanya akan disimpan oleh dokter gigi untuk kepentingan pelayanan medis yang akan diberikan.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          child: const Text('kembali'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class komentarnya extends StatelessWidget {
  const komentarnya(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');
    return StreamBuilder<QuerySnapshot>(
      stream: dokter.doc(iddokter).collection('komentar').snapshots(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Komentar terbaru',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        Column(
                            children: snapshot.data.docs
                                .map<Widget>((e) => KomentarCard(
                                      e.data()['nama'],
                                      e.data()['komentar'],
                                      e.data()['urlgambar'],
                                      e.data()['rate'],
                                    ))
                                .toList()),
                      ],
                    ),
                  ),
                ],
              ));
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class KomentarCard extends StatelessWidget {
  final String nama;
  final String komentar;
  final int rate;
  final String urlgambar;

  // ignore: prefer_const_constructors_in_immutables
  KomentarCard(
    this.nama,
    this.komentar,
    this.urlgambar,
    this.rate, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 24,
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 4,
                  child: Ink.image(
                    image: NetworkImage(
                      urlgambar,
                    ),
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        for (int i = 1; i <= rate; i++)
                          Icon(
                            LineIcons.starAlt,
                            size: 20,
                            color: Colors.yellow.shade800,
                          ),
                        for (int i = 1; i <= 5 - rate; i++)
                          Icon(
                            LineIcons.star,
                            size: 20,
                            color: Colors.yellow.shade800,
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 128,
                      child: Text(
                        nama,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 88,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 128,
                  child: Text(
                    komentar,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                )
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
