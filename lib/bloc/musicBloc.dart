import 'dart:async';

import 'package:music_lyric_app/model/musicLyricsModel.dart';
import 'package:music_lyric_app/model/musicModel.dart';
import 'package:music_lyric_app/repository/musicRepository.dart';
import 'package:music_lyric_app/response/musicResponse.dart';

class MusicBloc {
  late MusicRepository _musicRepository;

  // controller
  late StreamController<MusicResponse<List<musicModel>>> _controller;
  late StreamController<MusicResponse<musicModel>> _detailController;
  late StreamController<MusicResponse<LyricsModel>> _lyricsController;

  // sink
  StreamSink<MusicResponse<List<musicModel>>> get musicSink => _controller.sink;
  StreamSink<MusicResponse<musicModel>> get detailSink =>
      _detailController.sink;
  StreamSink<MusicResponse<LyricsModel>> get lyricsSink =>
      _lyricsController.sink;

  // Stream
  Stream<MusicResponse<List<musicModel>>> get musicStream => _controller.stream;
  Stream<MusicResponse<musicModel>> get detailStream =>
      _detailController.stream;
  Stream<MusicResponse<LyricsModel>> get lyricsStream =>
      _lyricsController.stream;

  // constructor
  MusicBloc() {
    _controller = StreamController<MusicResponse<List<musicModel>>>();
    _detailController = StreamController<MusicResponse<musicModel>>();
    _lyricsController = StreamController<MusicResponse<LyricsModel>>();

    _musicRepository = MusicRepository();
  }

  // Get music List
  getMusic() async {
    musicSink.add(MusicResponse.loading('Fetching Data'));
    try {
      List<musicModel> data = await _musicRepository.getMusic();
      musicSink.add(MusicResponse.completed(data));
    } catch (e) {
      musicSink.add(MusicResponse.error(e.toString()));
    }
  }

  // Get music detail
  getMusicDetail(int trackId) async {
    detailSink.add(MusicResponse.loading('Fetching Data'));
    try {
      musicModel data = await _musicRepository.getMusicDetail(trackId);
      detailSink.add(MusicResponse.completed(data));
    } catch (e) {
      detailSink.add(MusicResponse.error(e.toString()));
    }
  }

  // Get music lyrics
  getMusicLyrics(int trackId) async {
    lyricsSink.add(MusicResponse.loading('Fetching Data'));
    try {
      LyricsModel data = await _musicRepository.getMusicLyrics(trackId);
      lyricsSink.add(MusicResponse.completed(data));
    } catch (e) {
      lyricsSink.add(MusicResponse.error(e.toString()));
    }
  }
}
