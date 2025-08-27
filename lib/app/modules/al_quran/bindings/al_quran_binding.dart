import 'package:get/get.dart';

import '../controllers/al_quran_controller.dart';

class AlQuranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlQuranController>(
      () => AlQuranController(),
    );
  }
}
