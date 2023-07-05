import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posrant/module/auth/view/login_view.dart';
import 'package:posrant/service/auth_service/auth_service.dart';
import 'package:posrant/shared/util/show_loading/show_loading.dart';
import 'package:posrant/state_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../view/profile_view.dart';

class ProfileController extends State<ProfileView> implements MvcController {
  static late ProfileController instance;
  late ProfileView view;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? photo;
  String? name;
  String? email;

  @override
  void initState() {
    instance = this;
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  void _showSuccessMessage() {
    Fluttertoast.showToast(
      msg: 'Profile updated successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.lightBlue,
      textColor: Colors.white,
    );
  }

  void _showErrorMessage() {
    Fluttertoast.showToast(
      msg: 'Failed to update profile',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void _fetchUserData() async {
    User? currentUser = getCurrentUser();
    if (currentUser != null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (documentSnapshot.exists) {
        setState(() {
          photo = documentSnapshot.get('pic');
          name = documentSnapshot.get('name');
          email = documentSnapshot.get('email');
        });
      }
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  void updatePhoto(String value) {
    setState(() {
      photo = value;
    });
  }

  void updateName(String value) {
    setState(() {
      name = value;
    });
  }

  void updateEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void updateProfile() {
    User? currentUser = getCurrentUser();
    if (currentUser != null) {
      showLoading();
      _firestore.collection('users').doc(currentUser.uid).update({
        'pic': photo,
        'name': name,
        'email': email,
      }).then((value) {
        hideLoading();
        _showSuccessMessage();
        // Update successful
      }).catchError((error) {
        _showErrorMessage();
        // Handle error
      });
    }
  }

  void updateUserData(Map<String, dynamic> userData) {
    // Implement the logic to update user data using userData
  }

  void doLogout() async {
    showLoading();
    await AuthService().logout();
    hideLoading();
    Get.offAll(const LoginView());
  }
}
