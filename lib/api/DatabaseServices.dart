// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference userdata = firestore.collection('user');
  static CollectionReference userdataTO = firestore.collection('user');
  static CollectionReference count = firestore.collection('count');
  static CollectionReference blog = firestore.collection('soal');

  static Future<void> updateakun(String? email, String nama, String? tanggal,
      String? bulan, String? tahun, String alamat, String nomorHP) async {
    await userdata.doc(email).set(
      {
        'email': email,
        'nama': nama,
        'tanggal': tanggal,
        'bulan': bulan,
        'tahun': tahun,
        'alamat': alamat,
        'nomorhp': nomorHP,
      },
    );
  }

  static Future<void> updatepembelianTO(
      String akungoogle, String namaTO, String jenis, int id) async {
    await userdataTO
        .doc(akungoogle)
        .collection('dataTO')
        .doc(id.toString())
        .set(
      {
        'namaTO': namaTO,
        'jenis': jenis,
        'id': id,
        'statuspembayaran': 'belum bayar',
      },
    );
  }

  static Future<void> updatepembelianTO2TFBANK(
      String akungoogle, int id, String metodepembayaran, String TFBANK) async {
    await userdataTO
        .doc(akungoogle)
        .collection('dataTO')
        .doc(id.toString())
        .update(
      {
        'id': id,
        'statuspembayaran': 'tunggu verifikasi',
        'metodepembayaran': metodepembayaran,
        'bukti1': TFBANK
      },
    );
  }

  static Future<void> initprogresspengerjaan(
    String akungoogle,
    String id,
  ) async {
    await userdataTO.doc(akungoogle).collection('dataTO').doc(id).update(
      {
        'progresspengerjaanPU': true,
        'progresspengerjaanPPU': false,
        'progresspengerjaanPBM': false,
        'progresspengerjaanPK': false,
        'progresspengerjaanINGG': false,
        'progresspengerjaanMTK': false,
        'progresspengerjaanFIS': false,
        'progresspengerjaanKIM': false,
        'progresspengerjaanBIO': false,
      },
    );
  }

  static Future<void> updateprogresspengerjaanPPU(
      String akungoogle, String id, bool progresspengerjaan) async {
    await userdataTO.doc(akungoogle).collection('dataTO').doc(id).update(
      {
        'progresspengerjaanPPU': !progresspengerjaan,
      },
    );
  }

  static Future<void> updateprogresspengerjaanPBM(
      String akungoogle, String id, bool progresspengerjaan) async {
    await userdataTO.doc(akungoogle).collection('dataTO').doc(id).update(
      {
        'progresspengerjaanPBM': !progresspengerjaan,
      },
    );
  }

  static Future<void> updateprogresspengerjaanPK(
      String akungoogle, String id, bool progresspengerjaan) async {
    await userdataTO.doc(akungoogle).collection('dataTO').doc(id).update(
      {
        'progresspengerjaanPK': !progresspengerjaan,
      },
    );
  }

  static Future<void> updateprogresspengerjaanINGG(
      String akungoogle, String id, bool progresspengerjaan) async {
    await userdataTO.doc(akungoogle).collection('dataTO').doc(id).update(
      {
        'progresspengerjaanINGG': !progresspengerjaan,
      },
    );
  }

  static Future<void> updateprogresspengerjaanMTK(
      String akungoogle, String id, bool progresspengerjaan) async {
    await userdataTO.doc(akungoogle).collection('dataTO').doc(id).update(
      {
        'progresspengerjaanMTK': !progresspengerjaan,
      },
    );
  }

  static Future<void> updateprogresspengerjaanFIS(
      String akungoogle, String id, bool progresspengerjaan) async {
    await userdataTO.doc(akungoogle).collection('dataTO').doc(id).update(
      {
        'progresspengerjaanFIS': !progresspengerjaan,
      },
    );
  }

  static Future<void> updateprogresspengerjaanKIM(
      String akungoogle, String id, bool progresspengerjaan) async {
    await userdataTO.doc(akungoogle).collection('dataTO').doc(id).update(
      {
        'progresspengerjaanKIM': !progresspengerjaan,
      },
    );
  }

  static Future<void> updateprogresspengerjaanBIO(
      String akungoogle, String id, bool progresspengerjaan) async {
    await userdataTO.doc(akungoogle).collection('dataTO').doc(id).update(
      {
        'progresspengerjaanBIO': !progresspengerjaan,
      },
    );
  }

  static Future<void> updatepembelianTO2TFGOPAY(
      String akungoogle, int id, String metodepembayaran, String GOPAY) async {
    await userdataTO
        .doc(akungoogle)
        .collection('dataTO')
        .doc(id.toString())
        .update(
      {
        'id': id,
        'statuspembayaran': 'tunggu verifikasi',
        'metodepembayaran': metodepembayaran,
        'bukti1': GOPAY,
      },
    );
  }

  static Future<void> updatepembelianTO2FREE(String akungoogle, int id,
      String metodepembayaran, String FREE1, String FREE2, String FREE3) async {
    await userdataTO
        .doc(akungoogle)
        .collection('dataTO')
        .doc(id.toString())
        .update(
      {
        'id': id,
        'statuspembayaran': 'tunggu verifikasi',
        'metodepembayaran': metodepembayaran,
        'bukti1': FREE1,
        'bukti2': FREE2,
        'bukti3': FREE3,
      },
    );
  }

  static Future<void> updatecountakun() async {
    await count.doc('hitung').update(
      {
        'banyakuser': int.tryParse('banyakuser')! + 1,
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
