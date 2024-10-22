import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final Color bgColor;
  final List<Widget> actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
    this.actions = const [],
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 4), // Space between title and subtitle
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red, // You can adjust the color as needed
              ),
            ),
          ],
        ),
      ),
      actions: actions,
      backgroundColor: bgColor, // You can customize the background color
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(60); // Set preferred height for the AppBar
}
