import 'package:bottom_bar/view/home_tab.dart';
import 'package:bottom_bar/view/screen_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../controller/main_wrapper_controller.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();

  @override
  void initState() {
    super.initState();
    InitialScreenBindings();
    // Get.lazyPut<MainWrapperController>(() => MainWrapperController(),
    // fenix: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              _mainWrapperController.goToTab(0);
            },
            // Get.to(const HomeTab()),
            // _mainWrapperController.goToTab(0),
            child: const Text('go')),
        Text(
          "About",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const Icon(
          IconlyLight.profile,
          size: 40,
        ),
      ],
    );
  }
}
