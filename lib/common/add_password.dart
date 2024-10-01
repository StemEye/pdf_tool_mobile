import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

import '../modules/home_bottom/controller/drop_doen_controller.dart';

class AddPassword extends StatelessWidget {
  const AddPassword(
      {super.key, required this.conversionType, required this.filePath});
  final String conversionType;
  final String filePath;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final userPassword = TextEditingController();
    final ownerPassword = TextEditingController();
    //final dropDownController = Get.put(DropDownController());

    return Scaffold(
        appBar: AppBar(
          title: Text("Protect Your Pdf"),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Picked File:${filePath.split('/').last}'),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     controller: ownerPassword,
          //     decoration: InputDecoration(hintText: "Owner Password"),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: ownerPassword,
              decoration: InputDecoration(hintText: "Enter your Password"),
            ),
          ),
          // Obx(() {
          //   return Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //       height: 50,
          //       width: double.infinity,
          //       decoration: BoxDecoration(
          //           border: Border.all(color: MyColors.grey),
          //           borderRadius: BorderRadius.circular(12)),
          //       child: DropdownButton<String>(
          //         value: dropDownController.selectedItem.value,
          //         onChanged: (String? newValue) {
          //           if (newValue != null) {
          //             dropDownController.updateSelectedItem(newValue);
          //           }
          //         },
          // Create the list of dropdown items
          //         underline: SizedBox.shrink(),
          //         items: dropDownController.items
          //             .map<DropdownMenuItem<String>>((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Align(
          //               alignment: Alignment.centerRight,
          //               child: Text(value),
          //             ),
          //           );
          //         }).toList(),
          //       ),
          //     ),
          //   );
          // }),
          ElevatedButton(
              onPressed: () {
                if (conversionType == 'protect pdf') {
                  bool canAssembleDocument = false;
                  bool canExtractContent = false;
                  bool canExtractForAccessibility = false;
                  bool canFillInForm = false;
                  bool canModify = false;
                  bool canModifyAnnotations = false;
                  bool canPrint = false;
                  bool canPrintFaithful = false;
                  //String selectedValue = dropDownController.selectedItem.value;
                  var selectedValue = 128;
                  //String userPassword = 'ab123';

                  homeController.addPassword(
                      filePath,
                      ownerPassword.text,
                      ownerPassword.text,
                      selectedValue,
                      canAssembleDocument,
                      canExtractContent,
                      canExtractForAccessibility,
                      canFillInForm,
                      canModify,
                      canModifyAnnotations,
                      canPrint,
                      canPrintFaithful);
                }
              },
              child: Text('Protect Pdf'))
        ])));
  }
}
