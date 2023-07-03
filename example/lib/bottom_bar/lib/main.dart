import 'dart:io';

import 'package:bottom_bar/view/screen_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controller/main_wrapper_controller.dart';
import 'main_wrapper.dart';
import 'utils/themes.dart';

/////////////////////////////////
// 🔥 CodeWithFlexz on Instagram

// 🚀 AmirBayat0 on Github
// 👽 Programming with Flexz on Youtube
////////////////////////////////

void main() {
  if (Platform.isAndroid) {
    // WidgetsFlutterBinding.ensureInitialized();
    InitialScreenBindings().dependencies();
    [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request().then((status) {
      runApp(const FlutterBlueApp());
    });
  } else {
    runApp(const FlutterBlueApp());
  }
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
}

class FlutterBlueApp extends StatelessWidget {
  const FlutterBlueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialScreenBindings(),
      title: 'Bottom AppBar',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: Get.put(MainWrapperController()).theme,
      home: MainWrapper(),
    );
  }
}
