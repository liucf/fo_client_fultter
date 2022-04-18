import 'package:flutter/material.dart';
import 'package:fo/services/http_service.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class ListController extends GetxController {
  var isLoading = true.obs;
  var allLoaded = false.obs;
  var albumList = [].obs;
  var albumPage = 1.obs;
  var listName = "".obs;
  var categoryId = "0";

  ListController(categoryid) {
    // debugPrint(categoryid.toString() + "in controller");
    categoryId = categoryid;
    if (categoryId == "2") {
      listName.value = tr("foying");
    } else if (categoryId == "12") {
      listName.value = tr("foshu");
    }
  }

  @override
  void onInit() {
    fetchAlbum();
    super.onInit();
  }

  void fetchAlbum() async {
    // debugPrint(categoryId.toString() + "in fetchAlbum");
    if (allLoaded.isTrue) {
      return;
    }
    try {
      isLoading(true);
      var albums = await HttpService.fetchAlbums(
          categoryid: categoryId, page: albumPage.value);
      allLoaded(albums.isEmpty);
      if (albumList.isEmpty) {
        albumList.value = albums;
      } else {
        albumList.addAll(albums);
      }
      // debugPrint(albumList[0].describe.toString());
    } finally {
      isLoading(false);
    }
  }
}
