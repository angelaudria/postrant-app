import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:google_fonts/google_fonts.dart';
import 'package:posrant/core.dart';

import '../utility/font_size.dart';
import '../utility/theme_colors.dart';
import '../widget/main_button.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: const AssetImage('assets/images/banner-1.jpg'),
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fitHeight,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  ThemeColors.scaffoldBgColor,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Posrant',
                      style: GoogleFonts.poppins(
                        color: ThemeColors.whiteTextColor,
                        fontSize: FontSize.xxxLarge,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Next for sign in ➡️',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: ThemeColors.whiteTextColor,
                      fontSize: FontSize.medium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: MainButton(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                        result: false,
                      ),
                      text: 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
