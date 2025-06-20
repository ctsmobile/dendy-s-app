// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:dendy_app/controllers/profileController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customBottomBar.dart';
import 'package:dendy_app/customWidgets/customLoader.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/dateSelection.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: appThemeColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: MyAppBar(
            title: 'Profile',
            isLeading: false,
          )),
      body: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(RouteConstant.dashboardScreen);

          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Card(
                            elevation: 3,
                            color: appThemeColor,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, left: 20, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        '${baseImagePath}profilee2.png',
                                        height: Utils.height! / 20,
                                        width: Utils.width! / 10,
                                      ),
                                      SizedBox(
                                        width: Utils.width! / 20,
                                      ),
                                      CustomText(
                                        text: GetStorage()
                                            .read('username')
                                            .toString(),
                                        textColor: purpleColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        '${baseImagePath}inbox.png',
                                        height: Utils.height! / 20,
                                        width: Utils.width! / 10,
                                      ),
                                      SizedBox(
                                        width: Utils.width! / 20,
                                      ),
                                      CustomText(
                                        text: GetStorage()
                                            .read('email')
                                            .toString(),
                                        textColor: purpleColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        '${baseImagePath}call.png',
                                        height: Utils.height! / 20,
                                        width: Utils.width! / 10,
                                      ),
                                      SizedBox(
                                        width: Utils.width! / 20,
                                      ),
                                      CustomText(
                                        text: GetStorage()
                                            .read('mobile')
                                            .toString(),
                                        textColor: purpleColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment: GetStorage()
                                                .read('profile_summary')
                                                .toString()
                                                .length <
                                            30
                                        ? CrossAxisAlignment.center
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        '${baseImagePath}summary.png',
                                        height: Utils.height! / 20,
                                        width: Utils.width! / 10,
                                      ),
                                      SizedBox(
                                        width: Utils.width! / 20,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          text: GetStorage()
                                              .read('profile_summary')
                                              .toString(),
                                          textColor: purpleColor,
                                        ),
                                      )
                                    ],
                                  ),

                                   SizedBox(
                                    height: 20,
                                  ),
                              Obx(()=>    GestureDetector(
                                    child: Row(
                                     
                                      children: [
                                        Image.asset(
                                          '${baseImagePath}export.png',
                                          height: Utils.height! / 20,
                                          width: Utils.width! / 10,
                                        ),
                                        SizedBox(
                                          width: Utils.width! / 20,
                                        ),
                                        Flexible(
                                          child: Container(
                                                                                 
                                                              // height: 50,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                  color: purpleColor),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: CustomText(
                                                                  text: 'View My Timestamp',
                                                                  textColor: whiteColor,
                                                                ),
                                                              ),),
                                        ),
                                          SizedBox(
                                          width: Utils.width! / 20,
                                        ),
                                      controller.isDataLoading.value?  Loader(color: purpleColor,):SizedBox()
                                      ],
                                    ),
                                    onTap: (){
                          
  showDialog(
    context: context,
    builder: (_) => DateRangeDialog(
      onDateRangeSelected: (start, end) {
        print('Selected range: $start to $end');
        controller.downloadCSVReport(DateFormat('MM/dd/yyyy').format(start),DateFormat('MM/dd/yyyy').format(end));
        // Trigger your CSV download here if needed
      },
    ),
  );


                                      // controller.downloadCSVReport();
                                    },
                               ) ),
                                  SizedBox(
                                    height: Utils.height! / 3,
                                  ),
                                ],
                              ),
                            )),
                        Positioned(
                          bottom: -50,
                          child: Container(
                            width: 230,
                            height: 100,
                            margin: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 3,
                            ),
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border(
                                  top: BorderSide(
                                      color: appThemeColor, width: 7)),
                              boxShadow: [
                                BoxShadow(
                                    color: innerShadowColor.withOpacity(0.9),
                                    offset: Offset(-1, -2)),
                                BoxShadow(
                                    color: innerShadowColor.withOpacity(0.9),
                                    offset: Offset(1, -2)),
                                BoxShadow(
                                    color: appThemeColor,
                                    spreadRadius: 1.0,
                                    blurRadius: 1.0,
                                    offset: Offset(0, 0)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
                Positioned(
                  bottom: 30,
                  child: Container(
                    width: 210,
                    // height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: purpleColor),
                    child: CupertinoButton(
                      onPressed: () async {
                        return showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: Text('Confirm logout'),
                            content: Text('Are you sure you want to logout?'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                // isDefaultAction: true,
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: purpleColor),
                                ),
                                onPressed: () async {
                                  controller.logout();
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text(
                                  "No",
                                  style: TextStyle(color: purpleColor),
                                ),
                                onPressed: () async {
                                  Get.back();
                                },
                              )
                            ],
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          "Logout",
                          style: GoogleFonts.amaranth(
                            color: appThemeColor,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CommonBottomBar(
        index: 2,
      ),
    );
  }
}
