import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/signup_login_controller.dart';
import 'package:news_app/shared/my_toast.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();

  var selectedValue = 1;

  final SignupLoginController _signupLoginController =
      Get.put(SignupLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login or Signup'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          // color: const Color.fromARGB(255, 251, 255, 237),
          width: 300,
          child: Wrap(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: RadioListTile<int>(
                      title: const Text('Login'),
                      value: 1,
                      groupValue: selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: RadioListTile<int>(
                      title: const Text('Sign up'),
                      value: 2,
                      groupValue: selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              Visibility(
                  visible: selectedValue == 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                            controller: loginEmailController,
                            decoration:
                                const InputDecoration(labelText: 'E-Mail')),
                        TextField(
                            controller: loginPasswordController,
                            obscureText: true,
                            decoration:
                                const InputDecoration(labelText: 'Password')),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  loginValidation();
                                },
                                child: const Text('Login'))),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )),
              Visibility(
                  visible: selectedValue == 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                            controller: signupEmailController,
                            decoration:
                                const InputDecoration(labelText: 'E-Mail')),
                        TextField(
                            controller: signupPasswordController,
                            obscureText: true,
                            decoration:
                                const InputDecoration(labelText: 'Password')),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  signupValidation();
                                },
                                child: const Text('Signup'))),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void loginValidation() {
    if (loginEmailController.text == '') {
      showErrorToast('Plese enter email');
    } else if (loginPasswordController.text == '') {
      showErrorToast('Please enter password');
    } else {
      _signupLoginController.signInWithEmailAndPassword(
          loginEmailController.text.toString(),
          loginPasswordController.text.toString());
    }
  }

  void signupValidation() {
    if (signupEmailController.text == '') {
      showErrorToast('Plese enter email');
    } else if (signupPasswordController.text == '') {
      showErrorToast('Please enter password');
    } else {
      _signupLoginController.signUpWithEmailAndPassword(
          signupEmailController.text.toString(),
          signupPasswordController.text.toString());
    }
  }
}
