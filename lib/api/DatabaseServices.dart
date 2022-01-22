// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference userdata = firestore.collection('user');
  static CollectionReference datapasien = firestore.collection('listpasien');
  static CollectionReference doktergigi = firestore.collection('doktergigi');
  static CollectionReference listpasiencount =
  firestore.collection('listpasiencount');
  static CollectionReference blog = firestore.collection('soal');

  static Future<void> updateakun(
      String? email,
      String nama,
      String gender,
      String? tanggal,
      String? bulan,
      String? tahun,
      String alamat,
      String nomorHP,
      String? imageUrl) async {
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
        'imageurl': imageUrl,
      },
    );
  }

  static Future<void> updateketeranganpasien(
      int id,
      String nama,
      String gender,
      String umur,
      String noHP,
      String alamat,
      String statusperkawinan,
      String agama,
      String suku,
      String pekerjaan,
      String keluhan,
      String gambarkeluhan,
      String kegiatan,
      String email,
      ) async {
    await datapasien.doc(id.toString()).set(
      {
        'Aid': id,
        'Aemail': email,
        'Anama': nama,
        'Agender': gender,
        'Aumur': umur,
        'AnoHP': noHP,
        'Aalamat': alamat,
        'Bstatusperkawinan': statusperkawinan,
        'Bagama': agama,
        'Bsuku': suku,
        'Bpekerjaan': pekerjaan,
        'Ckeluhan': keluhan,
        'Cgambarkeluhan': gambarkeluhan,
        'Dkegiatan': kegiatan,
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

  static Future<void> masukkanpasienkedatabasedokterigigi(
      String iddokter, int idpasien, String kegiatan) async {
    await doktergigi
        .doc(iddokter)
        .collection('datapasien')
        .doc('datapasien')
        .collection(kegiatan)
        .doc(idpasien.toString())
        .set(
      {
        'kegiatan': kegiatan,
        'idpasien': idpasien,
      },
    );
  }

  static Future<void> masukkandatakonsultasikedoktergigikeriwayat(
      String email, String iddokter, int idpasien, String kegiatan) async {
    await userdata
        .doc(email)
        .collection('riwayatkonsultasi')
        .doc('datapasien')
        .collection('datapasien')
        .doc(idpasien.toString())
        .set(
      {
        'kegiatan': kegiatan,
        'iddokter': iddokter,
        'idpasien': idpasien,
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

  static Future<void> updatechat(String email, String iddokter, String idchat,
      String chat, int countchattime, String status) async {
    await userdata
        .doc(email)
        .collection('chat')
        .doc(iddokter)
        .collection('chat')
        .doc(idchat)
        .set(
      {
        'id': idchat,
        'chat': chat,
        'countchattime': countchattime,
        'status': status,
      },
    );
  }

  static Future<void> updatechatdokter(String email, String iddokter, String idchat,
      String chat, int countchattime, String status) async {
    await doktergigi
        .doc(iddokter)
        .collection('chat')
        .doc(email)
        .collection('chat')
        .doc(idchat)
        .set(
      {
        'id': idchat,
        'chat': chat,
        'countchattime': countchattime,
        'status': status,
      },
    );
  }

  static Future<void> setcountchataccount(
      String email,
      String iddokter,
      ) async {
    await userdata.doc(email).collection('chat').doc(iddokter).set(
      {
        'count': 1,
        'iddokter': iddokter,
        'requestvideocall' : false,
      },
    );
  }

  static Future<void> setchatdokter(
      String email,
      String iddokter,
      ) async {
    await doktergigi.doc(iddokter).collection('chat').doc(email).set(
      {
        'count': 1,
        'iddokter': iddokter,
      },
    );
  }

  static Future<void> updatecountchataccount(
      String email,
      String iddokter,
      ) async {
    await userdata.doc(email).collection('chat').doc(iddokter).update(
      {
        'count': FieldValue.increment(1),
      },
    );
  }
  static Future<void> updatecountchataccountdokter(
      String email,
      String iddokter,
      ) async {
    await doktergigi.doc(iddokter).collection('chat').doc(email).update(
      {
        'count': FieldValue.increment(1),
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
