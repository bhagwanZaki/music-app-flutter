import 'package:music_lyric_app/model/musicLyricsModel.dart';
import 'package:music_lyric_app/model/musicModel.dart';
import 'package:music_lyric_app/services/musicApiService.dart';

class MusicRepository {
  final MusicApiService _service = MusicApiService();

  // list repository
  Future<List<musicModel>> getMusic() async {
    final response = await _service.getMusic();
    return response;
  }

  // music detail
  Future<musicModel> getMusicDetail(int trackId) async {
    final response = await _service.getDetail(trackId);
    return response;
  }

  // music detail
  Future<LyricsModel> getMusicLyrics(int trackId) async {
    final response = await _service.getLyricsDetail(trackId);
    return response;
  }
}
