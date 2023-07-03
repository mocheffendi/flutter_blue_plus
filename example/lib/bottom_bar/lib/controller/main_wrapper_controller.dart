import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/cart_tab.dart';
import '../view/home_tab.dart';
import '../view/profile_tab.dart';
import '../view/statistics_tab.dart';

class MainWrapperController extends GetxController {
  late PageController pageController;

  RxInt currentPage = 0.obs;
  RxBool isDarkTheme = false.obs;

  // String MacAddress = '24:0A:C4:09:89:0A';
  // String deviceUUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";

  List<Widget> pages = [
    const HomeTab(),
    const CartTab(),
    const StatisticsTab(),
    ProfileTab(),
  ];

  ThemeMode get theme => Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void switchTheme(ThemeMode mode) {
    Get.changeThemeMode(mode);
  }

  goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void onInit() async {
    // BluetoothDevice blueDevice = BluetoothDevice.fromId(deviceUUID);
    // blueDevice = BluetoothDevice.fromId(deviceUUID);
    // await blueDevice.connect();
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
