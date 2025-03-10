import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttergram/providers/user_provider.dart';
import 'package:fluttergram/resources/firestore_meth.dart';
import 'package:fluttergram/responsive/mobile_layout.dart';
import 'package:fluttergram/responsive/res_screen_layout.dart';
import 'package:fluttergram/responsive/web_layout.dart';
import 'package:fluttergram/utils/colours.dart';
import 'package:fluttergram/utils/utils.dart';
import 'package:provider/provider.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({Key? key}) : super(key: key);

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  void navigatePreviousPage() {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await getImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await getImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void uploadPost(String userId, String username) async {
    setState(() {
      _isLoading = true;
    });

    if (_file == null) {
      showSnackBar("You have to upload image!", context);
      setState(() {
        _isLoading = false;
      });
    } else {
      String? res = await FirestoreMethods().uploadPost(
        description: _descriptionController.text,
        userId: userId,
        username: username,
        postImg: _file!,
      );
      if (res != 'Success' && context.mounted) {
        showSnackBar(res!, context);
        setState(() {
          _isLoading = false;
        });
      }
      if (res == 'Success' && context.mounted) {
        navigatePreviousPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      // Top bar
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Post',
          style: TextStyle(color: blackColour, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.close),
              color: unselectedButtonColour,
              onPressed: navigatePreviousPage,
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => uploadPost(userProvider.getUser.uid, userProvider.getUser.username), child: const Text("Post")),
        ],
      ),
      // Body
      body: Column(
        children: [
          _isLoading ? const LinearProgressIndicator() : const Padding(padding: EdgeInsets.only(top: 0.0)),
          const Divider(),
          Container(
            color: primaryColor,
            child: Column(
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      InkWell(
                        onTap: () => _selectImage(context),
                        child: Container(
                          decoration: BoxDecoration(
                            image: _file != null
                                ? DecorationImage(
                                    image: MemoryImage(_file!),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: AssetImage('assets/upload_pic.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.28,
                        left: MediaQuery.of(context).size.width * 0.33,
                        child: IconButton(
                          onPressed: () => _selectImage(context),
                          icon: const Icon(
                            Icons.add_photo_alternate_rounded,
                            color: primaryColor,
                            size: 100.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: secondaryColor,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    style: const TextStyle(color: blackColour),
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: "Write a caption...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: secondaryColor),
                      ),
                      hintStyle: TextStyle(color: blackColour),
                    ),
                    maxLines: 8,
                  ),
                ),
                const Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
