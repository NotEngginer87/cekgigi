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
      appBar: AppBar(
        title: const Text("More"),
      ),
      body: StoryView(
        storyItems: [
          StoryItem.text(
            title: "I guess you'd love to see more of our food. That's great.",
            backgroundColor: Colors.blue,
          ),

          StoryItem.pageImage(
            url:
            "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",

            controller: storyController,
          ),
          StoryItem.pageImage(
              url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",


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