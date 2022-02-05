// ignore_for_file: file_names

import 'package:cekgigi/api/AuthServices.dart';
import 'package:cekgigi/main.dart';
import 'package:flutter/material.dart';

class RegisEmailScreen extends StatefulWidget {
  const RegisEmailScreen({Key? key}) : super(key: key);

  @override
  _RegisEmailScreenState createState() => _RegisEmailScreenState();
}

class _RegisEmailScreenState extends State<RegisEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Login Menggunakan Akun Google mu'),
                  ElevatedButton(
                    child: const Text('signOut'),
                    onPressed: () {
                      AuthServices.signOut();
                    },
                  ),
                  ElevatedButton(
                    child: const Text('LOGIN'),
                    onPressed: () {
                      AuthServices.signInWithGoogle();
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const IsiData();
                  }));
                },
                child: const Text('Lanjut ke aplikasi'),
              ),
            ],
          ),
        ));
  }
}
