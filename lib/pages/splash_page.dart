import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/signup_login_controller.dart';
import 'package:news_app/pages/login_signup_page.dart';
import 'package:news_app/pages/news_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SignupLoginController _signupLoginController =
      Get.put(SignupLoginController());

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      String userid = await _signupLoginController.loadData();

      if (userid != '') {
        Get.offAll(() => const NewsPage());
      } else {
        Get.offAll(() => const LoginSignupPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
