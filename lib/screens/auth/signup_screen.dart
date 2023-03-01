import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todov2/controllers/signup_controller.dart';
import 'package:get/get.dart';

import '../../routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final signupController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: GetBuilder<SignUpController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
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
                  height: 30,
                ),
                CustomTextField(
                  hint: 'Name',
                  controller: controller.nameController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Address',
                  controller: controller.addressController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Contact',
                  controller: controller.contactController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Email',
                  controller: controller.emailController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Password',
                  obscureText: true,
                  controller: controller.passwordController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Confirm Password',
                  obscureText: true,
                  controller: controller.confirmPasswordController,
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomButton(
                  label: "Sign Up",
                  onPressed: () {
                    controller.checkSignup();
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
                        text: ' Already have an account? ',
                      ),
                      TextSpan(
                        text: 'Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(GetRoutes.login);
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
