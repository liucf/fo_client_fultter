import 'package:flutter/material.dart';
import 'package:fo/controllers/audio_controller.dart';
import 'package:fo/controllers/detail_controller.dart';
import 'package:fo/controllers/global_state_controller.dart';
import 'package:fo/models/fojing.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlayerPage extends StatelessWidget {
  PlayerPage({Key? key}) : super(key: key);

  final List<IconData> _icons = [
    Icons.play_circle_rounded,
    Icons.pause_circle_rounded
  ];

  final DetailController detailController =
      Get.put(DetailController(Get.parameters['albumid']));
  final AudioController audioController = Get.find();
  final GlobalStateController gsc = Get.find();

  Widget player(BuildContext context) {
    return Obx(
      () {
        // || audioController.duration.value == 0
        if (audioController.isLoadingAudio.isTrue) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Duration(seconds: audioController.position.value)
                          .toString()
                          .split('.')[0]),
                      Slider(
                          min: 0.0,
                          max: audioController.duration.value.toDouble(),
                          value: audioController.position.value.toDouble(),
                          onChanged: (double value) {
                            audioController.audioPlayer
                                .seek(Duration(seconds: value.toInt()));
                          }),
                      Text(Duration(seconds: audioController.duration.value)
                          .toString()
                          .split('.')[0]),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                          icon: const Icon(Icons.shuffle_rounded, size: 35),
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                          icon:
                              const Icon(Icons.skip_previous_rounded, size: 35),
                          onPressed: () {
                            var previousID = detailController
                                .previousPlayerID(audioController.playid);
                            debugPrint(previousID.toString());
                            audioController.fetchAudio(previousID.toString());
                            audioController.playid.value = previousID;
                          },
                        ),
                      ),
                      IconButton(
                        icon: audioController.isPlaying.isTrue
                            ? Icon(_icons[1], size: 50)
                            : Icon(_icons[0], size: 50),
                        onPressed: () {
                          if (audioController.isPlaying.isTrue) {
                            audioController.audioPlayer.pause();
                            audioController.isPaused.value = true;
                            gsc.currentIsPlaying.value = false;
                          } else {
                            debugPrint(audioController.audioPath.toString());
                            if (audioController.isPaused.isTrue) {
                              audioController.audioPlayer.resume();
                              audioController.isPaused.value = false;
                            } else {
                              audioController.audioPlayer
                                  .play(audioController.audioPath.toString());
                            }
                            gsc.currentIsPlaying.value = true;
                          }
                          audioController.isPlaying.toggle();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                          icon: const Icon(Icons.skip_next_rounded, size: 35),
                          onPressed: () {
                            var nextID = detailController
                                .nextPlayerID(audioController.playid);
                            debugPrint(nextID.toString());
                            audioController.fetchAudio(nextID.toString());
                            audioController.playid.value = nextID;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                          icon:
                              const Icon(Icons.playlist_play_rounded, size: 35),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                // isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 400,
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                maxHeight: 300),
                                            child: ListView.separated(
                                              padding: const EdgeInsets.all(8),
                                              shrinkWrap: true,
                                              itemCount: detailController
                                                  .fojingList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  child: SizedBox(
                                                    height: 30,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            FojingElement.fromJson(
                                                                    detailController
                                                                            .fojingList[
                                                                        index])
                                                                .name,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            style: audioController
                                                                        .playid
                                                                        .value
                                                                        .toString() ==
                                                                    FojingElement.fromJson(detailController.fojingList[
                                                                            index])
                                                                        .id
                                                                        .toString()
                                                                ? const TextStyle(
                                                                    color: Colors
                                                                        .red)
                                                                : const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                        const Icon(
                                                            Icons.play_arrow),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    var tapID =
                                                        FojingElement.fromJson(
                                                                detailController
                                                                        .fojingList[
                                                                    index])
                                                            .id
                                                            .toString();
                                                    audioController.fetchAudio(
                                                        tapID.toString());
                                                    audioController
                                                        .playid.value = tapID;
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const Divider();
                                              },
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12.0),
                                          child: ElevatedButton(
                                            child: const Text('CLOSE'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                    ]),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    if (gsc.currentPlayingID.value.toString() !=
        Get.parameters['playid'].toString()) {
      audioController.fetchAudio(Get.parameters['playid'].toString());
    }
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(audioController.playtitle.value)),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Obx(() {
        if (detailController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      height: 180.0,
                      width: 180,
                      placeholder: kTransparentImage,
                      image: detailController.albumImage.toString(),
                    ),
                  )
                ],
              ),
              const Spacer(),
              player(context)
            ],
          );

          // Stack(
          //   children: [

          //     const Spacer(),
          //     const Text("bottom"),
          //     Positioned(
          //       bottom: 0,
          //       left: 0,
          //       right: 0,
          //       child: Container(
          //         padding: const EdgeInsets.all(8),
          //         child: const Text("Player"),
          //       ),
          //     ),
          //   ],
          // );
        }
      }),
    );
  }
}
