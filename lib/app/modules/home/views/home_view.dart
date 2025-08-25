import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home View Is Working', style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => Get.toNamed('/counter'),
              child: Text('Go to counter'),
            )
          ],
        ),
      ),
    );
  }
}
