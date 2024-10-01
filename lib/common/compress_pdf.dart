import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/drop_doen_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

class CompressPdf extends StatelessWidget {
  const CompressPdf(
      {super.key, required this.conversionType, required this.filePath});
  final String conversionType;
  final String filePath;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final dropDownController = Get.put(DropdownController());
    return Scaffold(
        appBar: AppBar(
          title: Text("Remove Blank Pages"),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Picked File:${filePath.split('/').last}'),
          Obx(() {
            return DropdownButton<int>(
              value: dropDownController.selectedLevel.value,
              onChanged: (int? newValue) {
                if (newValue != null) {
                  dropDownController.updateLevel(newValue);
                }
              },
              items: <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            );
          }),
          ElevatedButton(
              onPressed: () {
                String expectedOutput = '20';
                homeController.compressPdf(filePath,
                    dropDownController.selectedLevel.value, expectedOutput);
              },
              child: Text('Compress'))
        ])));
  }
}
