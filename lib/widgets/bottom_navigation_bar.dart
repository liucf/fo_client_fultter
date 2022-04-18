import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fo/controllers/global_state_controller.dart';
import 'package:fo/pages/dashboard/dashboard_page.dart';
import 'package:fo/pages/home/home_page.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';

class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({Key? key}) : super(key: key);
  final GlobalStateController gsc = Get.find();

  final List bodyPageList = [HomePage(), DashboardPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Obx(() => Text(gsc.pageTitle[gsc.pageIndex.value])),
      //   leading: Obx(() => gsc.pageAppBarLeft[gsc.pageIndex.value]),
      //   actions: [
      //     Obx(() => gsc.pageAppBarRight[gsc.pageIndex.value]),
      //   ],
      // ),
      body: Obx(() => bodyPageList[gsc.pageIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                label: tr('home'), icon: const Icon(Icons.home)),
            // BottomNavigationBarItem(label: "测算", icon: Icon(Icons.apps)),
            BottomNavigationBarItem(
                label: tr('my'), icon: const Icon(Icons.person)),
          ],
          currentIndex: gsc.pageIndex.value,
          selectedItemColor: Colors.yellow[800],
          onTap: (int index) {
            debugPrint(index.toString());
            gsc.changePageIndex(index);
          },
        ),
      ),

      floatingActionButton: Obx(() {
        if (gsc.currentPlayingAlbumImage.value != "") {
          return Stack(children: [
            const Positioned(
              child: SizedBox(
                height: 56,
                width: 56,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              child: SizedBox(
                height: 56,
                width: 56,
                child: CircularProgressIndicator(
                    strokeWidth: 10,
                    // value: (gsc.currentPlayingPosition.value.toInt() /
                    //         gsc.currentPlayingDuration.value.toInt())
                    //     .toDouble()),
                    value: gsc.currentPlayingPosition.value > 0 &&
                            gsc.currentPlayingDuration.value > 0
                        ? (gsc.currentPlayingPosition.value /
                                gsc.currentPlayingDuration.value)
                            .toDouble()
                        : 0),
              ),
            ),
            FloatingActionButton(
              // backgroundColor: Colors.yellow[600],

              onPressed: () {
                debugPrint("click button" + gsc.currentPlayingAlbumImage.value);
              },
              child: GestureDetector(
                onTap: () {
                  debugPrint("click floate button");
                  debugPrint((gsc.currentPlayingPosition.value /
                          gsc.currentPlayingDuration.value)
                      .toString());
                  debugPrint(gsc.currentPlayingDuration.value.toString());
                  Get.toNamed('player', parameters: {
                    "albumid": gsc.currentPlayingAlbumID.toString(),
                    "playid": gsc.currentPlayingID.toString()
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                          gsc.currentPlayingAlbumImage.value.toString()),
                    ),
                    Positioned(
                      child: gsc.currentIsPlaying.isTrue
                          ? Lottie.asset(
                              'assets/json/sound-wave.json',
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
                            )
                          : const Icon(
                              Icons.play_arrow_rounded,
                              size: 35,
                              // color: Colors.transparent,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        } else {
          return Container();
        }
      }),
    );
  }
}
