// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  var isDataLoading = false.obs;
  var passwordVisible = false.obs;
  var emailValidationText = ''.obs;
  var passwordValidationText = ''.obs;
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();

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
      // await loginApi(emailController.text, passwordController.text)
      //     .then((auth) {
      //   if (auth != null) {
      //     if (auth.status == 'error') {
      //       Get.snackbar('login', auth.message!,
      //           backgroundColor: primaryGradient2, colorText: whiteColor);
      //       isLoginTap.value = false;
      //     } else {
      //       isLoginTap.value = false;
      //       GetStorage().write('user_id', auth.data!.userId);
      //       GetStorage().write('access_token', auth.data!.access_token);
      //       Get.offAllNamed(RouteConstant.homeScreen);
      //     }
      //   } else {
      //     isLoginTap.value = false;
      //   }
      // });
    }
  }

  // Future<SignUpModel?> loginApi(
  //   String email,
  //   String password,
  // ) async {
  //   try {
  //     isDataLoading(true);
  //     Map data = {
  //       'email': email,
  //       'password': password,
  //     };
  //     Post post = Post();
  //     return await post
  //         .post(
  //       'login.php',
  //       body: jsonEncode(data),
  //     )
  //         .then((dynamic res) async {
  //       print("login$res");
  //       return SignUpModel.fromJson(res!);
  //     });
  //   } catch (e) {
  //     log('Error in login is $e');
  //   } finally {
  //     isDataLoading(false);
  //   }
  // }
}
