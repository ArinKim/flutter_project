import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttergram/resources/auth_meth.dart';
import 'package:fluttergram/responsive/mobile_layout.dart';
import 'package:fluttergram/responsive/res_screen_layout.dart';
import 'package:fluttergram/responsive/web_layout.dart';
import 'package:fluttergram/pages/signup_page.dart';
import 'package:fluttergram/utils/colours.dart';
import 'package:fluttergram/utils/utils.dart';

import '../widgets/txt_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logInUsr() async {
    setState(() {
      _isLoading = true;
    });
    String? res = await AuthMethods().loginUsr(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res != 'Success' && context.mounted) {
      showSnackBar(res!, context);
      setState(() {
        _isLoading = false;
      });
    } else if (res == 'Success' && context.mounted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ResLayout(webScreenLayout: WebLayout(), mobileScreenLayout: MobileLayout())));
    } else {
      return;
    }
  }

  void navigateToSignUp() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupPage()));
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
              // login button
              InkWell(
                onTap: logInUsr,
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
                      : const Text('Log in'),
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
                      "Don't have an account? ",
                      style: TextStyle(color: blackColour),
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Sign up",
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
