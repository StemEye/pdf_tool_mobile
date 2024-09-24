import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/data/network/api_interceptor.dart';
import 'package:stemeye_pdf_mobile/data/network/api_provider.dart';
import 'package:stemeye_pdf_mobile/modules/bottom_nav_bar/binding/navbar_binding.dart';
import 'package:stemeye_pdf_mobile/modules/bottom_nav_bar/view/navbar_view.dart';
import 'package:stemeye_pdf_mobile/modules/file_bottom/binding/files_binding.dart';
import 'package:stemeye_pdf_mobile/modules/file_bottom/view/files_view.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/binding/home_binding.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/view/home_view.dart';
import 'package:stemeye_pdf_mobile/modules/logging/binding/logging_binding.dart';
import 'package:stemeye_pdf_mobile/modules/logging/view/logging_view.dart';
import 'package:stemeye_pdf_mobile/modules/favorite_bottom/binding/fav_binding.dart';
import 'package:stemeye_pdf_mobile/modules/favorite_bottom/view/favorite_view.dart';
import 'package:stemeye_pdf_mobile/modules/setting_bottom/binding/setting_binding.dart';
import 'package:stemeye_pdf_mobile/modules/setting_bottom/view/setting_view.dart';
import 'package:stemeye_pdf_mobile/modules/splash/binding/splash_binding.dart';
import 'package:stemeye_pdf_mobile/modules/splash/view/splash_view.dart';
import 'package:stemeye_pdf_mobile/modules/tools_bottom/binding/tools_binding.dart';
import 'package:stemeye_pdf_mobile/modules/tools_bottom/view/tools_view.dart';
import 'package:stemeye_pdf_mobile/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = AppRoutes.SplashView;

  static final approutes = [
    GetPage(
        name: Paths.SplashView,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: Paths.LoggingView,
        page: () => const LoggingView(),
        binding: LoggingBinding()),
    GetPage(
        name: Paths.NavbarView,
        page: () => const NavbarView(),
        binding: NavbarBinding()),
    GetPage(
        name: Paths.HomeView, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
        name: Paths.FilesView,
        page: () => const FilesView(),
        binding: FilesBinding()),
    GetPage(
        name: Paths.ToolsView,
        page: () => const ToolsView(),
        binding: ToolsBinding()),
    GetPage(
        name: Paths.FavoriteView,
        page: () => const FavoriteView(),
        binding: FavBinding()),
    GetPage(
        name: Paths.SettingView,
        page: () => const SettingView(),
        binding: SettingBinding()),
  ];
}
