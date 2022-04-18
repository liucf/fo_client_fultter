import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalStateController extends GetxController {
  var pageIndex = 0.obs;
  var isLoggedIn = false.obs;
  var isLoggedInName = "";
  var isLoggedInToken = "";
  var isLoggedInAvatar = "";
  var isLoggedInCredits = 0.obs;
  var currentPlayingAlbumImage = "".obs;
  var currentIsPlaying = false.obs;
  var currentPlayingID = "1".obs;
  var currentPlayingAlbumID = "1".obs;
  var currentPlayingDuration = 0.obs;
  var currentPlayingPosition = 0.obs;

  var pageTitle = ["佛经", "我的"];
  var pageAppBarLeft = [
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search),
    ),
  ];

  var pageAppBarRight = [
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.waves),
    ),
  ];

  changePageIndex(index) {
    pageIndex.value = index;
    debugPrint(pageIndex.value.toString());
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    final String userId = prefs.getString('user_id') ?? "";
    if (userId != "") {
      isLoggedIn.value = true;
      isLoggedInName = prefs.getString('user_name') ?? "";
      isLoggedInToken = prefs.getString('user_token') ?? "";
      isLoggedInAvatar = prefs.getString('user_avatar') ?? "";
      isLoggedInCredits.value = prefs.getString('user_credits') != null
          ? int.parse(prefs.getString('user_credits').toString())
          : 0;
    }
  }

  void autoLogOut() async {
    isLoggedIn.value = false;
    isLoggedInName = "";
    isLoggedInToken = "";
    isLoggedInAvatar = "";
    isLoggedInCredits.value = 0;
  }
}
