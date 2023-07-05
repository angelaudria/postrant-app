import 'package:flutter/material.dart';
import 'package:posrant/core.dart';
import 'package:posrant/module/auth/utility/font_size.dart';
import 'package:posrant/module/auth/utility/theme_colors.dart';
import 'package:posrant/module/auth/widget/main_button.dart';
// ignore: unnecessary_import
import '../controller/forgot_controller.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({Key? key}) : super(key: key);

  Widget build(context, ForgotController controller) {
    controller.view = this;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    "Forgot Password ? \nEnter a valid email for reset password !",
                    style: GoogleFonts.poppins(
                      color: ThemeColors.greyTextColor,
                      fontSize: FontSize.medium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      QTextField(
                        label: "Email",
                        hint: "Your email",
                        validator: Validator.email,
                        suffixIcon: Icons.email,
                        value: controller.email,
                        onChanged: (value) {
                          controller.email = value;
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      MainButton(
                        text: 'Forgot Password',
                        onTap: () => controller.doForgotPassword(
                          email: controller.email,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<ForgotView> createState() => ForgotController();
}
