import 'package:fo/pages/dashboard/dashboard_page.dart';
import 'package:fo/pages/home/home_page.dart';
import 'package:get/get.dart';

class AppPages {
  static var list = [
    GetPage(name: '/', page: () => HomePage()),
    GetPage(name: '/my', page: () => DashboardPage()),
  ];
}
