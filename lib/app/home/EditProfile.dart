// ignore_for_file: prefer_const_constructors, file_names, camel_case_types

import 'package:flutter/material.dart';
import 'tab3.dart';

class editprofil extends StatefulWidget {
  const editprofil({Key? key}) : super(key: key);

  @override
  _editprofilState createState() => _editprofilState();
}

class _editprofilState extends State<editprofil> {
  TextEditingController controllernama = TextEditingController();
  TextEditingController controllertelepon = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllernama = TextEditingController();
  }

  @override
  void dispose() {
    controllernama.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final ButtonStyle submit = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: const Color(0xFF5d1a77),
      elevation: 10,
      minimumSize: Size(MediaQuery.of(context).size.width, 48),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Ujian'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 4, 24, 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    TextField(
                      // nama
                      scrollPadding: EdgeInsets.all(20),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Nama Lengkap",
                          hintText: "Nama sesuai identitas",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),

                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                      controller: controllernama,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      // nama
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Nomor HP",
                        hintText: "08XXXXXXXXXX",
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                      controller: controllertelepon,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Tab3()));

                  },
                  child: Text('Submit'),
                  style: submit,
                )
              ],
            ),
          ),
        ));
  }
}
