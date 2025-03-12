// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dendy_app/bindings/dashboardBindings.dart';
import 'package:dendy_app/bindings/loginBinding.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/screens/activeJobListScreen.dart';
import 'package:dendy_app/screens/cameraPreview.dart';
import 'package:dendy_app/screens/dashboardScreen.dart';
import 'package:dendy_app/screens/completeJobDetailsScreen.dart';
import 'package:dendy_app/screens/imageEditorScreen.dart';
import 'package:dendy_app/screens/loginScreen.dart';
import 'package:dendy_app/screens/pendingDetailsScreen.dart';
import 'package:dendy_app/screens/activeJobDetailsScreen.dart';
import 'package:dendy_app/screens/profileScreen.dart';
import 'package:dendy_app/screens/splashScreen.dart';

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

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // requestStoragePermission();
  await GetStorage.init();
  try {
    if (Platform.isIOS) {
      await Firebase.initializeApp(
          //     options: FirebaseOptions(
          //   apiKey: 'AIzaSyCl6OJq48zBZZrfhd8123x4-ghJ1aA04W8',
          //   appId: '1:520035837998:ios:851330b548c711d3c497bf',
          //   messagingSenderId: '520035837998',
          //   projectId: 'dendyapp-1ec3a',
          //   storageBucket: 'dendyapp-1ec3a.firebasestorage.app',
          // )
          );
    } else {
      await Firebase.initializeApp(
          options: FirebaseOptions(
        apiKey: 'AIzaSyBFUeb8FraO8sgbFavCGZQSiT3GToiofys',
        appId: '1:520035837998:android:8f98eec543623eb7c497bf',
        messagingSenderId: '520035837998',
        projectId: 'dendyapp-1ec3a',
        storageBucket: 'dendyapp-1ec3a.firebasestorage.app',
      ));
    }
  } catch (e) {
    // Handle the exception if it is already initialized
    if (e is FirebaseException && e.code == 'duplicate-app') {
      print('Firebase app is already initialized.');
    } else {
      // Handle other exceptions
      print('Firebase initialization error: $e');
    }
  }

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
            ? RouteConstant.dashboardScreen
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
    transition: Transition.noTransition,
  ),
  GetPage(
    name: RouteConstant.welcomeScreen,
    page: () => const WelcomeScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
      name: RouteConstant.loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.noTransition,
      binding: LoginBinding()),
  GetPage(
      name: RouteConstant.dashboardScreen,
      page: () => const DashboardScreen(),
      transition: Transition.noTransition,
      binding: DashboardBinding()),
  GetPage(
    name: RouteConstant.completeJobDetailsScreen,
    page: () => const CompleteJobDetailsScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: RouteConstant.pendingDetailsScreen,
    page: () => const PendingDetailsScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: RouteConstant.uploadImageScreen,
    page: () => UploadImageScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: RouteConstant.viewAllImagesScreen,
    page: () => ViewAllImagesScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: RouteConstant.uploadImagesViewScreen,
    page: () => UploadeImagesViewScreen(),
    transition: Transition.noTransition,
    // binding: UploadImagesViewController(),
  ),
  GetPage(
    name: RouteConstant.activeJobListScreen,
    page: () => ActiveJobListScreen(),
    transition: Transition.noTransition,
    // transitionDuration: Duration(seconds: 3)
  ),
  GetPage(
    name: RouteConstant.activeJobDetailsScreen,
    page: () => ActiveJobDetailsScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: RouteConstant.profileScreen,
    page: () => ProfileScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: RouteConstant.imageEditorScreen,
    page: () => ImageEditorScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: RouteConstant.cameraPreviewScreen,
    page: () => CameraScreen(),
    transition: Transition.noTransition,
  ),
];
