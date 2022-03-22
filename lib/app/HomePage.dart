// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, non_constant_identifier_names, unused_element

import 'dart:io';

import 'package:cekgigi/app/home/fav_blog.dart';
import 'package:cekgigi/app/home/infopasien.dart';
import 'package:cekgigi/app/home/keuntungan.dart';
import 'package:cekgigi/app/home/tab3/FAQ.dart';
import 'package:cekgigi/app/home/tab3/tab3.dart';
import 'package:cekgigi/app/home/tombol2.dart';
import 'package:cekgigi/app/home/tab3/whatsapp.dart';
import 'package:cekgigi/penelitian/kuesioner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:line_icons/line_icons.dart';

import '../api/DatabaseServices.dart';
import 'blog/BlogDepan.dart';
import 'home/event.dart';
import 'home/tab3/kontak.dart';

class HalamanRumah extends StatefulWidget {
  const HalamanRumah({Key? key}) : super(key: key);

  @override
  _HalamanRumahState createState() => _HalamanRumahState();
}

class _HalamanRumahState extends State<HalamanRumah> {
  int _selectedIndex = 0;

  final serverText = TextEditingController();
  final roomText = TextEditingController();
  final subjectText = TextEditingController();
  final nameText = TextEditingController();
  final emailText = TextEditingController();
  final iosAppBarRGBAColor =
  TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = false;
  bool? isAudioMuted = false;
  bool? isVideoMuted = false;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle Buttonstyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: Colors.white,
      minimumSize: Size(MediaQuery.of(context).size.width, 48),
      padding: EdgeInsets.symmetric(horizontal: 8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Container(
        color: Colors.grey.shade50,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: (_selectedIndex == 0)
                ? ListView(
                    children: [
                      infopasien(),
                      Container(
                        color: Colors.white,
                        height: 150,
                        child: Stack(
                          children: [
                            Container(
                              height: 75,
                              color: Colors.teal.shade900,
                            ),
                            tomboltombol(),
                          ],
                        ),
                      ),
                      event(),
                      FavBlog(),
                      keuntunganmenggunakanaplikasi(),
                      WhatsappSupport(),
                    ],
                  )
                : (_selectedIndex == 1)
                    ? ListView(
              children: [
                infopasien(),
                Container(
                    color: Colors.teal.shade900,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                      ),
                      child: SelectBlog2(),
                    ))
              ],
            )
                    : (_selectedIndex == 2)
                        ? ListView(
              children: [
                infopasien(),
                Container(
                    color: Colors.teal.shade900,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                      ),
                      child: Column(
                        children: [
                          Tab3(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16),
                            child: ElevatedButton(
                                style: Buttonstyle,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FAQ()));
                                },
                                child: Text('FAQ')),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16),
                            child: ElevatedButton(
                                style: Buttonstyle,
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return kontak();
                                      });
                                },
                                child: Text('kontak iDent')),
                          ),
                          SizedBox(
                            height: 12,
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16),
                            child: ElevatedButton(
                                style: Buttonstyle,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      DataResponden()));
                                },
                                child: Text('Isi Kuesioner')),
                          ),
                          SizedBox(
                            height: 12,
                          ),

                        ],
                      ),
                    ))
              ],
            ): Container())
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  //GButton(
                  //  icon: LineIcons.stethoscope,
                  //  text: 'Dokter',
                  //),
                  GButton(
                    icon: LineIcons.book,
                    text: 'Blog',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profil',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: serverText,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Server URL",
                hintText: "Hint: Leave empty for meet.jitsi.si"),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: roomText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Room",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: subjectText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Subject",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: nameText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Display Name",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: emailText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: iosAppBarRGBAColor,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "AppBar Color(IOS only)",
                hintText: "Hint: This HAS to be in HEX RGBA format"),
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Audio Only"),
            value: isAudioOnly,
            onChanged: _onAudioOnlyChanged,
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Audio Muted"),
            value: isAudioMuted,
            onChanged: _onAudioMutedChanged,
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Video Muted"),
            value: isVideoMuted,
            onChanged: _onVideoMutedChanged,
          ),
          const Divider(
            height: 48.0,
            thickness: 2.0,
          ),
          SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                _joinMeeting();
              },
              child: const Text(
                "Join Meeting",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.blue)),
            ),
          ),
          const SizedBox(
            height: 48.0,
          ),
        ],
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
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



}

class BlogPopulerCard extends StatelessWidget {
  final String? urlgambar1;
  final String? id;
  final bool posting;

  // ignore: prefer_const_constructors_in_immutables
  BlogPopulerCard(
    this.id,
    this.urlgambar1,
    this.posting, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (posting == true)
            ? Padding(
                padding: EdgeInsets.only(
                  left: 2,
                  right: 2,
                ),
                child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.6,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: InkWell(
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width,
                                  child: Ink.image(
                                    image: NetworkImage(
                                      '$urlgambar1',
                                    ),
                                    colorFilter: ColorFilter.mode(
                                        Colors.grey, BlendMode.softLight),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              DatabaseServices.terbacaBlog(id);
                            }))),
              )
            : Container(),
      ],
    );
  }
}

class BlogCard extends StatelessWidget {
  final String? bab;
  final String? judul;
  final String? penulis;
  final String? urlgambar1;
  final String? id;
  final int terbaca;
  final bool posting;

  const BlogCard(
    this.id,
    this.bab,
    this.judul,
    this.penulis,
    this.urlgambar1,
    this.terbaca,
    this.posting, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          (posting == true)
              ? Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        child: Ink.image(
                          image: NetworkImage(
                            '$urlgambar1',
                          ),
                          height: 120,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      )),
                )
              : Container(),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    bab!,
                    style: GoogleFonts.pathwayGothicOne(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    judul!,
                    style: GoogleFonts.pathwayGothicOne(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'sudah terbaca : ' + terbaca.toString(),
                    style: GoogleFonts.pathwayGothicOne(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        DatabaseServices.terbacaBlog(id);
      },
    );
  }
}
