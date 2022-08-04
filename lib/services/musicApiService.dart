import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_lyric_app/contants/constants.dart';
import 'package:music_lyric_app/model/musicLyricsModel.dart';
import 'package:music_lyric_app/model/musicModel.dart';

import 'package:music_lyric_app/utils/apiException.dart';

class MusicApiService {
  //  get list of music
  Future<dynamic> getMusic() async {
    try {
      http.Response res = await http.get(Uri.parse(Constants.musicList),
          headers: <String, String>{'Content-Type': 'application/json'});
      var responseBody = _returnResponse(res);
      List<musicModel> musicList =
          List.from(responseBody["message"]["body"]['track_list'])
              .map((item) => musicModel.fromMap(item['track']))
              .toList();
      return musicList;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  // music detail
  Future<dynamic> getDetail(int trackId) async {
    try {
      http.Response res = await http.get(
          Uri.parse("${Constants.getMusicDetail}$trackId"),
          headers: <String, String>{'Content-Type': 'application/json'});
      var responseBody = _returnResponse(res);

      musicModel musicDetail =
          musicModel.fromMap(responseBody["message"]["body"]["track"]);

      return musicDetail;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  // music detail
  Future<dynamic> getLyricsDetail(int trackId) async {
    try {
      http.Response res = await http.get(
          Uri.parse("${Constants.getMusicDetailLyrics}$trackId"),
          headers: <String, String>{'Content-Type': 'application/json'});
      var responseBody = _returnResponse(res);

      LyricsModel musicDetail =
          LyricsModel.fromMap(responseBody["message"]["body"]["lyrics"]);

      return musicDetail;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 201:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 204:
      return "true";
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
      throw BadRequestException(response.body.toString());
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
