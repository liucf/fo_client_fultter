import 'package:get/get_connect.dart';

class AlbumProvider extends GetConnect {
  @override
  void onInit() {
    // All request will pass to jsonEncode so CasesModel.fromJson()
    // httpClient.defaultDecoder = CityModel.listFromJson;
    // httpClient.addRequestModifier((request) {
    //   request.headers['Authorization'] = 'Bearer sdfsdfgsdfsdsdf12345678';
    //   return request;
    // });
  }

  // Future<List<Album>> getAlbum() async {
  //   var res = await get('https://jsonplaceholder.typicode.com/photos');
  //   List jsonResponse = json.decode(res.body.toString());
  //   debugPrint(jsonResponse.toString());
  //   return albumsFromJson(res.body);
  // }
}
