import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stemeye_pdf_mobile/modules/setting_bottom/view/widgets/privacy_policy.dart';
import 'package:stemeye_pdf_mobile/modules/setting_bottom/view/widgets/terms_and_cond.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.blue.withOpacity(0.2),
        ),
        body: Column(
          children: [
            ListTile(
                leading: Icon(Iconsax.shield),
                title: Text("Privacy Policy", style: TextStyle(fontSize: 16)),
                trailing: IconButton(
                    onPressed: () {
                      Get.to(PrivacyPolicy());
                    },
                    icon: Icon(Icons.arrow_forward_ios))),
            ListTile(
                leading: Icon(Iconsax.document),
                title:
                    Text("Terms and Condition", style: TextStyle(fontSize: 16)),
                trailing: IconButton(
                    onPressed: () {
                      Get.to(TermsAndCond());
                    },
                    icon: Icon(Icons.arrow_forward_ios))),
          ],
        ));
  }
}
