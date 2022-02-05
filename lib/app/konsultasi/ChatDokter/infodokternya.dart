
import 'package:cekgigi/app/konsultasi/KeteranganDokter.dart';
import 'package:cekgigi/app/konsultasi/keterangan%20dokter/sisidokternya.dart';
import 'package:flutter/material.dart';


class InfoDokternya extends StatefulWidget {
  const InfoDokternya(this.iddokter, {Key? key}) : super(key: key);
  final String iddokter;
  @override
  _InfoDokternyaState createState() => _InfoDokternyaState();
}

class _InfoDokternyaState extends State<InfoDokternya> {
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
      ),
    );
  }
}
