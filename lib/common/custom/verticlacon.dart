import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stemeye_pdf_mobile/utils/constant/colors.dart';
import 'package:stemeye_pdf_mobile/utils/helpers/helper_function.dart';

class Verticlacon extends StatelessWidget {
  final Color containerColor;
  final String containerName;
  final String conversionIcon; // Add an icon parameter
  final bool isStacked; // New parameter to determine layout
  final VoidCallback ontap;

  const Verticlacon({
    Key? key,
    required this.containerColor,
    required this.containerName,
    required this.conversionIcon, // Initialize the icon parameter
    required this.isStacked,
    required this.ontap,
    // Initialize the layout parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 2,
      ),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          margin: EdgeInsets.only(bottom: 5), // Space between containers
          decoration: BoxDecoration(
            color: containerColor.withOpacity(0.090),
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: isStacked
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        conversionIcon,
                        height: 40,
                        width: 40,
                      ), // Icon at the top
                      SizedBox(
                        height: 30,
                        width: 20,
                      ), // Space between icon and text
                      Text(
                        containerName,
                        style: TextStyle(
                          color: MyColors.black,
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        conversionIcon,
                        height: 50,
                        width: 50,
                      ),
                    ), // Icon at the top
                    // Icon in the center
                    SizedBox(height: 0), // Space between icon and text
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        containerName,
                        style: TextStyle(
                          color: MyColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
