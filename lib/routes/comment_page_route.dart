import 'package:flutter/material.dart';
import 'package:fluttergram/pages/comment_page.dart';

Route generateCommentPageRoute(arguments) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CommentPage(arguments: arguments),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1, 0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
