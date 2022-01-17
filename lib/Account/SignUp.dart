// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  late bool switchemail = false;
  late bool switchpassword = false;
  late bool switchconfirmpassword = false;

  late bool openpassword = false;
  late bool openpasswordconfirm = false;
  late bool acceptermandlicense = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          Column(
            children: [
              const Text('email'),
              CupertinoTextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('password'),
              Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: password,
                      keyboardType: TextInputType.text,
                      obscureText: (openpassword) ? true : false,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    flex: 8,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            openpassword = !openpassword;
                          });
                        },
                        icon: Icon((openpassword)
                            ? LineIcons.eye
                            : LineIcons.eyeSlash)),
                    flex: 1,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('konfirmasi password'),
              Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: confirmpassword,
                      keyboardType: TextInputType.text,
                      obscureText: (openpasswordconfirm) ? true : false,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    flex: 8,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            openpasswordconfirm = !openpasswordconfirm;
                          });
                        },
                        icon: Icon((openpasswordconfirm)
                            ? LineIcons.eye
                            : LineIcons.eyeSlash)),
                    flex: 1,
                  )
                ],
              ),
              (confirmpassword.text == password.text)
                  ? const Text('password sama', style: TextStyle(color: Colors.green))
                  : const Text('password tidak sama',
                      style: TextStyle(color: Colors.red))
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: acceptermandlicense,
                onChanged: (value) {
                  setState(() {
                    acceptermandlicense = value!;
                  });
                },
              ),
              const Text('saya menyetujui terms & license'),
            ],
          ),
        ]),
      )),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: MediaQuery.of(context).size.width ,
          height: 60,
          child: CupertinoButton(
            minSize: MediaQuery.of(context).size.width,
            color: Colors.green,
            onPressed: () {},
            child: const Text('SignUp'),
          ),
        )
      ),
    );
  }
}
