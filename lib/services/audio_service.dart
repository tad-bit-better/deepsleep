import 'package:audioplayers/audioplayers.dart';

class AudioService {
  late AudioPlayer _audioPlayer;

  AudioService() {
    _audioPlayer = AudioPlayer();
  }

  Future<void> play(String audioUrl) async {
    await _audioPlayer.play(UrlSource(audioUrl));
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  // Remember to dispose the player when it's no longer needed
  void dispose() {
    _audioPlayer.dispose();
  }
}