import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/form_pendaftaran_controller.dart';

class FormPendaftaranView extends GetView<FormPendaftaranController> {
  const FormPendaftaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final FormPendaftaranController controller = Get.put(FormPendaftaranController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormPendaftaranView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => TextField(
              onChanged: (value) {
                controller.name.value = value;
                controller.validateName(name: value);
              },
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                errorText: controller.namaError.value.isNotEmpty ?
                controller.namaError.value : null,
              ),
            )),
            SizedBox(height: 20,),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.gender.value.isEmpty ? null : controller.gender.value,
              hint: Text('Pilih Jenis Kelamin'),
              items: ['Laki-Laki', 'Perempuan']
              .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
              .toList(),
              onChanged: (value) {
                controller.gender.value = value ?? '' ;
                controller.validateGender(jenisKelamin: value);
              },
              decoration: InputDecoration(
                errorText: controller.genderError.value.isNotEmpty ?
                controller.genderError.value : null,
              ),
            )),
            SizedBox(height: 20,),
            Obx(() => ListTile(
              title: Text(
                controller.dateOfbirth.value == null ? 'Pilih Tanggal Lahir' : DateFormat('dd-MM-yyyy').format(controller.dateOfbirth.value!),
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  controller.dateOfbirth.value = selectedDate;
                  controller.validateDateOfBirth(tanggalLahir: selectedDate);
                }
              },
              subtitle: controller.dateOfbirthError.value.isEmpty
              ? Text(
                controller.dateOfbirthError.value,
                style: TextStyle(color: Colors.red),
              ) : null,
            )),
            SizedBox(height: 20,),

            Obx(() => TextField(
              onChanged: (value) {
                controller.phone.value = value;
                controller.validatePhone(phone: value);
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Nomor Telepon',
                errorText:  controller.phoneError.value.isEmpty ? 
                null : controller.phoneError.value,
              ),
            )),
            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: () {
                controller.submitForm();
              },
              child: Text('Submit'),
            )
          ],
        ),
      )
    );
  }
}