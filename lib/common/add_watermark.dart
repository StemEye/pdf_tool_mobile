import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';

class AddWatermark extends StatelessWidget {
  const AddWatermark(
      {super.key, required this.conversionType, required this.filePath});
  final String conversionType;
  final String filePath;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final watermarkController = TextEditingController();
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
              controller: watermarkController,
              decoration: InputDecoration(hintText: "Enter watermark text"),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (conversionType == 'add watermark') {
                  String watermarkType = '';
                  String watermarkText = watermarkController.text;
                  String watermarkImage = '';
                  String alphabet = '';
                  double fontSize = 30;
                  double rotation = 45;
                  double opacity = 50;
                  int widthSpacer = 50;
                  int heightSpacer = 50;
                  bool convertPDFToImage = true;
                  homeController.addWatermark(
                      filePath,
                      watermarkType,
                      watermarkText,
                      watermarkImage,
                      alphabet,
                      fontSize,
                      rotation,
                      opacity,
                      widthSpacer,
                      heightSpacer,
                      convertPDFToImage);
                }
              },
              child: Text('$conversionType'))
        ])));
  }
}


 // Obx(() {
          //   return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //           height: 50,
          //           width: double.infinity,
          //           decoration: BoxDecoration(
          //             color: Colors.white, // White background
          //             border: Border.all(
          //               color: dropDownController.isFocused.value
          //                   ? Colors.blue // Blue border when focused
          //                   : MyColors.grey, // Grey border when not focused
          //               width: 1.5,
          //             ),
          //             borderRadius: BorderRadius.circular(8), // Rounded corners
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Colors.black.withOpacity(0.1),
          //                 blurRadius: 4,
          //                 offset: Offset(0, 2), // Subtle shadow
          //               ),
          //             ],
          //           ),
          //           child: Focus(
          //               onFocusChange: (hasFocus) {
          //                 dropDownController
          //                     .setFocus(hasFocus); // Set focus state
          //               },
          //               child: DropdownButtonHideUnderline(
          //                 child: DropdownButton<String>(
          //                   isExpanded: true, // Full width for dropdown
          //                   value: dropDownController.selectedItem.value.string,
          //                   onChanged: (String? newValue) {
          //                     if (newValue != null) {
          //                       dropDownController.updateSelectedItem(newValue);
          //                     }
          //                   },
          //                   icon: Icon(Icons.arrow_drop_down,
          //                       color: Colors.grey), // Dropdown icon
          //                   dropdownColor:
          //                       Colors.white, // Dropdown background color
          //                   items: dropDownController.items
          //                       .map<DropdownMenuItem<String>>((String value) {
          //                     return DropdownMenuItem<String>(
          //                       value: value,
          //                       child: Text(
          //                         value,
          //                         style: TextStyle(
          //                           color: MyColors.black, // Text color
          //                           fontSize: 16,
          //                         ),
          //                       ),
          //                     );
          //                   }).toList(),
          //                   hint: Text(
          //                     "Select your watermark type", // Hint text when nothing is selected
          //                     style: TextStyle(
          //                       color: Colors.grey, // Hint text color
          //                       fontSize: 16,
          //                     ),
          //                   ),
          //                 ),
          //               ))));
          // }),
