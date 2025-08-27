import 'package:belajar_getx/app/data/models/al_quran.dart';
import 'package:belajar_getx/app/services/alquran_service.dart';
import 'package:get/get.dart';

class AlQuranController extends GetxController {
  final AlquranService _alquranService = Get.put<AlquranService>(AlquranService());
  

  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  RxList alqurans = <AlquranModel>[].obs; 

  @override
  void onInit() {
    super.onInit();
    fetchAlquran();
  }

  void fetchAlquran() async {
    try {
      isLoading(true);
      errorMessage('');
      final response = await _alquranService.fetchAlquran();
      if (response.statusCode == 200) {
        var data = response.body!
        .map((miaw) => AlquranModel.fromJson(miaw))
        .toList();
        alqurans.assignAll(data);
      } else {
        errorMessage('Error: ${response.statusText}');
      }
    } catch (e) {
      errorMessage('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

}
