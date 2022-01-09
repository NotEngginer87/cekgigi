// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference userdata = firestore.collection('user');
  static CollectionReference count = firestore.collection('count');
  static CollectionReference listpasiencount = firestore.collection('listpasiencount');
  static CollectionReference blog = firestore.collection('soal');

  static Future<void> updateakun(String? email, String nama, String gender, String? tanggal,
      String? bulan, String? tahun, String alamat, String nomorHP,String? imageUrl) async {
    await userdata.doc(email).set(
      {
        'email': email,
        'nama': nama,
        'gender': gender,
        'tanggal': tanggal,
        'bulan': bulan,
        'tahun': tahun,
        'alamat': alamat,
        'nomorhp': nomorHP,
        'imageurl' : imageUrl,
      },
    );
  }


  static Future<void> updatecountakun() async {

    await listpasiencount.doc('count').update(
      {
        'count': FieldValue.increment(1),
      },
    );
  }

  static Future<void> updatecountakunuser(int countt, String akungoogle) async {
    await userdata.doc(akungoogle).set(
      {
        'id': countt,
        'akungoogle': akungoogle,
      },
    );
  }

  static Future<void> updateData(
      String? documentId,
      String nama,
      String alamat,
      int? agama,
      String telepon,
      String pekerjaan,
      String suku,
      int? gender,
      String umur,
      String keluhan,
      String? gambar) async {
    await userdata.doc(documentId).set(
      {
        'nama': nama,
        'alamat': alamat,
        'agama': (agama == 1)
            ? 'Islam'
            : (agama == 2)
            ? 'Protestan'
            : (agama == 3)
            ? 'Katolik'
            : (agama == 4)
            ? 'Budha'
            : (agama == 5)
            ? 'Hindu'
            : ' ',
        'telepon': telepon,
        'pekerjaan': pekerjaan,
        'suku': suku,
        'gender': (gender == 1) ? 'Laki - Laki' : 'Perempuan',
        'umur': umur,
        'keluhan': keluhan,
        'urlgambar': gambar
      },
    );
  }

  static Future<void> terbacaBlog(String? id) async {
    await blog.doc(id).update(
      {
        'terbaca': int.tryParse('terbaca')! + 1,
      },
    );
  }

  static Future<void> kritikdansaran(String keluhan) async {
    await userdata.doc().set(
      {
        'keluhan': keluhan,
      },
    );
  }

  static Future<void> deleteuser(String id) async {
    await userdata.doc(id).delete();
  }
}
