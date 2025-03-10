import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram/pages/comment_page.dart';
import 'package:fluttergram/pages/profile_page.dart';
import 'package:fluttergram/providers/page_provider.dart';
import 'package:fluttergram/providers/user_provider.dart';
import 'package:fluttergram/resources/firestore_meth.dart';
import 'package:fluttergram/responsive/mobile_layout.dart';
import 'package:fluttergram/responsive/res_screen_layout.dart';
import 'package:fluttergram/responsive/web_layout.dart';
import 'package:fluttergram/routes/comment_page_route.dart';
import 'package:fluttergram/utils/colours.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fluttergram/models/user.dart' as model;
import 'package:share_plus/share_plus.dart';

class PostPanel extends StatefulWidget {
  final snap;
  const PostPanel({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostPanel> createState() => _PostPanelState();
}

class _PostPanelState extends State<PostPanel> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    Future<String> getPostUser(String col, String doc) async {
      var url = await FirestoreMethods().getPostingUser(col, doc).then((value) => value.values.toList()[6]);
      return url;
    }

    final Future<String> _photoUrl = getPostUser('users', widget.snap['userId'].toString());

    dynamic args = {
      'postingUserId': widget.snap['userId'].toString(),
      'postDescription': widget.snap['description'].toString(),
      'postId': widget.snap['postId'].toString(),
      'postingUserName': widget.snap['username'].toString(),
      'postingDate': DateFormat.yMMMd().format(widget.snap['timestamp'].toDate()),
    };

    return Material(
      child: Center(
        child: Container(
          color: primaryColor,
          width: double.infinity,
          child: Column(
            children: [
              // Header Part
              Row(
                children: [
                  FutureBuilder(
                      future: _photoUrl,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          // args.photoUrl = snapshot.data!.toString();
                          args.addAll({'photoUrl': snapshot.data!.toString()});
                          return CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(snapshot.data!.toString()),
                          );
                        }
                        return const CircleAvatar(
                          radius: 16,
                          backgroundImage: AssetImage('assets/default_profile_photo.png'),
                        );
                      }),
                  TextButton(
                    onPressed: () {
                      if (args['postingUserId'] == FirebaseAuth.instance.currentUser!.uid) {
                        Provider.of<PageProvider>(context, listen: false).changeCurrentScreen(4);
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ProfilePage(uid: widget.snap['userId']);
                        }));
                      }
                    },
                    child: Text(
                      widget.snap['username'].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: blackColour, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      alignment: Alignment.centerRight,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        color: blackColour,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Body - Picture
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    visible = true;
                  });
                  FirestoreMethods().addPostItemInList(widget.snap['postId'].toString(), 'likes', user.uid, widget.snap['likes'].contains(user.uid));
                },
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Image.network(
                      widget.snap['photoUrl'].toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: visible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    onEnd: () {
                      setState(() {
                        visible = false;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.favorite,
                          size: 150,
                        )),
                  )
                ]),
              ),
              // Body - Icons (Likes, Comments, Share, Bookmark)

              Row(
                children: [
                  Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 4.0, // gap between lines
                      direction: Axis.horizontal, // main axis (rows or columns)
                      alignment: WrapAlignment.start,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              FirestoreMethods()
                                  .addPostItemInList(widget.snap['postId'].toString(), 'likes', user.uid, widget.snap['likes'].contains(user.uid));
                            },
                            icon: widget.snap['likes'].contains(user.uid)
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : const Icon(Icons.favorite_border, color: blackColour)),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(generateCommentPageRoute(args));
                            },
                            icon: const Icon(Icons.mode_comment_outlined, color: blackColour)),
                        IconButton(
                            onPressed: () {
                              Share.share('Go to EdSrue Page: https://www.edsure.com.au');
                            },
                            icon: const Icon(Icons.share_outlined, color: blackColour)),
                      ]),
                  Expanded(
                      child: IconButton(
                          alignment: Alignment.centerRight, onPressed: () {}, icon: const Icon(Icons.bookmark_border, color: blackColour))),
                ],
              ),
              // Body - Likes
              Row(
                children: [
                  Text('${widget.snap['likes'].length} likes', style: const TextStyle(color: blackColour)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Body - Description
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.snap['username'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: blackColour, fontSize: 15),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    widget.snap['description'].toString(),
                    style: const TextStyle(color: blackColour, fontSize: 15),
                    overflow: TextOverflow.clip,
                  )),
                ],
              ),
              // Bottom - View all comments
              Container(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CommentPage(arguments: args),
                      ));
                    },
                    child: const Text(
                      'View all comments',
                      style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor, fontSize: 15),
                    )),
              ),
              // Bottom - Dates
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  DateFormat.yMMMd().format(widget.snap['timestamp'].toDate()),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: secondaryColor, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
