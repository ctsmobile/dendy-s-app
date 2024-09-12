// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dendy_app/customWidgets/customBottomBar.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/screens/tab_item.dart';
import 'package:dendy_app/screens/tabbarview.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: appThemeColor,
        appBar: AppBar(
          backgroundColor: appThemeColor,
          title: CustomText(
            text: 'Dashboard',
            textColor: purpleColor,
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(46)),
                color: appThemeColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    spreadRadius: 0.0,

                    blurRadius: 3.0,
                    color: innerShadowColor, // darker color
                  ),
                ],
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                padding: EdgeInsets.symmetric(vertical: 7),
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(46)),
                  boxShadow: [
                    BoxShadow(
                      color: innerShadowColor.withOpacity(0.7),
                    ),
                    BoxShadow(
                        color: appThemeColor.withOpacity(0.7),
                        spreadRadius: -2.0,
                        blurRadius: 5.0,
                        offset: Offset(0, 2)),
                    BoxShadow(
                        color: appThemeColor.withOpacity(0.7),
                        spreadRadius: -2.0,
                        blurRadius: 5.0,
                        offset: Offset(0, 2)),
                  ],
                ),
                labelColor: purpleColor,
                unselectedLabelColor: grayColor,
                tabs: [
                  TabItem2(
                    title: 'Pending Jobs',
                  ),
                  TabItem2(
                    title: 'Completed Jobs',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: TabBarView(
            children: [
              // TabBarVieww(),
              TabBarVieww(),
              TabBarVieww(
                isCompletedJobs: true,
              ),
            ],
          ),
        ),
        bottomNavigationBar: CommonBottomBar(
          index: 0,
        ),
      ),
    );
  }
}
