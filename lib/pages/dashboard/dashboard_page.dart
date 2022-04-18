import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fo/controllers/global_state_controller.dart';
import 'package:fo/controllers/login_controller.dart';
import 'package:fo/pages/auth/login_page.dart';
import 'package:fo/pages/dashboard/profile_menu.dart';
import 'package:fo/pages/dashboard/profile_pic.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);
  final GlobalStateController gsc = Get.find();
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Obx(() {
      return gsc.isLoggedIn.isTrue
          ? Column(
              children: [
                SizedBox(height: height * 0.04),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      ProfilePic(),
                      const SizedBox(height: 15),
                      Text(gsc.isLoggedInName),
                      const SizedBox(height: 20),
                      ProfileMenu(
                        text: tr("My Fubi") +
                            "(" +
                            gsc.isLoggedInCredits.value.toString() +
                            ")",
                        icon: "assets/icons/coin.svg",
                        press: () => {Get.toNamed('/prices')},
                      ),
                      // ProfileMenu(
                      //   text: "Notifications",
                      //   icon: "assets/icons/Bell.svg",
                      //   press: () {},
                      // ),
                      // ProfileMenu(
                      //   text: "Settings",
                      //   icon: "assets/icons/Settings.svg",
                      //   press: () {},
                      // ),
                      // ProfileMenu(
                      //   text: "Help Center",
                      //   icon: "assets/icons/Question mark.svg",
                      //   press: () {},
                      // ),
                      ProfileMenu(
                        text: tr("Logout"),
                        icon: "assets/icons/Log out.svg",
                        press: () {
                          loginController.logout();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          : LoginPage();
    });
  }
}
