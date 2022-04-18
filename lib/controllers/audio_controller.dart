import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fo/controllers/global_state_controller.dart';
import 'package:fo/services/http_service.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer(playerId: 'lcf_fo_player');
  GlobalStateController gsc = Get.find();
  FlutterTts flutterTts = FlutterTts();

  var isLoadingAudio = true.obs;
  var duration = 0.obs;
  var position = 0.obs;
  // var position = 0.obs;
  var isPlaying = false.obs;
  var isPaused = false.obs;
  var isLoop = false.obs;
  var audioPath = "".obs;
  var playid = "1".obs;
  var playtitle = "".obs;

  // AudioController(id) {
  //   playid.value = id;
  // }

  @override
  void onInit() {
    // if (gsc.currentPlayingID.value.toString() == playid.value.toString()) {
    //   debugPrint('same video');
    //   audioPlayer.resume();
    // } else {

    // audioPath.value = dotenv.env['SPACE_URL']! + "fojing02/12.铜鼓舞.mp3";
    // audioPlayer.setUrl(audioPath.value);
    // fetchAudio(playid.toString());
    // debugPrint(playid.toString());
    // }
    super.onInit();
    audioPlayer.onDurationChanged.listen((d) {
      duration.value = d.inSeconds;
      gsc.currentPlayingDuration.value = d.inSeconds;
      debugPrint(
          "onDurationChanged: " + gsc.currentPlayingDuration.value.toString());
    });
    audioPlayer.onAudioPositionChanged.listen((p) {
      position.value = p.inSeconds;
      gsc.currentPlayingPosition.value = p.inSeconds;
    });
  }

  void fetchAudio(String id) async {
    try {
      playid.value = id;
      isLoadingAudio(true);
      duration.value = 0;
      position.value = 0;
      var playerResponse = await HttpService.fetchAudio(id);
      audioPath.value = Uri.encodeFull(playerResponse.url);

      if (dotenv.env['APP_ENV'] == 'local') {
        audioPath.value = Uri.encodeFull(
            "http://r6s9kzzxe.hn-bkt.clouddn.com/fojing2/004-妙莲和尚说故事-罗汉与香象.mp4");
      }
      // audioPlayer.setUrl(audioPath.value);
      playtitle.value = playerResponse.name;
      isPlaying.value = true;
      gsc.currentIsPlaying.value = true;
      gsc.currentPlayingAlbumImage.value = playerResponse.albumImage.toString();
      gsc.currentPlayingAlbumID.value = playerResponse.album_id.toString();
      gsc.currentPlayingID.value = id;
      debugPrint(audioPath.value);

      audioPlayer.play(audioPath.value, isLocal: false);
      // flutterTts.speak(audioPath.value);
      // var _audioDurationMS = await _audioPlayer.getDuration();
      // debugPrint("new duration: " + _audioDurationMS.toString());
      debugPrint(duration.value.toString());
      // albumDesc.value = albumResponse.describe;
      // albumImage.value = albumResponse.imageName;
      // fojingList.value = albumResponse.fojings;
      // debugPrint(FojingElement.fromJson(fojingList[0]).name);
    } finally {
      isLoadingAudio(false);
    }
  }
}
