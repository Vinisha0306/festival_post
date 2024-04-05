import 'package:festival_post/header.dart';

class AppRoutes {
  static String splash_screens = '/';
  static String home_page = 'home_page';
  static String all_post_page = 'all_post_page';
  static String editor_page = 'editor_page';

  static Map<String, WidgetBuilder> routes = {
    splash_screens: (context) => const SplashScreens(),
    home_page: (context) => const HomePage(),
    all_post_page: (context) => const All_Post_Page(),
    editor_page: (context) => const EditorPage(),
  };
}
