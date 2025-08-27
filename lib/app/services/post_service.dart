import 'package:get/get.dart';

class PostService extends GetConnect{
  void onInit() {
    httpClient.baseUrl = 'https://jsonplaceholder.typicode.com';
    super.onInit();
  }

  Future<Response<List<dynamic>>> fetchPosts(){
    return get('/posts');
  }
}