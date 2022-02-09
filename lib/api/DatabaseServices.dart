// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference userdata = firestore.collection('user');
  static CollectionReference datapasien = firestore.collection('listpasien');
  static CollectionReference doktergigi = firestore.collection('doktergigi');
  static CollectionReference FAQ = firestore.collection('FAQ');
  static CollectionReference listpasiencount =
      firestore.collection('listpasiencount');
  static CollectionReference blog = firestore.collection('blog');

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

  static Future<void> setawaldatabookorder(String iddokter, bool senin, selasa,
      rabu, kamis, jumat, sabtu, minggu) async {
    await doktergigi.doc(iddokter).collection('booking').doc('ketentuan').set(
      {
        'senin': senin,
        'selasa': selasa,
        'rabu': rabu,
        'kamis': kamis,
        'jumat': jumat,
        'sabtu': sabtu,
        'minggu': minggu,
      },
    );
    await doktergigi
        .doc(iddokter)
        .collection('booking')
        .doc('ketentuan')
        .collection('senin')
        .doc('waktu')
        .set(
      {
        '1': '08.00',
        '2': '10.00',
        '3': '13.00',
      },
    );
    await doktergigi
        .doc(iddokter)
        .collection('booking')
        .doc('ketentuan')
        .collection('selasa')
        .doc('waktu')
        .set(
      {
        '1': '08.00',
        '2': '10.00',
        '3': '13.00',
      },
    );
    await doktergigi
        .doc(iddokter)
        .collection('booking')
        .doc('ketentuan')
        .collection('rabu')
        .doc('waktu')
        .set(
      {
        '1': '08.00',
        '2': '10.00',
        '3': '13.00',
      },
    );
    await doktergigi
        .doc(iddokter)
        .collection('booking')
        .doc('ketentuan')
        .collection('kamis')
        .doc('waktu')
        .set(
      {
        '1': '08.00',
        '2': '10.00',
        '3': '13.00',
      },
    );
    await doktergigi
        .doc(iddokter)
        .collection('booking')
        .doc('ketentuan')
        .collection('jumat')
        .doc('waktu')
        .set(
      {
        '1': '08.00',
        '2': '10.00',
        '3': '13.00',
      },
    );
    await doktergigi
        .doc(iddokter)
        .collection('booking')
        .doc('ketentuan')
        .collection('sabtu')
        .doc('waktu')
        .set(
      {
        '1': '08.00',
        '2': '10.00',
        '3': '13.00',
      },
    );
    await doktergigi
        .doc(iddokter)
        .collection('booking')
        .doc('ketentuan')
        .collection('minggu')
        .doc('waktu')
        .set(
      {
        '1': '08.00',
        '2': '10.00',
        '3': '13.00',
      },
    );
  }

  static Future<void> aturjadwalbooking(
    String iddokter,
    String hari,
    int sesi,
    tanda,
  ) async {
    await doktergigi
        .doc(iddokter)
        .collection('booking')
        .doc('ketentuan')
        .collection(hari)
        .doc('waktu')
        .update(
      {
        tanda: false,
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
      String chat, int countchattime, String status, bool foto) async {
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
        'foto': foto,
      },
    );
  }

  static Future<void> updatechatdokter(
      String email,
      String iddokter,
      String idchat,
      String chat,
      int countchattime,
      String status,
      bool foto) async {
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
        'foto': false,
      },
    );
  }

  static Future<void> setcountchataccount(
    String email,
    String iddokter,
    String idpasien,
  ) async {
    await userdata.doc(email).collection('chat').doc(iddokter).set(
      {
        'count': 1,
        'iddokter': iddokter,
        'requestvideocall': false,
        'idpasien': idpasien,
      },
    );
  }

  static Future<void> deletechatdokter(
    String email,
    String iddokter,
    int banyakchatdokter,
    int banyakchatpasien,
  ) async {
    for (int i = 1; i <= banyakchatpasien; i++) {
      int k = i + 5000000;
      await userdata
          .doc(email)
          .collection('chat')
          .doc(iddokter)
          .collection('chat')
          .doc(k.toString())
          .delete();
    }
    for (int i = 1; i <= banyakchatdokter; i++) {
      int k = i + 1000000;
      await doktergigi
          .doc(iddokter)
          .collection('chat')
          .doc(email)
          .collection('chat')
          .doc(k.toString())
          .delete();
    }
    await userdata.doc(email).collection('chat').doc(iddokter).delete();
  }

  static Future<void> setchatdokter(
    String email,
    String iddokter,
    String idpasien,
  ) async {
    await doktergigi.doc(iddokter).collection('chat').doc(email).set(
      {
        'count': 1,
        'iddokter': iddokter,
        'emailpasien': email,
        'idpasien': idpasien,
      },
    );
  }

  static Future<void> setFAQ(String email, int n) async {
    await userdata
        .doc(email.toString())
        .collection('FAQ')
        .doc(n.toString())
        .set(
      {
        'expand': false,
        'id': n,
      },
    );
  }

  static Future<void> expandFAQ(
    int id,
    bool expand,
    String email,
  ) async {
    await userdata
        .doc(email.toString())
        .collection('FAQ')
        .doc(id.toString())
        .update(
      {
        'expand': !expand,
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
        'terbaca': FieldValue.increment(1),
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
