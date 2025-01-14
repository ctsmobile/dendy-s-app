// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dendy_app/controllers/jobDetailsController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAllImagesScreen extends StatelessWidget {
  const ViewAllImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JobDetailsController controller = Get.put(JobDetailsController());
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
                  itemCount: controller.forInitialImages.value
                      ? controller.jobDetailsModel.data!.startimage.length
                      : controller.jobDetailsModel.data!.endimage.length,
                  padding: EdgeInsets.only(
                    top: 0,
                  ),
                  // physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: Utils.height! / 7.3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20
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
                            child: CachedNetworkImage(
                              imageUrl: controller.forInitialImages.value
                                  ? 'https://dendyapp.chawtechsolutions.ch/public/${controller.jobDetailsModel.data!.startimage[index].imageUrl}'
                                  : 'https://dendyapp.chawtechsolutions.ch/public/${controller.jobDetailsModel.data!.endimage[index].imageUrl}',
                              fit: BoxFit.cover,
                              width: Utils.width! / 4,
                              height: Utils.height! / 7.3,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                    color: purpleColor),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )),
                      ),
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: 'Dismiss',
                          pageBuilder: (_, __, ___) {
                            return Center(
                              child: SizedBox(
                                // Dialog background
                                width: 250, // Dialog width
                                height: 400, // Dialog height

                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: controller
                                                    .forInitialImages.value
                                                ? 'https://dendyapp.chawtechsolutions.ch/public/${controller.jobDetailsModel.data!.startimage[index].imageUrl}'
                                                : 'https://dendyapp.chawtechsolutions.ch/public/${controller.jobDetailsModel.data!.endimage[index].imageUrl}',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  color: purpleColor),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )),
                                    ],
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
