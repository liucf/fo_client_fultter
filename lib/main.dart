import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fo/controllers/audio_controller.dart';
import 'package:fo/controllers/login_controller.dart';
import 'package:fo/pages/detail/detail_page.dart';
import 'package:fo/pages/home/home_page.dart';
import 'package:fo/pages/list/list_page.dart';
import 'package:fo/pages/player/player_page.dart';
import 'package:fo/pages/search/search_page.dart';
import 'package:fo/widgets/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'controllers/global_state_controller.dart';
import 'controllers/search_controller.dart';
import 'pages/price/price_page.dart';
import 'themes/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: const [Locale('zh', ''), Locale('en', '')],
    fallbackLocale: const Locale('zh', ''),
    child: const MainMateriaApp(),
  ));
}

class MainMateriaApp extends StatelessWidget {
  const MainMateriaApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalStateController gsc = Get.put(GlobalStateController());
    Get.put(LoginController());
    Get.put(AudioController());
    Get.put(SearchController());
    gsc.autoLogIn();

    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/details', page: () => DetailPage()),
        GetPage(name: '/player', page: () => PlayerPage()),
        GetPage(name: '/prices', page: () => PricePage()),
        GetPage(name: '/list', page: () => ListPage()),
        GetPage(name: '/search', page: () => SearchPage()),
      ],
      home: MyBottomNavigationBar(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
