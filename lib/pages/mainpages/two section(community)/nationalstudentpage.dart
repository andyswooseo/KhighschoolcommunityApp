import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/pages/mainpages/two%20section(community)/post_container.dart';

class NationalStudentPage extends StatefulWidget {
  const NationalStudentPage({super.key});

  @override
  State<NationalStudentPage> createState() => _NationalStudentPageState();
}

class _NationalStudentPageState extends State<NationalStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('User Posts')
                    .orderBy(
                      "TimeStamp",
                      descending: true,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // get the message
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                          title: post['TitleMessage'],
                          likes: List<String>.from(post['Likes'] ?? []),
                          postId: post.id,
                        );
                      },
                    );
                  } else if (snapshot.hasData) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
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
    );
  }
}
