import 'package:flutter/material.dart';
import 'package:posrant/core.dart';
import 'package:posrant/module/auth/utility/font_size.dart';
import 'package:posrant/module/auth/utility/theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unnecessary_import
import '../controller/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  Widget build(BuildContext context, ProfileController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => controller.doLogout(),
            icon: const Icon(
              Icons.logout,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(controller.getCurrentUser()?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  }

                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  controller
                      .updateUserData(userData); // Update data di controller

                  return Form(
                    child: Column(
                      children: [
                        QImagePicker(
                          label: "Photo",
                          validator: Validator.required,
                          value: controller.photo ?? '',
                          onChanged: (value) {
                            controller.updatePhoto(value);
                          },
                        ),
                        QTextField(
                          label: "Name",
                          hint: "Name",
                          validator: Validator.required,
                          value: controller.name ?? '',
                          onChanged: (value) {
                            controller.updateName(value);
                          },
                        ),
                        QTextField(
                          label: "Email",
                          hint: "Email",
                          validator: Validator.required,
                          value: controller.email ?? '',
                          onChanged: (value) {
                            controller.updateEmail(value);
                          },
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: InkWell(
                              onTap: () => Get.to(const ForgotView()),
                              child: Text(
                                "Reset password?",
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
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                controller.updateProfile();
                              },
                              child: const Text('Update'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}
