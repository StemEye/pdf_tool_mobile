import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stemeye_pdf_mobile/utils/helpers/helper_function.dart';

class CustomContainerVer extends StatelessWidget {
  const CustomContainerVer(
      {super.key, required this.containerColor, required this.containerName});
  final Color containerColor;
  final String containerName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 10), // Space between containers

        // height: MyHelperFunctions.screenHeight() * 0.12,
        // width: MyHelperFunctions.screenWidth() * 0.27,
        decoration: BoxDecoration(
            color: containerColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.all(20), // Padding inside the container
        child: Center(
          child: Text(
            containerName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
