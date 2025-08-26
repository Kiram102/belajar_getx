import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ResultsScreenView extends GetView {
  const ResultsScreenView({
    super.key,
    required this.name,
    required this.gender,
    required this.dateOfbirth,
    required this.phone,
  });

  final String name;
  final String gender;
  final DateTime dateOfbirth;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResultsScreenView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(name),
          Text(gender),
          Text(DateFormat('dd-MM-yyyy').format(dateOfbirth)),
          Text(phone),
        ],
      )
    );
  }
}
