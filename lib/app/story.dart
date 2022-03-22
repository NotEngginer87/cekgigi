// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class MoreStories extends StatefulWidget {
  const MoreStories({Key? key}) : super(key: key);

  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.text(
            title: "Cara menggunakan Aplikasi iDent",
            backgroundColor: Colors.teal.shade900,
          ),
          StoryItem.pageImage(
            url:
                "https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/WhatsApp%20Image%202022-01-19%20at%2001.10.17.jpeg?alt=media&token=a360f53a-253b-4b37-a3e8-be5ce9622ffe",
            controller: storyController,
          ),
          StoryItem.pageImage(
              url:
                  "https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/WhatsApp%20Image%202022-01-19%20at%2001.10.17.jpeg?alt=media&token=a360f53a-253b-4b37-a3e8-be5ce9622ffe",
              controller: storyController),
        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}

class KeuntunganiDentStory extends StatefulWidget {
  const KeuntunganiDentStory({Key? key}) : super(key: key);

  @override
  _KeuntunganiDentStory createState() => _KeuntunganiDentStory();
}

class _KeuntunganiDentStory extends State<KeuntunganiDentStory> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference desain = firestore.collection('DesainTampilan');
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
      stream: desain.doc('2022').collection('keuntungan').doc('image').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;

          String url1 = data['url1'];
          String url2 = data['url2'];
          String url3 = data['url3'];

          return StoryView(
            storyItems: [
              StoryItem.text(
                title: "Keuntungan Menggunakan iDent",
                backgroundColor: Colors.teal.shade900,
              ),
              StoryItem.pageImage(
                url:url1,
                controller: storyController,
              ),
              StoryItem.pageImage(
                  url:url2,
                  controller: storyController),
              StoryItem.pageImage(
                  url: url3,
                  controller: storyController),
            ],
            onStoryShow: (s) {
              print("Showing a story");
            },
            onComplete: () {
              print("Completed a cycle");
              Navigator.pop(context);
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            controller: storyController,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ),

    );
  }
}

class TutorialiDentStory extends StatefulWidget {
  const TutorialiDentStory({Key? key}) : super(key: key);

  @override
  _TutorialiDentStory createState() => _TutorialiDentStory();
}

class _TutorialiDentStory extends State<TutorialiDentStory> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference desain = firestore.collection('DesainTampilan');
  return Scaffold(
    body: StreamBuilder<DocumentSnapshot>(
      stream: desain.doc('2022').collection('caramenggunakan').doc('howto').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;

          String url1 = data['url1'];
          String url2 = data['url2'];
          String url3 = data['url3'];
          String url4 = data['url4'];
          String url5 = data['url5'];
          String url6 = data['url6'];

          return StoryView(
            storyItems: [
              StoryItem.text(
                title: "Cara Menggunakan Aplikasi iDent",
                backgroundColor: Colors.teal.shade900,
              ),
              StoryItem.pageImage(
                url:url1,
                controller: storyController,
              ),
              StoryItem.pageImage(
                  url:url2,
                  controller: storyController),
              StoryItem.pageImage(
                  url: url3,
                  controller: storyController),
              StoryItem.pageImage(
                  url: url4,
                  controller: storyController),
              StoryItem.pageImage(
                  url: url5,
                  controller: storyController),
              StoryItem.pageImage(
                  url: url6,
                  controller: storyController),
            ],
            onStoryShow: (s) {
              print("Showing a story");
            },
            onComplete: () {
              print("Completed a cycle");
              Navigator.pop(context);
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            controller: storyController,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ),

  );
  }
}
