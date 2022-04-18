import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fo/services/http_service.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'global_state_controller.dart';

class SearchController extends GetxController {
  var keyword = "".obs;
  var isLoading = false.obs;
  var resultList = [].obs;
  var historyList = [].obs;

  @override
  void onInit() {
    fetchHistory();
    super.onInit();
  }

  void fetchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List? historyListShared = prefs.getStringList('history_list_shared');
    if (historyListShared != null) {
      historyList.value = historyListShared;
    }
    debugPrint(historyList.toString());
  }

  void search() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final List? historyListShared = prefs.getStringList('history_list_shared');

    if (keyword.trim() == "") {
      resultList.value = [];
      return;
    }
    try {
      isLoading(true);
      if (!historyList.contains(keyword.trim())) {
        historyList.add(keyword.trim().toString());
        var currentList = prefs.getStringList("history_list_shared") ?? [];
        currentList.add(keyword.trim().toString());
        prefs.setStringList('history_list_shared', currentList);
      }

      var albumResponse = await HttpService.search(keyword.trim());
      resultList.value = albumResponse.fojings;
      debugPrint(keyword.value.toString());
    } finally {
      isLoading(false);
    }
  }
  // void clickSearch(phonenumber) {
  //   if (isButtonEnable.isTrue) {
  //     isButtonEnable.value = false;
  //     _initTimer();
  //     var postphonenumber = phonenumber.replaceAll(' ', '');
  //     validatePhoneNumber.value = postphonenumber;
  //     fetchLoginSMS(postphonenumber);
  //   }
  // }

  // void fetchLoginSMS(phonenumber) async {
  //   var loginSMSesponse =
  //       await HttpService.fetchLoginSMS(phonenumber.toString());
  //   Map<String, dynamic> map = jsonDecode(loginSMSesponse);
  //   debugPrint(map['result'].toString());
  //   if (map['result'] == 0) {
  //     debugPrint(map['code'].toString());
  //     validatePhoneNumber.value = map['phonenumber'];
  //     validateCode.value = map['code'].toString();
  //   } else {
  //     debugPrint(map['errmsg'].toString());
  //     Get.snackbar(
  //       "Error",
  //       map['errmsg'].toString(),
  //       icon: const Icon(Icons.error_outline_rounded, color: Colors.white),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       borderRadius: 20,
  //       margin: const EdgeInsets.all(15),
  //       colorText: Colors.white,
  //       duration: const Duration(seconds: 4),
  //       isDismissible: true,
  //       dismissDirection: DismissDirection.horizontal,
  //       forwardAnimationCurve: Curves.easeOutBack,
  //     );
  //   }
  // }

  // void login() async {
  //   var loginResponse = await HttpService.login(validatePhoneNumber.value);
  //   Map<String, dynamic> map = jsonDecode(loginResponse);
  //   final GlobalStateController gsc = Get.find();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('user_id', map['id'].toString());
  //   prefs.setString('user_name', map['name']);
  //   prefs.setString('user_token', map['token']);
  //   prefs.setString('user_avatar', map['avatar']);
  //   prefs.setString('user_credits', map['credit'].toString());
  //   gsc.autoLogIn();
  // }

  // void logout() async {
  //   final GlobalStateController gsc = Get.find();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('user_id', "");
  //   prefs.setString('user_name', "");
  //   prefs.setString('user_token', "");
  //   prefs.setString('user_avatar', "");
  //   prefs.setString('user_credits', "");
  //   gsc.autoLogOut();
  // }

  // void _initTimer() {
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     count--;
  //     if (count == 0) {
  //       timer.cancel(); //倒计时结束取消定时器
  //       isButtonEnable.value = true; //按钮可点击
  //       count = 60; //重置时间
  //       buttonText.value = '发送验证码'; //重置按钮文本
  //       isCounting.value = false;
  //     } else {
  //       isCounting.value = true;
  //       buttonText.value = '重新发送($count)';
  //     }
  //   });
  // }
}
