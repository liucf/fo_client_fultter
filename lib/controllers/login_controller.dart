import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fo/services/http_service.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'global_state_controller.dart';

class LoginController extends GetxController {
  var isButtonEnable = false.obs;
  var isCounting = false.obs;
  var buttonText = '发送验证码'.obs;
  int count = 60;
  var isSubmitButtonEnable = false.obs;
  var validateCode = "0000".obs;
  var validatePhoneNumber = "".obs;

  void clickSendSMS(phonenumber) {
    if (isButtonEnable.isTrue) {
      isButtonEnable.value = false;
      _initTimer();
      var postphonenumber = phonenumber.replaceAll(' ', '');
      validatePhoneNumber.value = postphonenumber;
      fetchLoginSMS(postphonenumber);
    }
  }

  void fetchLoginSMS(phonenumber) async {
    var loginSMSesponse =
        await HttpService.fetchLoginSMS(phonenumber.toString());
    Map<String, dynamic> map = jsonDecode(loginSMSesponse);
    debugPrint(map['result'].toString());
    if (map['result'] == 0) {
      debugPrint(map['code'].toString());
      validatePhoneNumber.value = map['phonenumber'];
      validateCode.value = map['code'].toString();
    } else {
      debugPrint(map['errmsg'].toString());
      Get.snackbar(
        "Error",
        map['errmsg'].toString(),
        icon: const Icon(Icons.error_outline_rounded, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }

  void login() async {
    var loginResponse = await HttpService.login(validatePhoneNumber.value);
    Map<String, dynamic> map = jsonDecode(loginResponse);
    final GlobalStateController gsc = Get.find();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', map['id'].toString());
    prefs.setString('user_name', map['name']);
    prefs.setString('user_token', map['token']);
    prefs.setString('user_avatar', map['avatar']);
    prefs.setString('user_credits', map['credit'].toString());
    gsc.autoLogIn();
  }

  void logout() async {
    final GlobalStateController gsc = Get.find();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', "");
    prefs.setString('user_name', "");
    prefs.setString('user_token', "");
    prefs.setString('user_avatar', "");
    prefs.setString('user_credits', "");
    gsc.autoLogOut();
  }

  void _initTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      count--;
      if (count == 0) {
        timer.cancel(); //倒计时结束取消定时器
        isButtonEnable.value = true; //按钮可点击
        count = 60; //重置时间
        buttonText.value = '发送验证码'; //重置按钮文本
        isCounting.value = false;
      } else {
        isCounting.value = true;
        buttonText.value = '重新发送($count)';
      }
    });
  }
}
