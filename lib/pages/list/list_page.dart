import 'package:flutter/material.dart';
import 'package:fo/components/search_widget.dart';
import 'package:fo/controllers/list_controller.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ListPage extends StatelessWidget {
  ListPage({Key? key}) : super(key: key);
  final ListController listController =
      Get.put(ListController(Get.parameters['categoryid']));

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(listController.listName.value)),
        actions: const [SearchWidget()],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
              top: 30,
            ),
          ),
          Expanded(child: Obx(() {
            if (listController.isLoading.value && 1 == 2) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      scrollNotification.metrics.pixels >=
                          (scrollNotification.metrics.maxScrollExtent - 50) &&
                      listController.isLoading.isFalse) {
                    listController.albumPage.value =
                        listController.albumPage.value + 1;
                    listController.fetchAlbum();
                  }
                  return true;
                },
                child: Stack(children: [
                  ListView.separated(
                    itemCount: listController.allLoaded.isFalse
                        ? listController.albumList.length
                        : listController.albumList.length + 1,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                    // (: itemBuilder,,)
                    itemBuilder: (context, index) {
                      if (index < listController.albumList.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed('/details', parameters: {
                                "id": listController.albumList[index].id
                                    .toString()
                              });
                            },
                            child: Row(children: [
                              Flexible(
                                flex: 2,
                                child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.cover,
                                  height: 80.0,
                                  width: 80,
                                  placeholder: kTransparentImage,
                                  image:
                                      listController.albumList[index].imageName,
                                ),
                              ),
                              Flexible(
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          listController.albumList[index].name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          listController
                                              .albumList[index].describe
                                              .toString()
                                              .trim(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )

                              // Expanded(
                              //   child: Center(
                              //     child: ClipRRect(
                              //       borderRadius: BorderRadius.circular(8.0),
                              //       child: GestureDetector(
                              //         onTap: () {
                              //           Get.toNamed('/details', parameters: {
                              //             "id": listController
                              //                 .albumList[index].id
                              //                 .toString()
                              //           });
                              //         },
                              //         child: FadeInImage.memoryNetwork(
                              //           fit: BoxFit.cover,
                              //           height: 180.0,
                              //           width: 180,
                              //           placeholder: kTransparentImage,
                              //           image: dotenv.env['SPACE_URL']! +
                              //               listController
                              //                   .albumList[index].imageName,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Center(
                              //   child: Container(
                              //     padding:
                              //         const EdgeInsets.fromLTRB(0, 5, 0, 10),
                              //     child: Text(
                              //       listController.albumList[index].name,
                              //       style: const TextStyle(
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 12,
                              // )
                            ]),
                          ),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: const Text('Nothingmoretoload').tr(),
                          ),
                        );
                      }
                    },
                  ),
                  if (listController.isLoading.isTrue) ...[
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: SizedBox(
                        width: width,
                        height: 80,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                ]),
              );
            }
          }))
        ],
      ),
    );
  }
}
