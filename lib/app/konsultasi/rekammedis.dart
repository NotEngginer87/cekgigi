// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:cekgigi/app/konsultasi/pilihdokter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RekamMedis extends StatefulWidget {
  const RekamMedis({Key? key}) : super(key: key);

  @override
  _RekamMedisState createState() => _RekamMedisState();
}

class _RekamMedisState extends State<RekamMedis> {
  int currentstep = 0;

  TextEditingController nama = TextEditingController();
  TextEditingController noHP = TextEditingController();
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

  String? _valueagama = 'pilih';

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              'upload : $percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return const SizedBox(
              width: 0,
              height: 0,
            );
          }
        },
      );

  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userdata = firestore.collection('user');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user!.email;

    List<Step> getSteps() => [
          Step(
            state: currentstep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentstep >= 0,
            title: const Text('Informasi Umum'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<DocumentSnapshot>(
                  stream: userdata.doc(emaila.toString()).snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      String datanama = data['nama'];
                      String datagender = data['gender'];
                      String? dataalamat = data['alamat'];
                      String? datanomorHP = data['nomorhp'];
                      String datatanggal = data['tanggal'];
                      String databulan = data['bulan'];
                      String datatahun = data['tahun'];

                      tanggalawal = int.tryParse(datatanggal);
                      bulanawal = int.tryParse(databulan);
                      tahunawal = int.tryParse(datatahun);

                      return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              nama.text = datanama;
                              noHP.text = datanomorHP!;
                              alamat.text = dataalamat!;
                              jeniskelamin.text = datagender;
                              tanggal = datatanggal;
                              bulan = databulan;
                              tahun = datatahun;
                              switchimpor = true;
                              switchnama = true;
                              switchumur = true;
                              switchnotelepon = true;
                              switchalamat = true;
                              switchgender = true;
                            });
                          },
                          child: const Text('impor dari profil'));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const Text(
                  'nama : ',
                  textAlign: TextAlign.left,
                ),
                TextFormField(
                  controller: nama,
                  onChanged: (value) {
                    setState(() {
                      switchnama = true;
                    });
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Jenis Kelamin : ',
                  textAlign: TextAlign.left,
                ),
                GenderPickerWithImage(
                  showOtherGender: false,
                  verticalAlignedText: true,

                  selectedGender: (jeniskelamin.text == 'Laki-Laki')
                      ? Gender.Male
                      : (jeniskelamin.text == 'Perempuan')
                          ? Gender.Female
                          : null,
                  selectedGenderTextStyle: const TextStyle(
                      color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
                  unSelectedGenderTextStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                  onChanged: (jeniskelamin) async {
                    switchgender = true;

                    setState(() {
                      if (jeniskelamin?.index == 0) {
                        genderr = 'Laki-Laki';
                      } else {
                        genderr = 'Perempuan';
                      }
                    });
                    print(jeniskelamin?.index);
                  },
                  equallyAligned: true,
                  animationDuration: const Duration(milliseconds: 300),
                  isCircular: true,
                  maleText: 'Laki-Laki',
                  femaleText: 'Perempuan',
                  // default : true,
                  opacityOfGradient: 0.4,
                  padding: const EdgeInsets.all(3),
                  size: 120, //default : 40
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Tanggal Lahir : ',
                  textAlign: TextAlign.left,
                ),
                DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'dd MMMM, yyyy',
                  firstDate: DateTime(1900),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Date',
                  selectableDayPredicate: (date) {
                    tanggal = date.day.toString();
                    bulan = date.month.toString();
                    tahun = date.year.toString();
                    umur = DateTime.now().year - int.parse(tahun!);
                    switchumur = true;
                    return true;
                  },
                  onChanged: (val) => print(val),
                  validator: (val) {
                    print(val);
                    if (switchimpor == true) {}
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Nomor HP : ',
                  textAlign: TextAlign.left,
                ),
                TextFormField(
                  controller: noHP,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      switchnotelepon = true;
                    });
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text('Alamat'),
                TextFormField(
                  controller: alamat,
                  keyboardType: TextInputType.streetAddress,
                  onChanged: (value) {
                    setState(() {
                      switchalamat = true;
                    });
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
            subtitle: const Text('isilah informasi berikut dengan jujur'),
          ),
          Step(
              state: currentstep > 1 ? StepState.complete : StepState.indexed,
              isActive: currentstep >= 1,
              title: const Text('Informasi Khusus'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Agama : ',
                    textAlign: TextAlign.left,
                  ),
                  DropdownButton(
                      value: _valueagama,
                      elevation: 10,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          child: Text("Pilih"),
                          value: 'pilih',
                        ),
                        DropdownMenuItem(
                          child: Text("Islam"),
                          value: 'Islam',
                        ),
                        DropdownMenuItem(
                          child: Text("Protestan"),
                          value: 'protestan',
                        ),
                        DropdownMenuItem(
                            child: Text("Katolik"), value: 'Katolik'),
                        DropdownMenuItem(
                            child: Text("Buddha"), value: 'Buddha'),
                        DropdownMenuItem(child: Text("Hindu"), value: 'Hindu'),
                        DropdownMenuItem(
                            child: Text("Konghucu"), value: 'Konghucu'),
                      ],
                      onChanged: (dynamic value) {
                        setState(() {
                          _valueagama = value;
                          switchagama = true;
                        });
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Suku : ',
                    textAlign: TextAlign.left,
                  ),
                  TextFormField(
                    controller: suku,
                    onChanged: (value) {
                      setState(() {
                        switchsuku = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Pekerjaan : ',
                    textAlign: TextAlign.left,
                  ),
                  TextFormField(
                    controller: pekerjaan,
                    onChanged: (value) {
                      setState(() {
                        switchpekerjaan = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
              subtitle: const Text('Isilah informasi berikut dengan jujur')),
          Step(
            state: currentstep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentstep >= 2,
            title: const Text('Alamat'),
            content: Column(
              children: <Widget>[
                const Text(
                  'Keluhan : ',
                  textAlign: TextAlign.left,
                ),
                TextFormField(
                  controller: keluhan,
                  keyboardType: TextInputType.streetAddress,
                  onChanged: (value) {
                    setState(() {
                      switchkeluhan = true;
                    });
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                (imageUrl != null)
                    ? Card(
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Ink.image(
                                  image: NetworkImage(imageUrl!),
                                  height: MediaQuery.of(context).size.width,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        width: MediaQuery.of(context).size.width - 100,
                        height: MediaQuery.of(context).size.width - 100,
                        child: InkWell(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 10, top: 32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Upload Foto',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    'Tap Here',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87),
                                  ),
                                ],
                              )),
                          onTap: () {
                            uploadImage();
                            switchfoto = true;
                          },
                        ),
                      ),
              ],
            ),
          ),
        ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekam Medis'),
      ),
      body: Stepper(
          type: StepperType.vertical,
          currentStep: currentstep,
          steps: getSteps(),
          onStepContinue: () {
            if (currentstep == 0) {
              if (switchnama == true) {
                if (switchgender == true) {
                  if (switchumur == true) {
                    if (switchnotelepon == true) {
                      if (switchalamat == true) {
                        setState(() {
                          currentstep = 1;
                        });
                      }
                    }
                  }
                }
              }
            }
            if (currentstep == 1) {
              if (switchagama == true) {
                if (switchpekerjaan == true) {
                  if (switchsuku == true) {
                    setState(() {
                      currentstep = 2;
                    });
                  }
                }
              }
            }
            if (currentstep == 2) {}
          },
          onStepTapped: (step) => setState(() {
                currentstep = step;
              }),
          onStepCancel: currentstep == 0
              ? null
              : () {
                  setState(() {
                    currentstep -= 1;
                  });
                },
          controlsBuilder: (context, details) {
            final isLastStep = currentstep == getSteps().length - 1;
            return Container(
              margin: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  isLastStep
                      ? Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectDokter(
                                          nama.text,
                                          alamat.text,
                                          agama.text,
                                          noHP.text,
                                          pekerjaan.text,
                                          suku.text,
                                          jeniskelamin.text,
                                          umur.toString(),
                                          keluhan.text,
                                          imageUrl,
                                        )),
                              );
                            },
                            child: const Text('Konfirmasi'),
                          ),
                        )
                      : Expanded(
                          child: ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: const Text('lanjut'),
                          ),
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  if (currentstep != 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        child: const Text('balik'),
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);

      var file = File(image!.path);

      final fileName = basename(file.path);
      final destination = 'user/fotokonsultasi/$fileName';

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child(destination)
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}

class AddUserCountCard extends StatelessWidget {
  final int? count;
  final Function? onUpdate;
  final String? documentId;
  final String nama;
  final String alamat;
  final String agama;
  final String telepon;
  final String pekerjaan;
  final String suku;
  final String gender;
  final String umur;
  final String keluhan;
  final String? gambar;

  AddUserCountCard(
      this.count,
      this.documentId,
      this.nama,
      this.alamat,
      this.agama,
      this.telepon,
      this.pekerjaan,
      this.suku,
      this.gender,
      this.umur,
      this.keluhan,
      this.gambar,
      {Key? key,
      this.onUpdate})
      : super(key: key);

  final ButtonStyle untukElevatedButtonSubmit = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: const Color(0xFF5d1a77),
    elevation: 10,
    minimumSize: const Size(100, 48),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
  final ButtonStyle sepertiRaisedButton = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: const Color(0xFF5d1a77),
    minimumSize: const Size(90, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: untukElevatedButtonSubmit,
      onPressed: () {
        if (onUpdate != null) onUpdate!();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'PERHATIAN!!!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            content: SizedBox(
              height: 240,
              child: Column(
                children: const [
                  Text(
                    'Setelah ini #sanak akan memilih dokter untuk konsultasi, Jika #sanak  keluar dari aplikasi, atau kembali ke halaman sebelumnya, maka data tidak akan terekam, dan #sanak diminta untuk mengisi form kembali data yang sudah diisikan hanya akan digunakan oleh dokter gigi.',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Kami selaku developer iDent menjamin data #sanak tidak akan terekam oleh pihak ketiga dan hanya akan disimpan oleh dokter gigi untuk kepentingan pelayanan medis yang akan diberikan',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: sepertiRaisedButton,
                onPressed: () {},
                child: const Text('Konsultasi'),
              )
            ],
          ),
        );
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Padding(
          padding: EdgeInsets.only(left: 0, right: 10),
          child: Icon(
            LineIcons.tooth,
            size: 24,
          ),
        ),
        Text(
          'Konsultasi',
          style: TextStyle(fontSize: 16),
        ),
      ]),
    );
  }
}
