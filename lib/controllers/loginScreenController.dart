// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'dart:developer';

import 'package:dendy_app/Model/loginModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/firebaseApi.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreenController extends GetxController {
  var isDataLoading = false.obs;
  var passwordVisible = false.obs;
  var emailValidationText = ''.obs;
  var passwordValidationText = ''.obs;
  // final passwordController = TextEditingController(text: '1234');
  // final emailController = TextEditingController(text: 'test23@yopmail.com');

  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  var isLoginTap = false.obs;

  @override
  void onInit() {
    super.onInit();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    Get.delete<LoginScreenController>();
    super.dispose();
  }

  String? emailValidation() {
    emailValidationText.value = '';
    passwordValidationText.value = '';
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (emailController.text.isEmpty) {
      emailValidationText.value = 'Please enter email!';
    } else if (!regex.hasMatch(emailController.text)) {
      emailValidationText.value = 'Enter Valid Email';
    }

    if (passwordController.text.isEmpty) {
      passwordValidationText.value = 'Please enter password!';
    }
  }

  String? passwordValidation(String? value) {
    print("pass==> $value");
  }

  Future login() async {
    await FirebaseAPI().initNotifications();
    emailValidationText.value = '';
    passwordValidationText.value = '';
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (emailController.text.isEmpty) {
      emailValidationText.value = 'Please enter email!';
    } else if (!regex.hasMatch(emailController.text)) {
      emailValidationText.value = 'Enter Valid Email';
    }

    if (passwordController.text.isEmpty) {
      passwordValidationText.value = 'Please enter password!';
    }
    if (emailValidationText.value == '' && passwordValidationText.value == '') {
      isLoginTap.value = true;
      await loginApi(emailController.text, passwordController.text)
          .then((auth) {
        if (auth != null) {
          if (!auth.status) {
            showSnackBar(auth.message.toString());

            isLoginTap.value = false;
          } else {
            isLoginTap.value = false;
            GetStorage().write('user_id', auth.data!.id);
            GetStorage().write('access_token', auth.token);
            GetStorage().write('username', auth.data!.name.toString());
            GetStorage().write('mobile', auth.data!.mobile.toString());
            GetStorage().write('email', auth.data!.email.toString());
            GetStorage().write(
                'profile_summary', auth.data!.profile_summary.toString());
            Get.offAllNamed(RouteConstant.dashboardScreen);
          }
        } else {
          isLoginTap.value = false;
        }
      });
    }
  }

  Future<LoginModel?> loginApi(
    String email,
    String password,
  ) async {
    try {
      isDataLoading(true);

      print("GetStorage().read('fcmtoken')${GetStorage().read('fcmtoken')}");

      Map data = {
        'email': email,
        'password': password,
        'device_token': GetStorage().read('fcmtoken')
      };
      print("ggg$data");
      Post post = Post();
      return await post
          .post(
        'auth/signin',
        body: jsonEncode(data),
      )
          .then((dynamic res) async {
        print("login$res");
        return LoginModel.fromJson(res!);
      });
    } catch (e) {
      log('Error in login is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
