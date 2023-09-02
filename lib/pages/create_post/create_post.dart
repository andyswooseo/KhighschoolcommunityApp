import 'package:flutter/material.dart';
import 'package:schoolapp/components/my_button.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          MyButton(onTap: () {}, text: 'hi')
        ],
      ),
    );
  }
}
