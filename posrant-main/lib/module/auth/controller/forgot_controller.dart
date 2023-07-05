import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posrant/service/auth_service/auth_service.dart';
import 'package:posrant/shared/util/show_loading/show_loading.dart';
import 'package:posrant/state_util.dart';
import '../view/forgot_view.dart';

class ForgotController extends State<ForgotView> implements MvcController {
  static late ForgotController instance;
  late ForgotView view;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  void _showSuccessMessage() {
    Fluttertoast.showToast(
      msg: 'Link resset password has been succesfully send to your email.',
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

  String email = '';

  Future<void> doForgotPassword({required String email}) async {
    if (email.isEmpty) {
      String errorMessage = 'Email cannot be empty';
      _showErrorMessage(errorMessage);
      return;
    }

    showLoading();
    try {
      await AuthService().forgotPassword(email: email);
      hideLoading();
      Get.back();
      _showSuccessMessage();
    } catch (e) {
      hideLoading();
      String errorMessage = 'Failed: ';

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            errorMessage += 'Invalid email address';
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
}
