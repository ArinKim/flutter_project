import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttergram/routes/upload_post_route.dart';
import 'package:fluttergram/utils/colours.dart';

class UploadPostLandingPage extends StatefulWidget {
  const UploadPostLandingPage({Key? key}) : super(key: key);

  @override
  State<UploadPostLandingPage> createState() => _UploadPostLandingPageState();
}

class _UploadPostLandingPageState extends State<UploadPostLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              fit: BoxFit.cover,
              width: 150,
            ),
          ],
        ),
      ),
      body: TextButton(
          onPressed: () {
            Navigator.of(context).push(generateUploadPostRoute());
          },
          child: Text('Upload post')),
    );
  }
}
