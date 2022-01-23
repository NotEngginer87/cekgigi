// ignore_for_file: avoid_print

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
    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.text(
            title: "Keuntungan Menggunakan iDent",
            backgroundColor: Colors.teal.shade900,
          ),
          StoryItem.pageImage(
            url:
                "https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/keuntungan%2FBiaya-Murah%20(1)%20(1).png?alt=media&token=69bf855b-f866-4b0f-9804-ea492f00f606",
            controller: storyController,
          ),
          StoryItem.pageImage(
              url:
                  "https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/keuntungan%2FUntitled-Artwork%20(1)%20(1).png?alt=media&token=1f2875e7-ee20-4c56-adf5-db4986241615",
              controller: storyController),
          StoryItem.pageImage(
              url:
                  "https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/keuntungan%2FBeach%2C-home%2C-forest%20(1).png?alt=media&token=b73c1fa3-18c1-4a62-9bf1-5d2576ca990d",
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.text(
            title: "Cara Menggunakan iDent",
            backgroundColor: Colors.teal.shade900,
          ),
          StoryItem.pageImage(
            url:
                'https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/cara%20pakai%2Fkonsultasi%2Fbaksos%201%20R3-min.png?alt=media&token=c5f33ee2-8dd6-4ea0-aa1c-c0de93b62135',
            controller: storyController,
          ),
          StoryItem.pageImage(
              url:
                  "https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/cara%20pakai%2Fkonsultasi%2Fbaksos%202%20R3-min.png?alt=media&token=e6a00764-d3a2-4033-b37d-aaf78db1ecad",
              controller: storyController),
          StoryItem.pageImage(
              url:
                  "https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/cara%20pakai%2Fkonsultasi%2Fbaksos%203%20R5-min.png?alt=media&token=97982101-2e84-4423-935c-6ffb2b8b10d9",
              controller: storyController),
          StoryItem.pageImage(
              url:
                  "https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/cara%20pakai%2Fkonsultasi%2FKartun%203-min.png?alt=media&token=14e6324e-69fd-4598-aee7-43ea6a9ce375",
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
      ),
    );
  }
}
