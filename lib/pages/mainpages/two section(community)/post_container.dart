import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/components/comment_button.dart';
import 'package:schoolapp/components/like_button.dart';
import '../../../utility/utils.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String title;
  final List<String> likes;
  final String postId;
  final List<String> imageUrls;

  const WallPost(
      {super.key,
      required this.message,
      required this.user,
      required this.title,
      required this.likes,
      required this.postId,
      required this.imageUrls});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  //toggle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    padding: EdgeInsets.all(10),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Column(
                    children: [
                      Text(
                        '익명',
                        style: TextStyle(),
                      ),
                      Text('time')
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: maxWidth - 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.title,
                                      style: SafeGoogleFont(
                                        'Noto Sans KR',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff000000),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: maxWidth - 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.message,
                                      style: SafeGoogleFont(
                                        'Noto Sans KR',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: const Color(0xff000000),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 60,
                          child: widget.imageUrls.isNotEmpty
                              ? Image.network(widget.imageUrls[0])
                              : const SizedBox(), // or a placeholder widget
                        )
                        // here
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  LikeButton(isLiked: isLiked, onTap: toggleLike),
                  SizedBox(
                    width: 3,
                  ),
                  Text(widget.likes.length.toString()),
                  SizedBox(
                    width: 10,
                  ),
                  CommentButton(
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey.shade300,
          thickness: 1,
        ),
      ],
    );
  }
}
