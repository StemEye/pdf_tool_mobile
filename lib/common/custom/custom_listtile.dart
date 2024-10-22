import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        child: Row(
          children: [
            // Leading icon/widget if provided
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 16), // Space between leading and title
            ],

            // Expanded to take up remaining space for title and subtitle

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title widget
                  title,

                  // Subtitle widget if provided
                  if (subtitle != null) ...[
                    const SizedBox(
                        height: 0), // Space between title and subtitle
                    subtitle!,
                  ],
                ],
              ),
            ),

            // Trailing icon/widget if provided
            if (trailing != null) ...[
              const SizedBox(
                  width: 0), // Space between title/subtitle and trailing
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
