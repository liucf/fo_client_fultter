import 'package:flutter/material.dart';
import 'package:fo/services/http_service.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  var isLoading = true.obs;
  var albumList = [].obs;
  var albumList2 = [].obs;
  @override
  void onInit() {
    fetchAlbums();
    super.onInit();
  }

  void fetchAlbums() async {
    debugPrint("strat http fetching");
    try {
      isLoading(true);

      var albums = await HttpService.fetchAlbums();
      var albums2 = await HttpService.fetchAlbums(categoryid: "12");
      debugPrint("albums fetch result: " + albums.toString());
      albumList.value = albums;
      albumList2.value = albums2;
    } finally {
      isLoading(false);
    }
  }
}
