import 'package:get/get.dart';

class AlquranService extends GetConnect{
  void onInit() {
    httpClient.baseUrl = 'https://api.npoint.io/99c279bb173a6e28359c';
    super.onInit();
  }

  Future<Response<List<dynamic>>> fetchAlquran(){
    return get('/data');
  }
}