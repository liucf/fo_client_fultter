import 'package:fo/models/fojing.dart';
import 'package:fo/services/http_service.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  var isLoading = true.obs;
  var albumName = "".obs;
  var albumDesc = "".obs;
  var albumImage = "".obs;
  var fojingList = [].obs;
  var albumId = "1";
  DetailController(id) {
    albumId = id;
  }

  @override
  void onInit() {
    fetchAlbum(albumId);
    super.onInit();
  }

  void fetchAlbum(String id) async {
    try {
      isLoading(true);
      var albumResponse = await HttpService.fetchAlbum(id);
      albumName.value = albumResponse.name;
      albumDesc.value = albumResponse.describe;
      albumImage.value = albumResponse.imageName;
      fojingList.value = albumResponse.fojings;
      // debugPrint(FojingElement.fromJson(fojingList[0]).name);
    } finally {
      isLoading(false);
    }
  }

  nextPlayerID(currentid) {
    var currentKey = -1;
    fojingList.asMap().forEach((key, value) {
      if (FojingElement.fromJson(value).id.toString() == currentid.toString()) {
        currentKey = key;
      }
    });
    var nextIndex = currentKey + 1;
    if (nextIndex >= fojingList.length) {
      nextIndex = 0;
    }
    return FojingElement.fromJson(fojingList[nextIndex]).id.toString();
  }

  previousPlayerID(currentid) {
    var currentKey = -1;
    fojingList.asMap().forEach((key, value) {
      if (FojingElement.fromJson(value).id.toString() == currentid.toString()) {
        currentKey = key;
      }
    });
    var nextIndex = currentKey - 1;
    if (nextIndex < 0) {
      nextIndex = fojingList.length - 1;
    }
    return FojingElement.fromJson(fojingList[nextIndex]).id.toString();
  }
}
