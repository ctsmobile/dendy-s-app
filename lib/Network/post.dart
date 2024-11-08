// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' show Client;

class Post {
  final JsonDecoder _decoder = JsonDecoder();
  Client client = Client();

  // post methods data
  Future<dynamic> post(String url, {Map? headers, body}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    print("connectivityResult$connectivityResult");
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar('Network Error', 'Please check your internet connection!',
          backgroundColor: redColor, colorText: whiteColor);
      return null;
    } else {
      var token = GetStorage().read('access_token');

      print("token$token");
      if (url.contains('signin') ||
          url.contains('forgot_password') ||
          url.contains('reset_password') ||
          token != null) {
        print("yaha tak aaya$baseUrl BBB$url");
        final apiUrl = baseUrl + url;

        return client
            .post(
          Uri.parse(apiUrl),
          body: body,
          headers: token == null
              ? {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                }
              : {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'token': token
                },
        )
            .then((response) {
          // print("bbbbhjjj$response");
          final dynamic res = response.body;
          final int statusCode = response.statusCode;
          // print("hello url3");
          // print('fgfg$statusCode $res');
          if (statusCode < 200 || statusCode > 400) {
            // showSnackBar(context: context, text: response.body);
            // print('mess${response.body}');
            Get.snackbar('${apiUrl}\nstatusCode:', statusCode.toString(),
                backgroundColor: redColor, colorText: whiteColor);
            return 'Error';
          }

          if (response.body.isEmpty) {
            return "1";
          }

          return _decoder.convert(res);
        });
      } else {
        print("jjjj");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.toNamed(RouteConstant.loginScreen);
          // Get.snackbar('Please Login!', 'You are not logged-in!',
          //     backgroundColor: primaryGradient2, colorText: whiteColor);
        });
      }
    }
  }

  Future<dynamic> get(
    String url,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    print("connectivityResult$connectivityResult");
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar('Network Error', 'Please check your internet connection!',
          backgroundColor: redColor, colorText: whiteColor);
      return null;
    } else {
      var token = GetStorage().read('access_token');

      print("token$token");
      if (url.contains('signin') ||
          url.contains('forgot_password') ||
          url.contains('reset_password') ||
          token != null) {
        print("yaha tak aaya$baseUrl BBB$url");
        final apiUrl = baseUrl + url;

        return client.get(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ).then((response) async {
          // print("bbbbhjjj$response");
          final dynamic res = response.body;
          final int statusCode = response.statusCode;
          if (url.contains('logout')) {
            await GetStorage().remove('fcmtoken');
            await GetStorage().remove('user_id');
            await GetStorage().remove('access_token');
            await GetStorage().remove('jobId');
          }
          // print("hello url3");
          // print('fgfg$statusCode $res');
          if (statusCode < 200 || statusCode > 400) {
            // showSnackBar(context: context, text: response.body);
            // print('mess${response.body}');
            Get.snackbar('${apiUrl}\nstatusCode:', statusCode.toString(),
                backgroundColor: redColor, colorText: whiteColor);
            return 'Error';
          }

          if (response.body.isEmpty) {
            return "1";
          }

          return _decoder.convert(res);
        });
      } else {
        print("jjjj");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.toNamed(RouteConstant.loginScreen);
        });
      }
    }
  }
}
