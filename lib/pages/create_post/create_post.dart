import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolapp/components/my_button.dart';
import 'package:schoolapp/utility/utils.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final titleTextController = TextEditingController();
  final postTextController = TextEditingController();
  List<File> images = [];

  @override

  void postMessage() async {
    if (postTextController.text.isNotEmpty && titleTextController.text.isNotEmpty) {
      List<String> imageUrls = []; // 이미지의 다운로드 URL을 저장할 리스트

      // 이미지를 Firebase Storage에 업로드하고 다운로드 URL 받기
      for (final imageFile in images) {
        final imageUrl = await uploadImageToFirebaseStorage(imageFile);
        if (imageUrl.isNotEmpty) {
          imageUrls.add(imageUrl);
        }
      }
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail' : currentUser.email,
        'TitleMessage' : titleTextController.text,
        'Message' : postTextController.text,
        'TimeStamp' : Timestamp.now(),
        'Likes' : [],
        'ImageUrls' : imageUrls,
      });

      Navigator.pop(context);
    } else {
      final snackbar = SnackBar(content: Text('제목과 내용을 모두 입력해야 합니다.'));

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void dispose() {
    super.dispose();
    postTextController.dispose();
    titleTextController.dispose();
  }

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

  final currentUser = FirebaseAuth.instance.currentUser!;

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyButton(
              onTap: postMessage,
              text: '게시',
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: titleTextController,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold
                ),
                decoration: const InputDecoration(
                  hintText: "주요 메시지 ..",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 26,
                      fontWeight: FontWeight.w600),
                  border: InputBorder.none,
                ),
                maxLines: 1,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: postTextController,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                      decoration: const InputDecoration(
                        hintText: "say something ..",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                  )
                ],
              ),
              if (images.isNotEmpty)
                CarouselSlider(
                  items: images.map((file) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Image.file(file),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 400,
                    enableInfiniteScroll: false,
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 0.3))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8).copyWith(left: 15, right: 15),
              child: GestureDetector(
                onTap: onPickImages,
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8).copyWith(left: 15, right: 15),
              child: Icon(
                Icons.photo_library_outlined,
                size: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8).copyWith(left: 15, right: 15),
              child: Icon(
                Icons.voicemail_outlined,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
