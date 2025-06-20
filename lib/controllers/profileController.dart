// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:dendy_app/Model/loginModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
      if (auth != null) {
        if (auth.status != true) {
          Get.offAllNamed(RouteConstant.loginScreen);
        } else {
          Get.offAllNamed(RouteConstant.loginScreen);
        }
      }
    });
  }

  Future<LoginModel?> logoutApi() async {
    try {
      isDataLoading(true);

      Post post = Post();
      return await post
          .get(
        'auth/logout',
      )
          .then((dynamic res) async {
        print("logout$res");
        if (res == 'Error') {
          return LoginModel.fromJson({});
        } else {
          return LoginModel.fromJson(res!);
        }
      });
    } catch (e) {
      log('Error in logout is $e');
    } finally {
      isDataLoading(false);
    }
  }


  

Future<void> downloadCSVReport(String startDate, String endDate) async {
  // Ask for storage permission (required for Android)
  // if (Platform.isAndroid) {
  //   var status = await Permission.storage.request();
  //   if (!status.isGranted) {
  //     print('Storage permission not granted');
  //     return;
  //   }
  // }
isDataLoading.value=true;
  final url = Uri.parse('${baseUrl}job/report/downloadCSV?startdate=$startDate&enddate=$endDate');


      var token = GetStorage().read('access_token');
print('hhh$url');
  try {
    final response = await http.get(
      url,
      headers: {
          

           'Authorization': 'Bearer $token',
            },
     
          
    );

    if (response.statusCode == 200) {
      // Get the documents directory
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/report.csv';

      // Write the response body as bytes
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      // print("ggg${response.body}");
      // print('CSV saved to $filePath');
      OpenFile.open(filePath);
    } else {
      print('Failed to download CSV. Status code: ${response.body}');
      showSnackBar(response.body);
    }
     isDataLoading.value=false;
  } catch (e) {
    print('Error: $e');
     isDataLoading.value=false;
      showSnackBar(e.toString());
  }
 
}

}
