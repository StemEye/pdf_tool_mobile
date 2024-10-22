import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/app.dart';
import 'package:stemeye_pdf_mobile/main_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MainBinding().dependencies();
  runApp(const MyApp());
}
