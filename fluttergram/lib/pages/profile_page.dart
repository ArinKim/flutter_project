import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram/pages/edit_profile_page.dart';
import 'package:fluttergram/pages/post_page.dart';
import 'package:fluttergram/providers/user_provider.dart';
import 'package:fluttergram/resources/firestore_meth.dart';
import 'package:fluttergram/responsive/mobile_layout.dart';
import 'package:fluttergram/responsive/res_screen_layout.dart';
import 'package:fluttergram/responsive/web_layout.dart';
import 'package:fluttergram/utils/colours.dart';
import 'package:fluttergram/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:fluttergram/models/user.dart' as model;

class ProfilePage extends StatefulWidget {
  final uid;
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  dynamic userDet = {};
  int postLen = 0;
  bool isFollowing = false;
  bool isLoading = false;
  bool isMe = false;
  @override
  void initState() {
    super.initState();
    getPostData();
    _scrollController = ScrollController();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void navigateHomePage() {
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ResLayout(webScreenLayout: WebLayout(), mobileScreenLayout: MobileLayout())));
    }
  }

  getPostData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var post = await FirebaseFirestore.instance.collection('posts').where('userId', isEqualTo: widget.uid).get();

      var postUser = await FirestoreMethods().getPostingUser('users', widget.uid);

      userDet = postUser.map(
        (key, value) {
          return MapEntry(key, value);
        },
      );

      setState(() {
        postLen = post.docs.length;
        if (userDet['uid'] == FirebaseAuth.instance.currentUser!.uid) {
          isMe = true;
        }
        if (userDet['followers'].contains(FirebaseAuth.instance.currentUser!.uid)) {
          isFollowing = true;
        } else {
          isFollowing = false;
        }
      });
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Row(
            children: [
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : Text(
                      userDet['username'],
                      style: const TextStyle(color: blackColour, fontWeight: FontWeight.bold),
                    ),
              Expanded(
                child: IconButton(
                  alignment: Alignment.centerRight,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: blackColour,
                  ),
                ),
              )
            ],
          ),
          leading: isMe
              ? Text(' ')
              : TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.chevron_left_sharp),
                  label: Text(' '))),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, value) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.13,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10.0),
                            color: primaryColor,
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  userDet['photoUrl'],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              print(postLen);
                                            },
                                            child: Text(
                                              postLen.toString(),
                                              style: const TextStyle(color: blackColour, fontWeight: FontWeight.w700, fontSize: 20),
                                            )),
                                        const Text(
                                          'Posts',
                                          style: TextStyle(color: blackColour, fontWeight: FontWeight.w500, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              userDet['followers'].length.toString(),
                                              style: const TextStyle(color: blackColour, fontWeight: FontWeight.w700, fontSize: 20),
                                            )),
                                        const Text(
                                          'Followers',
                                          style: TextStyle(color: blackColour, fontWeight: FontWeight.w500, fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              userDet['followings'].length.toString(),
                                              style: const TextStyle(color: blackColour, fontWeight: FontWeight.w700, fontSize: 20),
                                            )),
                                        const Text(
                                          'Following',
                                          style: TextStyle(color: blackColour, fontWeight: FontWeight.w500, fontSize: 15),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                            color: primaryColor,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                              Text(
                                userDet['username'],
                                style: const TextStyle(color: blackColour, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                userDet['bio'],
                                style: const TextStyle(color: blackColour, fontWeight: FontWeight.normal),
                              ),
                            ]),
                          ),
                          Container(
                            color: primaryColor,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OutlinedButton(
                                  onPressed: () async {
                                    bool remove = !isFollowing ? false : true;
                                    var postUser;
                                    if (!isMe) {
                                      FirestoreMethods().addUserItemInList(FirebaseAuth.instance.currentUser!.uid, 'followings', widget.uid, remove);
                                      FirestoreMethods().addUserItemInList(widget.uid, 'followers', FirebaseAuth.instance.currentUser!.uid, remove);
                                      postUser = await FirestoreMethods().getPostingUser('users', widget.uid);

                                      userDet = postUser.map(
                                        (key, value) {
                                          return MapEntry(key, value);
                                        },
                                      );
                                      setState(() {
                                        if (userDet['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                                          isMe = true;
                                        }
                                        if (userDet['followers'].contains(FirebaseAuth.instance.currentUser!.uid)) {
                                          isFollowing = true;
                                        } else {
                                          isFollowing = false;
                                        }
                                      });
                                    } else {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return EditProfilePage(
                                          uid: FirebaseAuth.instance.currentUser!.uid,
                                        );
                                      })).then((value) async {
                                        postUser = await FirestoreMethods().getPostingUser('users', widget.uid);
                                        setState(() {
                                          userDet = postUser.map(
                                            (key, value) {
                                              return MapEntry(key, value);
                                            },
                                          );
                                        });
                                      });
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(width: 1.0, color: secondaryColor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: Size(MediaQuery.of(context).size.width * 0.78, 40)),
                                  child: isMe
                                      ? const Text(
                                          'Edit Profile',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: blackColour, fontSize: 15),
                                        )
                                      : isFollowing
                                          ? const Text(
                                              'Unfollow',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: blackColour, fontSize: 15),
                                            )
                                          : const Text(
                                              'Follow',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: blackColour, fontSize: 15),
                                            ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(width: 1.0, color: secondaryColor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: Size(MediaQuery.of(context).size.width * 0.05, 40)),
                                  child: const Icon(
                                    Icons.person_add_outlined,
                                    size: 20,
                                    color: blackColour,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: primaryColor,
                        child: TabBar(
                            controller: _tabController,
                            indicatorColor: secondaryColor,
                            labelColor: blackColour,
                            unselectedLabelColor: unselectedButtonColour,
                            tabs: const [
                              Tab(
                                  icon: Icon(
                                Icons.grid_on_sharp,
                              )),
                              Tab(
                                icon: Icon(
                                  Icons.ondemand_video_sharp,
                                ),
                              ),
                              Tab(
                                icon: Icon(
                                  Icons.person_pin_outlined,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .orderBy('timestamp', descending: true)
                          .where('userId', isEqualTo: userDet['uid'])
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
                          return GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 3),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return PostPage(snap: snapshot.data!.docs[index].data(), index: index);
                                    }));
                                  },
                                  child: Hero(
                                    tag: 'from-profile-to-post-page$index',
                                    child: Image.network(
                                      "${snapshot.data!.docs[index].data()['photoUrl']}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              });
                        }
                        return const CircularProgressIndicator.adaptive();
                      },
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Icon(
                          Icons.warning,
                          color: blackColour,
                        ),
                        Text(
                          'Video thingy will be coming soon :)',
                          style: TextStyle(color: blackColour),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Icon(
                          Icons.warning,
                          color: blackColour,
                        ),
                        Text(
                          'Taggin thingy will be coming soon :)',
                          style: TextStyle(color: blackColour),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
