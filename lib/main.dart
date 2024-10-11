// ignore_for_file: prefer_const_constructors

import 'package:dendy_app/bindings/dashboardBindings.dart';
import 'package:dendy_app/bindings/loginBinding.dart';
import 'package:dendy_app/firebaseApi.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/screens/dashboardScreen.dart';
import 'package:dendy_app/screens/completeJobDetailsScreen.dart';
import 'package:dendy_app/screens/imageEditorScreen.dart';
import 'package:dendy_app/screens/loginScreen.dart';
import 'package:dendy_app/screens/pendingDetailsScreen.dart';
import 'package:dendy_app/screens/activeJobScreen.dart';
import 'package:dendy_app/screens/profileScreen.dart';
import 'package:dendy_app/screens/splashScreen.dart';
import 'dart:io';

import 'package:dendy_app/screens/uploadImageScreen.dart';
import 'package:dendy_app/screens/uploadImagesViewScreen.dart';
import 'package:dendy_app/screens/viewAllImagesScreen.dart';
import 'package:dendy_app/screens/welcomeScreen.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: 'AIzaSyA9EOJo4kwBp94F9wW5jKdS77o05jJRVpo',
      appId: '1:900401400850:android:009ff627dcc767f8d55ccb',
      messagingSenderId: '900401400850',
      projectId: 'dendyapp',
      storageBucket: 'dendyapp.appspot.com',
    ));
  } else {
    await Firebase.initializeApp();
  }
  await FirebaseAPI().initNotifications();

  // await SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // print("GetStorage().read('user_id')${GetStorage().read('user_id')}");
    Utils.width = MediaQuery.of(context).size.width;
    Utils.height = MediaQuery.of(context).size.height;

    // print(" Utils.height${Utils.height} Utils.width${Utils.width!}");

    // if (Utils.height! < 800) {
    //   Utils.height = Utils.height! - 18;
    // }
    return GetMaterialApp(
        title: "Dendy's App",
        debugShowCheckedModeBanner: false,
        initialRoute: GetStorage().read('user_id') != null
            ? RouteConstant.completeJobDetailsScreen
            : RouteConstant.splashScreen,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: appThemeColor),
          useMaterial3: true,
        ),
        getPages: getPages);
  }
}

List<GetPage> getPages = [
  GetPage(
    name: RouteConstant.splashScreen,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: RouteConstant.welcomeScreen,
    page: () => const WelcomeScreen(),
  ),
  GetPage(
      name: RouteConstant.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding()),
  GetPage(
      name: RouteConstant.dashboardScreen,
      page: () => const DashboardScreen(),
      binding: DashboardBinding()),
  GetPage(
    name: RouteConstant.completeJobDetailsScreen,
    page: () => const CompleteJobDetailsScreen(),
  ),
  GetPage(
    name: RouteConstant.pendingDetailsScreen,
    page: () => const PendingDetailsScreen(),
  ),
  GetPage(
    name: RouteConstant.uploadImageScreen,
    page: () => UploadImageScreen(),
  ),
  GetPage(
    name: RouteConstant.viewAllImagesScreen,
    page: () => ViewAllImagesScreen(),
  ),
  GetPage(
    name: RouteConstant.uploadImagesViewScreen,
    page: () => UploadeImagesViewScreen(),
    // binding: UploadImagesViewController(),
  ),
  GetPage(
    name: RouteConstant.activeJobScreen,
    page: () => ActiveJobScreen(),
  ),
  GetPage(
    name: RouteConstant.profileScreen,
    page: () => ProfileScreen(),
  ),
  GetPage(
    name: RouteConstant.imageEditorScreen,
    page: () => ImageEditorScreen(),
  ),
];
