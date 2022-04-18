import 'package:flutter/material.dart';
import 'package:fo/components/search_widget.dart';
import 'package:fo/controllers/detail_controller.dart';
import 'package:fo/models/fojing.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);
  final DetailController detailController =
      Get.put(DetailController(Get.parameters['id']));

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(detailController.albumName.toString())),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: const [SearchWidget()],
      ),
      body: Obx(() {
        if (detailController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          height: 150.0,
                          width: 150,
                          placeholder: kTransparentImage,
                          image: detailController.albumImage.toString(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(detailController.albumDesc.toString()),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemCount: detailController.fojingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  FojingElement.fromJson(
                                          detailController.fojingList[index])
                                      .name,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                              const Icon(Icons.play_arrow),
                            ],
                          ),
                        ),
                        onTap: () => Get.toNamed('player', parameters: {
                          "albumid": detailController.albumId.toString(),
                          "playid": FojingElement.fromJson(
                                  detailController.fojingList[index])
                              .id
                              .toString()
                        }),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
