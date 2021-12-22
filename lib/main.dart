// ignore_for_file: prefer_const_constructors

import 'package:cekgigi/api/DatabaseServices.dart';
import 'package:cekgigi/app/home/tab3.dart';
import 'package:cekgigi/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'app/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  runApp(MaterialApp(
    home: MyApp(),
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ControllerAuth(),
    );
  }
}

class ControllerAuth extends StatelessWidget {
  const ControllerAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Registrasi();
          } else {
            return OnboardingScreen();
          }
        });
  }
}

class Registrasi extends StatefulWidget {
  const Registrasi({Key? key}) : super(key: key);

  @override
  _RegistrasiState createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {
  int currentstep = 1;

  TextEditingController nama = TextEditingController();
  TextEditingController noHP = TextEditingController();
  TextEditingController alamat = TextEditingController();
  String? tanggal, bulan, tahun;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user!.email;

    bool isCompleted = false;

    List<Step> getSteps() => [
          Step(
            state: currentstep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentstep >= 0,
            title: Text('Email'),
            content: Text(email!),
            subtitle: Text('isi alamat email kamu'),
          ),
          Step(
              state: currentstep > 1 ? StepState.complete : StepState.indexed,
              isActive: currentstep >= 1,
              title: Text('Nama'),
              content: TextFormField(
                controller: nama,
              ),
              subtitle: Text('nama lengkapmu')),
          Step(
              state: currentstep > 2 ? StepState.complete : StepState.indexed,
              isActive: currentstep >= 2,
              title: Text('Date'),
              content: DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }
                  tanggal = date.day.toString();
                  bulan = date.month.toString();
                  tahun = date.year.toString();
                  return true;
                },
                onChanged: (val) => print(val),
                validator: (val) {
                  print(val);

                  return null;
                },
                onSaved: (val) => print(val),
              )),
          Step(
            state: currentstep > 3 ? StepState.complete : StepState.indexed,
            isActive: currentstep >= 3,
            title: Text('Nomor HP'),
            content: TextFormField(
              controller: noHP,
              keyboardType: TextInputType.phone,
            ),
          ),
          Step(
              state: currentstep > 4 ? StepState.complete : StepState.indexed,
              isActive: currentstep >= 4,
              title: Text('Alamat'),
              content: TextFormField(
                controller: alamat,
                keyboardType: TextInputType.streetAddress,
              )),
        ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pendaftaran'),
      ),
      body: Stepper(
          type: StepperType.vertical,
          currentStep: currentstep,
          steps: getSteps(),
          onStepContinue: () {
            final isLastStep = currentstep == getSteps().length - 1;
            if (isLastStep) {
              isCompleted = true;
              print(isCompleted);
            } else {
              setState(() {
                currentstep += 1;
              });
            }
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
              margin: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  isLastStep
                      ? Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              DatabaseServices.updateakun(
                                  email,
                                  nama.text,
                                  tanggal,
                                  bulan,
                                  tahun,
                                  alamat.text,
                                  noHP.text);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HalamanRumah()),
                              );
                            },
                            child: Text('Konfirmasi'),
                          ),
                        )
                      : Expanded(
                          child: ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: Text('lanjut'),
                          ),
                        ),
                  SizedBox(
                    width: 20,
                  ),
                  if (currentstep != 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        child: Text('balik'),
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
