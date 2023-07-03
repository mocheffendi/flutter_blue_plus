import 'package:bottom_bar/controller/main_wrapper_controller.dart';
import 'package:get/get.dart';

class InitialScreenBindings implements Bindings {
  // String tag;

  // InitialScreenBindings({required this.tag});

  @override
  void dependencies() {
    Get.lazyPut<MainWrapperController>(() => MainWrapperController(),
        fenix: true);
    // Get.lazyPut(() => BottomNavigationController(), tag: tag);
    // Get.lazyPut(() => HomeController(), tag: tag);
    // Get.lazyPut(() => OrderController(), tag: tag);
    // Get.lazyPut(() => CartController(), tag: tag);
    // Get.lazyPut(() => ProfileController(), tag: tag);
  }
}
