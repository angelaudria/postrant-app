// login_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:posrant/core.dart';
import 'package:posrant/service/auth_service/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginController extends State<LoginView> implements MvcController {
  static late LoginController instance;
  late LoginView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  void _showSuccessMessage(String successMessage) {
    Fluttertoast.showToast(
      msg: successMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.lightBlue,
      textColor: Colors.white,
    );
  }

  void _showErrorMessage(String errorMessage) {
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  String email = "";
  String password = "";

  Future<String?> getUserEmail() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? account = await googleSignIn.signIn();

    if (account != null) {
      // Pilih akun Google yang akan digunakan
      GoogleSignInAuthentication authentication = await account.authentication;
      // ignore: unused_local_variable
      String? accessToken = authentication.accessToken;
      // ignore: unused_local_variable
      String? idToken = authentication.idToken;

      // Gunakan accessToken atau idToken untuk mendapatkan informasi pengguna
      // Misalnya, untuk mendapatkan email pengguna:
      String? email = account.email;

      return email;
    }

    return null;
  }

  Future<void> updateUID(User user, String newUID) async {
    // Update UID di dokumentasi pengguna
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'uid': newUID});

    // Update UID pengguna itu sendiri
    await user.updateDisplayName(newUID);
  }

  Future<void> login({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      String errorMessage = 'Email and password cannot be empty';
      _showErrorMessage(errorMessage);
      return;
    }

    showLoading();
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;

      if (user != null) {
        // Perbarui UID pengguna dengan UID baru dari Firebase
        String newUID = user.uid;

        // Panggil fungsi updateUID untuk memperbarui UID pengguna di Firestore
        await updateUID(user, newUID);

        Get.offAll(MainNavigationView());
        hideLoading();
        String successMessage = 'Successfully login';
        _showSuccessMessage(successMessage);
      }
    } catch (e) {
      hideLoading();
      String errorMessage = 'Failed to login: ';

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'wrong-password':
            errorMessage += 'Invalid password';
            break;
          case 'invalid-email':
            errorMessage += 'Invalid email address';
            break;
          case 'user-disabled':
            errorMessage += 'User account is disabled';
            break;
          case 'user-not-found':
            errorMessage += 'User not found';
            break;
          default:
            errorMessage += e.toString();
            break;
        }
      } else {
        errorMessage += e.toString();
      }

      _showErrorMessage(errorMessage);
    }
  }

  Future<void> loginWithGoogle() async {
    showLoading();
    try {
      // Ambil email pengguna yang valid
      String? userEmail = await getUserEmail();

      // Lakukan pengecekan pada koleksi "users" menggunakan email pengguna
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // Pengguna ditemukan dalam koleksi "users"
        await AuthService().loginWithGoogle();
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Perbarui UID pengguna dengan UID baru dari Firebase
          String newUID = user.uid;

          // Panggil fungsi updateUID untuk memperbarui UID pengguna di Firestore
          await updateUID(user, newUID);

          Get.offAll(MainNavigationView());
          hideLoading();
          _showSuccessMessage('Successfully login');
        } else {
          hideLoading();
          _showErrorMessage('Failed to login');
        }
      } else {
        hideLoading();

        // Tampilkan dialog atau opsi pemilihan akun ulang
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Account Selection'),
              content: const Text(
                  'Your account is not registered. Do you want to select another account?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Kembali ke halaman sebelumnya
                    Get.back();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // Pilih akun Google baru
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    await googleSignIn.signOut();
                    await googleSignIn.signIn();
                  },
                  child: const Text('Select Account'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      hideLoading();
      String successMessage = 'Failed to login';
      _showErrorMessage(successMessage);
      Get.back();
    }
  }
}
