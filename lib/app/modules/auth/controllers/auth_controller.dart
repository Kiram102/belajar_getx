import 'package:belajar_getx/app/routes/app_pages.dart';
import 'package:belajar_getx/app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final AuthService api = AuthService();
  final box = GetStorage();

  var isloading = false.obs;

  Future<void> login(String email, String password) async {
    isloading.value = true;
    final res = await api.login(email,password);
    isloading.value = false;

    if (res.statusCode == 200) {
      final token = res.body['access_token'];
      box.write('access_token', token);
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar("Error", res.body['message'] ?? "Login gagal");
    }
  }

  Future<void> register(String name, String email, String password) async {
    isloading.value = true;
    final res = await api.register(name, email, password);
    isloading.value = false;

    if (res.statusCode == 201) {
      Get.snackbar("Success", "Register berhasil");
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.snackbar("Error", res.body.toString());
    }
  }

  Future<void> logout() async {
    isloading.value = true;
    
    // Ambil token dengan key yang benar
    final token = box.read('access_token'); // Perbaiki dari 'token' ke 'access_token'
    
    if (token != null) {
      try {
        await api.logout(token);
        Get.snackbar("Success", "Logout berhasil");
      } catch (e) {
        print('Logout API error: $e');
        // Tetap lanjut hapus token meski API error
        Get.snackbar("Warning", "Logout dari server gagal, tapi session lokal dihapus");
      }
    }
    
    // Hapus token dari storage dengan key yang benar
    box.remove('access_token'); // Perbaiki dari 'token' ke 'access_token'
    
    isloading.value = false;
    Get.offAllNamed(Routes.LOGIN);
  }
}