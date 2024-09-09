import 'package:dendy_app/routes.dart';
import 'package:dendy_app/screens/dashboardScreen.dart';
import 'package:dendy_app/screens/loginScreen.dart';
import 'package:dendy_app/screens/splashScreen.dart';
import 'package:dendy_app/screens/welcomeScreen.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
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
        initialRoute: RouteConstant.dashboardScreen,
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
  ),
  GetPage(
    name: RouteConstant.dashboardScreen,
    page: () => const DashboardScreen(),
  ),
];
