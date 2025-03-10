import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram/pages/profile_page.dart';
import 'package:fluttergram/responsive/mobile_layout.dart';
import 'package:fluttergram/responsive/res_screen_layout.dart';
import 'package:fluttergram/responsive/web_layout.dart';
import 'package:fluttergram/utils/colours.dart';
import 'package:fluttergram/utils/utils.dart';
import 'package:fluttergram/widgets/post_panel.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PostPage extends StatefulWidget {
  final snap;
  final index;
  const PostPage({Key? key, required this.snap, required this.index}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top bar
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Column(
          children: [
            Text(
              widget.snap['username'],
              style: const TextStyle(color: secondaryColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const Text(
              'Posts',
              style: TextStyle(color: blackColour, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: unselectedButtonColour,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          color: primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('timestamp', descending: true)
                    .where('userId', isEqualTo: widget.snap['uid'])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: showSnackBar(snapshot.error.toString(), context),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.active) {
                    return Hero(
                        tag: 'from-profile-to-post-page${widget.index}',
                        child: ListView(physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, children: [
                          PostPanel(
                            snap: snapshot.data!.docs[widget.index].data(),
                          ),
                        ]));
                  }
                  return const CircularProgressIndicator.adaptive();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
