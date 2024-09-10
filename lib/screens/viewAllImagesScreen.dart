// ignore_for_file: prefer_const_constructors

import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewAllImagesScreen extends StatelessWidget {
  const ViewAllImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appThemeColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: MyAppBar(
            title: 'All Images',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  padding: EdgeInsets.only(
                    top: 0,
                  ),
                  // physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: Utils.height! / 6,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 10
                      // childAspectRatio: 4 / 4.5,
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: grayColor,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.asset(
                            '${baseImagePath}image5.png',
                            fit: BoxFit.cover,
                            width: Utils.width! / 3.2,
                            height: Utils.height! / 5.95,

                            // Utils.height! / 3,
                          ),
                        ),
                      ),
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: 'h',
                          pageBuilder: (_, __, ___) {
                            return Material(
                              color: Colors.transparent,
                              child: Center(
                                child: Container(
                                  // Dialog background
                                  width: Utils.width! - 50, // Dialog width
                                  height: 400, // Dialog height

                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          child: Image.asset(
                                            '${baseImagePath}image5.png',
                                            fit: BoxFit.cover,
                                            width: Utils.width! -
                                                50, // Dialog width
                                            height: 400,

                                            // Utils.height! / 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
