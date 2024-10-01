import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

class UserAddFile extends StatelessWidget {
  const UserAddFile(
      {super.key, required this.conversionType, required this.filePath});
  final String conversionType;
  final String filePath;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text("Picked File"),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Picked File:${filePath.split('/').last}'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(hintText: "Enter your password"),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (conversionType == 'remove password') {
                  homeController.removePassword(
                      filePath, passwordController.text);
                }
              },
              child: Text('Remove password'))
        ])));
  }
}
