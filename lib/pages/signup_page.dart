import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttergram/resources/auth_meth.dart';
import 'package:fluttergram/responsive/mobile_layout.dart';
import 'package:fluttergram/responsive/res_screen_layout.dart';
import 'package:fluttergram/responsive/web_layout.dart';
import 'package:fluttergram/pages/login_page.dart';
import 'package:fluttergram/utils/colours.dart';
import 'package:fluttergram/utils/utils.dart';

import '../widgets/txt_input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageeState();
}

class _SignupPageeState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usrnameController = TextEditingController();
  Uint8List? _avaterImg;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usrnameController.dispose();
  }

  void pickImage() async {
    Uint8List img = await getImage(ImageSource.gallery);
    setState(() {
      _avaterImg = img;
    });
  }

  void signUpUsr() async {
    setState(() {
      _isLoading = true;
    });
    String? res = await AuthMethods().singupUsr(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usrnameController.text,
      bio: _bioController.text,
      avatarImg: _avaterImg!,
    );

    if (res != 'Success' && context.mounted) {
      showSnackBar(res!, context);
      setState(() {
        _isLoading = false;
      });
    } else if (res == 'Success' && context.mounted) {
      Navigator.pop(context);
    } else {
      return;
    }
  }

  void navigateToLogIn() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // SVG logo image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                height: 64,
                colorFilter: const ColorFilter.mode(blackColour, BlendMode.srcIn),
              ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  _avaterImg != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_avaterImg!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: AssetImage('assets/default_profile_photo.png'),
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
              // text field user name
              TextFieldInput(
                colour: blackColour,
                hintText: "Enter your user name",
                textInputType: TextInputType.text,
                textEditingController: _usrnameController,
              ),
              const SizedBox(
                height: 24,
              ),
              // text field id
              TextFieldInput(
                colour: blackColour,
                hintText: "Enter your email address",
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 24,
              ),
              // text field password
              TextFieldInput(
                colour: blackColour,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              // text field bio
              TextFieldInput(
                colour: blackColour,
                hintText: "Enter your bio here",
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              const SizedBox(
                height: 24,
              ),
              // login button
              InkWell(
                onTap: signUpUsr,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    color: blueColour,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign up'),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),

              // Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Already have an account? ",
                      style: TextStyle(color: blackColour),
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToLogIn,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold, color: blackColour),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
