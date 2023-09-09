import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import 'package:schoolapp/utility/utils.dart';

class PostController extends StateNotifier<bool> {
  PostController() : super(false);

  void sharePost({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, 'Please enter text');
      return;
    }

    if (images.isNotEmpty) {
      _shareImagePost(
        images: images,
        text: text,
        context: context,
      );
    } else {
      _shareTextPost(
        images: images,
        text: text,
        context: context,
      );
    }
  }

  void _shareImagePost({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {}

  void _shareTextPost({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {}

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for(String word in wordsInSentence) {
      if(word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
