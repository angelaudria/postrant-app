import 'package:flutter/material.dart';
import 'package:posrant/core.dart';
import '../utility/font_size.dart';
import '../utility/theme_colors.dart';
import '../widget/main_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's get you in!",
                  style: GoogleFonts.poppins(
                    color: ThemeColors.whiteTextColor,
                    fontSize: FontSize.xxLarge,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    "Hi, Welcome to posrant The Food \nSign in to continue ➡️",
                    style: GoogleFonts.poppins(
                      color: ThemeColors.greyTextColor,
                      fontSize: FontSize.medium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Form(
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
                      QTextField(
                        label: "Password",
                        hint: "Your password",
                        validator: Validator.required,
                        suffixIcon: Icons.password,
                        value: controller.password,
                        onChanged: (value) {
                          controller.password = value;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: InkWell(
                            onTap: () => Get.to(const ForgotView()),
                            child: Text(
                              "Forgot password?",
                              style: GoogleFonts.poppins(
                                color: ThemeColors.greyTextColor,
                                fontSize: FontSize.medium,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      MainButton(
                        text: 'Login',
                        onTap: () => controller.login(
                          email: controller.email,
                          password: controller.password,
                        ),
                      ),
                      const SizedBox(height: 16),
                      MainButton(
                        text: 'Login with Google',
                        backgroundColor: ThemeColors.whiteTextColor,
                        textColor: ThemeColors.scaffoldBgColor,
                        iconPath: 'assets/images/google.png',
                        onTap: () => controller.loginWithGoogle(),
                      ),
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
  State<LoginView> createState() => LoginController();
}
