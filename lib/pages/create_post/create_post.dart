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
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        actions: [MyButton(onTap: () {}, text: 'POST')],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
              )
            ],
          ),
        ),
      ),
    );
  }
}
