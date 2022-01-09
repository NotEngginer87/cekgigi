// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_key_in_widget_constructors, camel_case_types


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonKonsultasi extends StatelessWidget {
  final String? nama;
  final String? namadokter;
  final String? id;
  final String channelName;
  final int waktuawal;
  final int waktuakhir;
  final String asal;
  final String urlgambar;


  final String namapasien;
  final String alamat;
  final int agama;
  final String telepon;
  final String pekerjaan;
  final String suku;
  final int gender;
  final String umur;
  final String keluhan;
  final String gambar;


  const ButtonKonsultasi(
      this.nama,
      this.id,
      this.namadokter,
      this.channelName,
      this.waktuawal,
      this.waktuakhir,
      this.asal,
      this.urlgambar,

      this.namapasien,
      this.alamat,
      this.agama,
      this.telepon,
      this.pekerjaan,
      this.suku,
      this.gender,
      this.umur,
      this.keluhan,
      this.gambar,
      );

  @override
  Widget build(BuildContext context) {
    final ButtonStyle untukKonsultasiButton = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: const Color(0xFF5d1a77),
      elevation: 10,
      minimumSize: Size(MediaQuery.of(context).size.width / 2 - 20, 48),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    if (nama == namadokter) {
      return ElevatedButton(
        style: untukKonsultasiButton,
        child: Row(children: [
          Text(
            'Konsultasi',
            style: GoogleFonts.pathwayGothicOne(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ]),
        onPressed: () async {



        },
      );
    } else {
      return Container();
    }
  }
}

class konfirmasipembayaran extends StatelessWidget {
  konfirmasipembayaran({Key? key,
    required this.iddokter,
    required this.idpasien,
    required this.imageurl
  }) : super(key: key);

  final String imageurl;
  final int idpasien;
  final String iddokter;


  final Stream<int> _bids = (() async* {
    for (int i = 1; i <= 100000000; i++) {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield 1;
    }
  })();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('data_dokter');

    final ButtonStyle untukKonsultasiButton = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: const Color(0xFF5d1a77),
      elevation: 10,
      minimumSize: Size(MediaQuery.of(context).size.width / 2 - 20, 48),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );

    int bulanke = DateTime.now().month;


    if (bulanke == 1) String namabulan = 'Januari';
    if (bulanke == 2) String namabulan = 'Februari';
    if (bulanke == 3) String namabulan = 'Maret';
    if (bulanke == 4) String namabulan = 'April';
    if (bulanke == 5) String namabulan = 'Mei';
    if (bulanke == 6) String namabulan = 'Juni';
    if (bulanke == 7) String namabulan = 'Juli';
    if (bulanke == 8) String namabulan = 'Agustus';
    if (bulanke == 9) String namabulan = 'September';
    if (bulanke == 10) String namabulan = 'Oktober';
    if (bulanke == 11) String namabulan = 'November';
    if (bulanke == 12) String namabulan = 'Desember';

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            color: const Color(0xFF5d1a77),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Konfirmasi pembayaran',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.pathwayGothicOne(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 28)),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFF5d1a77),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(10),
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Tanggal konsultasi : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Pukul : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  StreamBuilder(
                                      stream: _bids,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.hasData) {
                                          return Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                DateTime.now().hour.toString() +
                                                    ' : ' +
                                                    DateTime.now()
                                                        .minute
                                                        .toString() +
                                                    ' : ' +
                                                    DateTime.now()
                                                        .second
                                                        .toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
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
                              top: 8, bottom: 8, left: 12, right: 12),
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Biaya konsultasi : ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Rp 20.000,00',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'BAKSOSWIL FKG UNAND 2021 : ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Rp 20.000,00',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black,
                                height: 16,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Grand Total : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Rp 0,00',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
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
                              left: 16, right: 16, top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Syarat dan Ketentuan : ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Setelah mengisi formulir, Anda akan diarahkan ke tampilan video call untuk melakukan konsultasi secara langsung bersama dokter gigi. Jika anda memilih untuk keluar aplikasi atau kembali ke halaman sebelumnya, maka data tidak akan terekam, dan Anda diminta untuk mengisi form kembali',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Kami sangat menjunjung tinggi kode etik dokter dan dokter gigi serta demi menjaga privasi pasien, konsultasi hanya akan bersifat dua arah, antara Anda dengan dokter gigi di dalam video call. ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Kami selaku developer iDent menjamin jawaban Anda tidak akan terekam oleh pihak ketiga dan hanya akan disimpan oleh dokter gigi untuk kepentingan pelayanan medis yang akan diberikan.',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  )),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('bayar',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: Colors.black)),
                      Text('Rp 0,00',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black)),
                    ]),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

