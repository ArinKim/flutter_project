import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram/providers/user_provider.dart';
import 'package:fluttergram/resources/firestore_meth.dart';
import 'package:fluttergram/responsive/mobile_layout.dart';
import 'package:fluttergram/responsive/res_screen_layout.dart';
import 'package:fluttergram/responsive/web_layout.dart';
import 'package:fluttergram/routes/comment_page_route.dart';
import 'package:fluttergram/utils/colours.dart';
import 'package:fluttergram/utils/utils.dart';
import 'package:fluttergram/widgets/txt_input.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fluttergram/models/user.dart' as model;

class CommentPage extends StatefulWidget {
  final arguments;
  const CommentPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  void navigateHomePage() {
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    void uploadComment(String userId, String username, String postId) async {
      try {
        setState(() {
          _isLoading = true;
        });

        if (_commentController.text == '') {
          showSnackBar("You have to enter comment", context);
          setState(() {
            _isLoading = false;
          });
        } else {
          String? res = await FirestoreMethods().uploadComment(
            comment: _commentController.text,
            userId: userId,
            username: username,
            postId: postId,
          );
          if (res != 'Success' && context.mounted) {
            showSnackBar(res!, context);
          }
          setState(() {
            _isLoading = false;
            _commentController.text = "";
          });
        }
      } catch (err) {
        showSnackBar(
          err.toString(),
          context,
        );
      }
    }

    return Scaffold(
      // Top bar
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Comments',
          style: TextStyle(color: blackColour, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: unselectedButtonColour,
              onPressed: navigateHomePage,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    widget.arguments['photoUrl'].toString(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: widget.arguments['postingUserName'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: blackColour, fontSize: 15),
                    children: [
                      TextSpan(
                        text: '  ${widget.arguments['postDescription'].toString()}',
                        style: const TextStyle(fontWeight: FontWeight.normal, color: blackColour, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom - Dates
          Container(
            alignment: Alignment.bottomLeft,
            color: primaryColor,
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 60,
                ),
                Text(
                  widget.arguments['postingDate'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: secondaryColor, fontSize: 12),
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
            thickness: 2,
            color: containerDividerColour,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').doc(widget.arguments['postId'].toString()).collection('comments').snapshots(),
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
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) => Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                          color: primaryColor,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  widget.arguments['photoUrl'].toString(),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: snapshot.data!.docs[index].data()['username'].toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: blackColour, fontSize: 15),
                                  children: [
                                    TextSpan(
                                      text: '  ${snapshot.data!.docs[index].data()['comment'].toString()}',
                                      style: const TextStyle(fontWeight: FontWeight.normal, color: blackColour, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Bottom - Dates
                        Container(
                          alignment: Alignment.bottomLeft,
                          color: primaryColor,
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 60,
                              ),
                              Text(
                                DateFormat.yMMMd().format(snapshot.data!.docs[index].data()['timestamp'].toDate()),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: secondaryColor, fontSize: 12),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Reply',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: unselectedButtonColour, fontSize: 12),
                                  )),
                              Expanded(
                                child: IconButton(
                                    alignment: Alignment.centerRight,
                                    onPressed: () {
                                      FirestoreMethods().addCommentItemInList(
                                          snapshot.data!.docs[index].data()['postId'].toString(),
                                          snapshot.data!.docs[index].data()['commentId'].toString(),
                                          'likes',
                                          user.uid,
                                          snapshot.data!.docs[index].data()['likes'].contains(user.uid));
                                    },
                                    icon: snapshot.data!.docs[index].data()['likes'].contains(user.uid)
                                        ? const Icon(Icons.favorite, color: Colors.red)
                                        : const Icon(Icons.favorite_border, color: blackColour)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      widget.arguments['photoUrl'].toString(),
                    ),
                  ),
                  // text field id
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: TextFieldInput(
                        colour: blackColour,
                        hintText: "Enter your comment here",
                        textInputType: TextInputType.text,
                        textEditingController: _commentController,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        uploadComment(user.uid, user.username, widget.arguments['postId'].toString());
                      },
                      child: const Text('Post'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
