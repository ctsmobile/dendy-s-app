// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isDataLoading = false.obs;

  var isLogoutTap = false.obs;

  @override
  void onInit() {
    super.onInit();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    Get.delete<ProfileController>();
    super.dispose();
  }

  Future logout() async {
    isLogoutTap.value = true;
    await logoutApi().then((auth) {
      if (auth['status'] != true) {
        Get.snackbar('signout', auth['message'],
            backgroundColor: purpleColor, colorText: whiteColor);
      } else {
        // Get.snackbar('signout', auth['message'],
        //     backgroundColor: purpleColor, colorText: whiteColor);

        Get.offAllNamed(RouteConstant.loginScreen);
      }
    });
  }

  Future logoutApi() async {
    try {
      isDataLoading(true);

      Post post = Post();
      return await post
          .get(
        'auth/logout',
      )
          .then((dynamic res) async {
        print("logout$res");
        return res!;
      });
    } catch (e) {
      log('Error in logout is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
