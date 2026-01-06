import 'package:get/get.dart';
import 'package:webean/controller/getx.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController(), permanent: true);
  }
}
