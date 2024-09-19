abstract class AppRoutes {
  AppRoutes._();

  static const SplashView = Paths.SplashView;
  static const LoggingView = Paths.LoggingView;
  static const HomeView = Paths.HomeView;
  static const FilesView = Paths.FilesView;
  static const ToolsView = Paths.ToolsView;
  static const ScannerView = Paths.SplashView;
  static const SettingView = Paths.SettingView;
}

abstract class Paths {
  Paths._();

  static const SplashView = '/splash';
  static const LoggingView = '/logging';
  static const HomeView = '/home';
  static const FilesView = '/files';
  static const ToolsView = '/tools';
  static const ScannerView = '/scanner';
  static const SettingView = '/setting';
}
