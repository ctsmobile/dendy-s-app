// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'dart:developer';

import 'package:dendy_app/Model/activeJobModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ActiveJobController extends GetxController {
  var isDataLoading = false.obs;
  var isClockInTap = false.obs;

  var activeJobModel =
      ActiveJobModel(data: [], message: "null", status: false).obs;
  var iindex = 0.obs;
  var onlyOne = false.obs;
  @override
  void onInit() {
    super.onInit();

    getActiveJobDetails();
  }

  void updateTaskStatus(int index, int taskIndex, int status) {
    activeJobModel.value.data[index].tasks[taskIndex].status = status;
    activeJobModel.refresh(); // Refresh to trigger UI updates
  }

  Future getActiveJobDetails() async {
    isDataLoading.value = true;
    await getActiveJobDetailsApi().then((activeJob) async {
      if (activeJob != null) {
        if (!activeJob.status) {
          showSnackBar(activeJob.message);

          isDataLoading.value = false;
        } else {
          activeJobModel.value = activeJob;
          if (activeJobModel.value.data.length == 1) {
            iindex.value = 0;
            onlyOne.value = true;
            await GetStorage().write('onlyOne', true);
            Get.toNamed(
              RouteConstant.activeJobDetailsScreen,
            );
          } else {
            await GetStorage().write('onlyOne', false);
            isDataLoading.value = false;
          }
        }
      } else {
        if (activeJobModel.value.data.length != 1) {
          isDataLoading.value = false;
        }
      }
    });
  }

  Future<ActiveJobModel?> getActiveJobDetailsApi() async {
    try {
      Post post = Post();
      return await post
          .get(
        'job/list/active',
      )
          .then((dynamic res) async {
        print("active$res");
        if (res == 'Error') {
          return ActiveJobModel.fromJson({});
        } else {
          return ActiveJobModel.fromJson(res!);
        }
      });
    } catch (e) {
      log('Error in active is $e');
    }
  }


   Future clockIn(int jobId,{bool isClockIn=true}) async {
    isClockInTap.value = true;
    await clockInApi(jobId, isClockIn: isClockIn).then((clockInResponse) {
      print("clockInResponse$clockInResponse");
      if (clockInResponse != null) {
        if (!clockInResponse['status']) {
          showSnackBar(clockInResponse['message'].toString());
        
          isClockInTap.value = false;
        } else {
            showSnackBar(clockInResponse['message'].toString(), backgroundColor: purpleColor);
String jobClockInTime =
          DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
            if(isClockIn){
            
      activeJobModel
                                          .value
                                          .data[iindex.value].employees.firstWhere((employee) => 
                                                                                  employee.employeeId ==
                                                                                  GetStorage().read('user_id')as int).clock_in=jobClockInTime;}
                                                                                  else{
                                                                                     
                                                                                    Get.offAllNamed(RouteConstant.dashboardScreen,
           );
                                                                                  }

          isClockInTap.value = false;
        }
      } else {
        isClockInTap.value = false;
      }
    });
  }

  Future clockInApi(int jobId,{bool isClockIn=true}) async {
    try {
      Post post = Post();
 String jobClockInTime =
          DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
      print("jobId: $jobId $jobClockInTime");
       Map data = {
        'clock_in': jobClockInTime,
     
      };
      return await post
          .post(
       isClockIn? 'job/clockin/$jobId':'job/clockout/$jobId',
        body: isClockIn? jsonEncode(data):jsonEncode({ 'clock_out': jobClockInTime,})
      )
          .then((dynamic res) async {
        print("clockin$res");
        if (res == 'Error') {
          return res;
        } else {
          
       return res;
        }
      });
    } catch (e) {
      log('Error in clockInApi is $e');
    } finally {
      isClockInTap(false);
    }
  }

}
