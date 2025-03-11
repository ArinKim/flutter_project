import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttergram/resources/auth_meth.dart';
import 'package:fluttergram/resources/firestore_meth.dart';
import 'package:fluttergram/resources/storage_meth.dart';
import 'package:fluttergram/utils/colours.dart';
import 'package:fluttergram/utils/utils.dart';
import 'package:fluttergram/widgets/txt_input.dart';

class EditProfilePage extends StatefulWidget {
  final uid;
  const EditProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usrnameController = TextEditingController();
  Uint8List? _avaterImg;
  bool _isLoading = false;

  dynamic userDet = {};

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usrnameController.dispose();
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void pickImage() async {
    Uint8List img = await getImage(ImageSource.gallery);
    setState(() {
      _avaterImg = img;
    });
  }

  getUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var postUser = await FirestoreMethods().getPostingUser('users', widget.uid);

      userDet = postUser!.map(
        (key, value) {
          return MapEntry(key, value);
        },
      );
      setState(() {
        _emailController.text = userDet['email'];
        _bioController.text = userDet['bio'];
        _passwordController.text = userDet['password'];
        _usrnameController.text = userDet['username'];
      });
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void editUsrDet() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List items = [
        ['email', _emailController.text],
        ['password', _passwordController.text],
        ['username', _usrnameController.text],
        ['bio', _bioController.text],
      ];
      if (_avaterImg != null) {
        String? photoUrl = await StorageMethods().uploadImageToStorage('profilePic', _avaterImg!, false, '');
        await FirestoreMethods().addUserItem(widget.uid.toString(), 'photoUrl', photoUrl, false);
      }

      for (var i = 0; i < items.length; i++) {
        await FirestoreMethods().addUserItem(widget.uid.toString(), items[i][0], items[i][1], false);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
      setState(() {
        _isLoading = false;
      });
    } finally {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top bar
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Column(
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(color: blackColour, fontWeight: FontWeight.bold, fontSize: 16),
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
        actions: [
          TextButton(onPressed: editUsrDet, child: const Text("Done")),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _isLoading ? const LinearProgressIndicator() : const Padding(padding: EdgeInsets.only(top: 0.0)),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Stack(
                children: [
                  _avaterImg != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_avaterImg!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            userDet['photoUrl'],
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(onPressed: pickImage, icon: const Icon(Icons.add_a_photo)),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                          child: Text(
                            'Username',
                            style: TextStyle(color: blackColour),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                          child: Text(
                            'Email',
                            style: TextStyle(color: blackColour),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                          child: Text(
                            'Password',
                            style: TextStyle(color: blackColour),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                          child: Text(
                            'Bio',
                            style: TextStyle(color: blackColour),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // text field user name
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextFieldInput(
                          colour: blackColour,
                          hintText: "Enter your user name",
                          textInputType: TextInputType.text,
                          textEditingController: _usrnameController,
                        ),
                      ),
                      // text field user name
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: // text field id
                            TextFieldInput(
                          colour: blackColour,
                          hintText: "Enter your email address",
                          textInputType: TextInputType.emailAddress,
                          textEditingController: _emailController,
                        ),
                      ),
                      // text field user name
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: // text field password
                            TextFieldInput(
                          colour: blackColour,
                          hintText: "Enter your password",
                          textInputType: TextInputType.text,
                          textEditingController: _passwordController,
                          isPass: true,
                        ),
                      ),
                      // text field user name
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: // text field bio
                            TextFieldInput(
                          colour: blackColour,
                          hintText: "Enter your bio here",
                          textInputType: TextInputType.text,
                          textEditingController: _bioController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
