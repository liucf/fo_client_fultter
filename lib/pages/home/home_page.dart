import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fo/components/search_widget.dart';
import 'package:fo/controllers/album_controller.dart';
import 'package:fo/controllers/global_state_controller.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalStateController gsc = Get.put(GlobalStateController());
  // final ProductController productController = Get.put(ProductController());
  final AlbumController albumController = Get.put(AlbumController());

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    debugPrint(height.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("佛经"),
        actions: const [SearchWidget()],
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 10,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "foying",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ).tr(),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/list', parameters: {"categoryid": "2"});
                    },
                    child: Row(
                      children: [
                        const Text(
                          "更多",
                          style: TextStyle(fontSize: 14),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color(0xFF363f93),
                          ),
                          onPressed: () {
                            Get.toNamed('/list',
                                parameters: {"categoryid": "2"});
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Expanded(child: Obx(() {
            if (albumController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  albumController.albumList.length,
                  (index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/details', parameters: {
                                      "id": albumController.albumList[index].id
                                          .toString()
                                    });
                                  },
                                  child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    height: 180.0,
                                    width: (width / 2) - 20,
                                    placeholder: kTransparentImage,
                                    image: albumController
                                        .albumList[index].imageName,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                              child: Text(
                                albumController.albumList[index].name,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          )
                        ]);
                  },
                ),
              );
            }
          })),
          Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 10,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "foshu",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ).tr(),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/list', parameters: {"categoryid": "12"});
                    },
                    child: Row(
                      children: [
                        const Text(
                          "更多",
                          style: TextStyle(fontSize: 14),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color(0xFF363f93),
                          ),
                          onPressed: () {
                            Get.toNamed('/list',
                                parameters: {"categoryid": "2"});
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Expanded(child: Obx(() {
            if (albumController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  albumController.albumList2.length,
                  (index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/details', parameters: {
                                      "id": albumController.albumList2[index].id
                                          .toString()
                                    });
                                  },
                                  child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    height: 180.0,
                                    width: (width / 2) - 20,
                                    placeholder: kTransparentImage,
                                    image: albumController
                                        .albumList2[index].imageName,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                              child: Text(
                                albumController.albumList2[index].name,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          )
                        ]);
                  },
                ),
              );
            }
          }))
        ],
      ),
    );
  }
}

class Other extends StatelessWidget {
  Other({Key? key}) : super(key: key);
  final AlbumController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text("back"),
              )
            ],
          ),
        ));
  }
}
