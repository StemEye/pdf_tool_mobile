abstract class AppRoutes {
  AppRoutes._();

  static const SplashView = Paths.SplashView;
  static const LoggingView = Paths.LoggingView;
  static const HomeView = Paths.HomeView;
  static const NavbarView = Paths.NavbarView;
  static const FilesView = Paths.FilesView;
  static const ToolsView = Paths.ToolsView;
  static const FavoriteView = Paths.FavoriteView;
  static const SettingView = Paths.SettingView;
}

abstract class Paths {
  Paths._();

  static const SplashView = '/splash';
  static const LoggingView = '/logging';
  static const HomeView = '/home';
  static const NavbarView = '/navbar';
  static const FilesView = '/files';
  static const ToolsView = '/tools';
  static const FavoriteView = '/scanner';
  static const SettingView = '/setting';
}
