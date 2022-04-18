import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fo/controllers/global_state_controller.dart';
import 'package:fo/controllers/login_controller.dart';
import 'package:fo/pages/auth/login_page.dart';
import 'package:fo/pages/dashboard/profile_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fo/payment/wxpay/wx_pay.dart';
import 'package:get/get.dart';

class PricePage extends StatelessWidget {
  PricePage({Key? key}) : super(key: key);
  final GlobalStateController gsc = Get.find();
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Obx(() {
      return gsc.isLoggedIn.isTrue
          ? Scaffold(
              appBar: AppBar(
                title: Text(tr("chooseprice")),
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              body: Column(
                children: [
                  SizedBox(height: height * 0.01),
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        ProfileMenu(
                          text: tr("60fubi"),
                          icon: "assets/icons/coin.svg",
                          press: () => {WxPay.pay()},
                        ),
                        ProfileMenu(
                          text: tr("330fubi"),
                          icon: "assets/icons/coin.svg",
                          press: () => {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : LoginPage();
    });
  }
}
