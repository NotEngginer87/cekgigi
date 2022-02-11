// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, unnecessary_null_comparison, deprecated_member_use

import 'package:cekgigi/api/DatabaseServices.dart';
import 'package:cekgigi/app/konsultasi/ChatDokter/ListDokteryangakandichat.dart';
import 'package:cekgigi/app/konsultasi/ChatDokter/infodokternya.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';
import 'package:path/path.dart';

class Chat extends StatefulWidget {
  const Chat(this.iddokter, {Key? key}) : super(key: key);

  final String iddokter;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool switchmengetik = false;

  bool opendialogbox = false;

  String? imageUrl;

  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = true;
  bool? isAudioMuted = false;
  bool? isVideoMuted = false;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dokter = firestore.collection('doktergigi');
    CollectionReference pasien = firestore.collection('user');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user?.email;
    TextEditingController ControllerChat = TextEditingController();
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: dokter.doc(widget.iddokter).snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                String nama = data['nama'];
                String gelar = data['gelar'];
                String gambar = data['urlgambar'];
                String username = data['username'];

                return StreamBuilder<DocumentSnapshot>(
                  stream: pasien.doc(email).snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      String namapasien = data['nama'];

                      return Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: InkWell(
                            child: Container(
                              color: Colors.teal.shade900,
                              height: 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          )),
                                      Card(
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        elevation: 4,
                                        child: Ink.image(
                                          image: NetworkImage(gambar),
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            nama,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            gelar,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          serverText.text = '';
                                          roomText.text = username + namapasien;
                                          subjectText.text = username;
                                          nameText.text = namapasien;
                                          emailText.text = email!;
                                          _joinMeeting();
                                        },
                                        icon: const Icon(LineIcons.video),
                                        color: Colors.white,
                                        iconSize: 24,
                                      ),
                                      const SizedBox(
                                        width: 18,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InfoDokternya(widget.iddokter)));
                            },
                          ));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Expanded(
              child: ListView(
            reverse: true,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: StreamBuilder<QuerySnapshot>(
                  stream: pasien
                      .doc(email)
                      .collection('chat')
                      .doc(widget.iddokter)
                      .collection('chat')
                      .orderBy('countchattime', descending: false)
                      .snapshots(),
                  builder: (_, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                              children: snapshot.data.docs
                                  .map<Widget>((e) => Balloonchat(
                                        e.data()['chat'],
                                        e.data()['id'],
                                        e.data()['countchattime'],
                                        e.data()['status'],
                                        e.data()['foto'],
                                      ))
                                  .toList()));
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Center(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          )),
          (opendialogbox == true)
              ? Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 1,
                                blurStyle: BlurStyle.outer,
                              )
                            ],
                          ),
                          width: MediaQuery.of(context).size.width - 40,
                          height: MediaQuery.of(context).size.width / 4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 2, right: 2, top: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 1,
                                              blurStyle: BlurStyle.outer,
                                            )
                                          ],
                                        ),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                9,
                                        child: StreamBuilder<DocumentSnapshot>(
                                          stream: pasien
                                              .doc(email)
                                              .collection('chat')
                                              .doc(widget.iddokter)
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              Map<String, dynamic> data =
                                                  snapshot.data!.data()
                                                      as Map<String, dynamic>;

                                              int count = data['count'];
                                              count += 5000000;
                                              int year = DateTime.now().year;
                                              int month = DateTime.now().month;
                                              int day = DateTime.now().day;
                                              int hour = DateTime.now().hour;
                                              int minutes =
                                                  DateTime.now().minute;
                                              int second =
                                                  DateTime.now().second;

                                              int countt = second +
                                                  minutes * 100 +
                                                  hour * 10000 +
                                                  day * 1000000 +
                                                  month * 100000000 +
                                                  year * 10000000000;

                                              return IconButton(
                                                  onPressed: () {
                                                    uploadImage(
                                                        email!, count, countt);
                                                  },
                                                  icon: const Icon(
                                                    LineIcons.camera,
                                                    size: 24,
                                                    color: Colors.black,
                                                  ));
                                            }
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        )),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('upload foto'),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 1,
                                            blurStyle: BlurStyle.outer,
                                          )
                                        ],
                                      ),
                                      height:
                                          MediaQuery.of(context).size.width / 9,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            LineIcons.calendarAlt,
                                            size: 24,
                                            color: Colors.black,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('Atur Jadwal'),
                                  ],
                                )),
                              ],
                            ),
                          ))),
                )
              : Container(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 12,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: Colors.white,
                    elevation: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  (opendialogbox == false)
                                      ? opendialogbox = true
                                      : opendialogbox = false;
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                              )),
                          flex: 1,
                        ),
                        Expanded(
                          child: CupertinoTextFormFieldRow(
                            controller: ControllerChat,
                            keyboardType: TextInputType.text,
                          ),
                          flex: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: pasien
                        .doc(email)
                        .collection('chat')
                        .doc(widget.iddokter)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        int count = data['count'];
                        count += 5000000;
                        int year = DateTime.now().year;
                        int month = DateTime.now().month;
                        int day = DateTime.now().day;
                        int hour = DateTime.now().hour;
                        int minutes = DateTime.now().minute;
                        int second = DateTime.now().second;

                        int countt = second +
                            minutes * 100 +
                            hour * 10000 +
                            day * 1000000 +
                            month * 100000000 +
                            year * 10000000000;

                        return Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 4,
                          color: Colors.teal.shade900,
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                if (ControllerChat.text != '') {
                                  DatabaseServices.updatechat(
                                      email!,
                                      widget.iddokter,
                                      count.toString(),
                                      ControllerChat.text,
                                      countt,
                                      'pasien',
                                      false);
                                  DatabaseServices.updatecountchataccount(
                                      email, widget.iddokter);
                                  DatabaseServices.updatechatdokter(
                                    email,
                                    widget.iddokter,
                                    count.toString(),
                                    ControllerChat.text,
                                    countt,
                                    'pasien',
                                    false,
                                  );
                                }
                                ControllerChat.text = '';
                              },
                              icon: const Icon(Icons.send)),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.CHAT_ENABLED: false,
      FeatureFlagEnum.CALENDAR_ENABLED: false,
      FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
      FeatureFlagEnum.INVITE_ENABLED: false,
      FeatureFlagEnum.IOS_RECORDING_ENABLED: false,
      FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      FeatureFlagEnum.PIP_ENABLED: false,
      FeatureFlagEnum.RAISE_HAND_ENABLED: false,
      FeatureFlagEnum.RECORDING_ENABLED: false,
      FeatureFlagEnum.TILE_VIEW_ENABLED: false,
      FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: false,
      FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
      FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED: false,
      FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room: roomText.text)
      ..serverURL = serverUrl
      ..subject = subjectText.text
      ..userDisplayName = nameText.text
      ..userEmail = emailText.text
      ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomText.text,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText.text}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  uploadImage(String email, int count, int countt) async {
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
      final destination = 'user/fotokonsultasi/chat/$fileName';

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
          DatabaseServices.updatechat(email, widget.iddokter, count.toString(),
              imageUrl!, countt, 'pasien', true);
          DatabaseServices.updatecountchataccount(email, widget.iddokter);

          DatabaseServices.updatechatdokter(email, widget.iddokter, count.toString(),
              imageUrl!, countt, 'pasien', true);
          DatabaseServices.updatecountchataccountdokter(email, widget.iddokter);
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}

class Balloonchat extends StatelessWidget {
  const Balloonchat(
      this.text, this.id, this.countchattime, this.status, this.foto,
      {Key? key})
      : super(key: key);
  final String text;
  final String id;
  final int countchattime;
  final String status;
  final bool foto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Align(
            alignment: (status == 'pasien')
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color:
                  (status == 'pasien') ? Colors.teal.shade900 : Colors.black87,
              child: (foto == true)
                  ? InkWell(
                      child: Hero(
                        tag: 'fotochat',
                        child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.5,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image(
                                image: NetworkImage(text),
                                height: MediaQuery.of(context).size.width,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LihatFoto(foto: text);
                        }));
                      },
                    )
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          text,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )),
            )));
  }
}
