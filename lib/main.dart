import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/dependncy.dart';
import 'package:dialogi_app/services/socket_service.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'helper/prefs_helper.dart';


Future<void> configureTts() async {
  FlutterTts flutterTts = FlutterTts();
  await flutterTts.setLanguage('en-US');
  await flutterTts.setSpeechRate(0.4);
  await flutterTts.setVolume(1.0);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51NsL1qAGQlA3WKiIICnGloioSLGGq9pH7mBRb57na8QHzGKDycj9Fy08rkT6AEg8PwyBOzJZLFImpYV9KOAczU1p00THCcecwL';
  await dotenv.load(fileName: "assets/.env");

  DependencyInjection dI = DependencyInjection();
  dI.dependencies();
  configureTts();
  await PrefsHelper.getAllPrefData() ;
  // await MobileAds.instance.initialize() ;
  SocketServices.connectToSocket();
  runApp(const MyApp());

  /* runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//
//
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColors.background),
        debugShowCheckedModeBanner: false,
        title: 'Dialogi App',
        initialRoute: AppRoutes.splashScreen,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
