import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todov2/controllers/login_controller.dart';
import 'package:flutter_todov2/widgets/custom_button.dart';
import 'package:flutter_todov2/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../../routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: GetBuilder<LoginController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'B A S I C',
                    style: TextStyle(
                      fontSize: 45,
                      color: Color.fromARGB(255, 19, 20, 29),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                CustomTextField(
                  hint: 'Email or Username',
                  controller: controller.emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hint: 'Password',
                  controller: controller.passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomButton(
                  label: "Login",
                  onPressed: () {
                    controller.checkLogin();
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      color: Color.fromARGB(255, 172, 169, 169),
                    ),
                    children: [
                      const TextSpan(
                        text: ' Don\'t have an account? ',
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(GetRoutes.signup);
                          },
                        style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      const TextHeightBehavior(applyHeightToFirstAscent: false),
                  softWrap: false,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
