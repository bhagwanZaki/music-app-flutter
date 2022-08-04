import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_lyric_app/bloc/musicBloc.dart';
import 'package:music_lyric_app/contants/dummy.dart';
import 'package:music_lyric_app/model/musicLyricsModel.dart';
import 'package:music_lyric_app/model/musicModel.dart';
import 'package:music_lyric_app/response/musicResponse.dart';

class MusicLyrics extends StatefulWidget {
  const MusicLyrics({Key? key}) : super(key: key);

  @override
  State<MusicLyrics> createState() => _MusicLyricsState();
}

class _MusicLyricsState extends State<MusicLyrics> {
  MusicBloc? _bloc;

  @override
  void initState() {
    _bloc = MusicBloc();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    _bloc?.getMusicDetail(arguments['id']);
    _bloc?.getMusicLyrics(arguments['id']);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Lyrics",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<MusicResponse<LyricsModel>>(
              stream: _bloc?.lyricsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data?.status) {
                    case Status.LOADING:
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    case Status.COMPLETED:
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 8),
                            child: Text(
                              snapshot.data!.data.lyrics_body,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    case Status.ERROR:
                      if (snapshot.data!.msg ==
                          "Error During Communication: No Internet Connection") {
                        return connectToInternet();
                      }

                      return errorContainer();
                    default:
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                  }
                }
                return errorContainer();
              }),
          StreamBuilder<MusicResponse<musicModel>>(
            stream: _bloc?.detailStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data?.status) {
                  case Status.LOADING:
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  case Status.COMPLETED:
                    return bottomSection(context, snapshot.data!.data);
                  case Status.ERROR:
                    return SizedBox(
                      height: 0,
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                }
              }
              return errorContainer();
            },
          )
        ],
      )),
    );
  }

  Container connectToInternet() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.wifi_slash,
            size: 100.0,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Connect To Network",
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(
            height: 30,
          ),
          refreshButton()
        ],
      ),
    );
  }

  Container errorContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Somthing Went Wrong", style: TextStyle(fontSize: 32)),
          refreshButton()
        ],
      ),
    );
  }

  MaterialButton refreshButton() {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return MaterialButton(
      onPressed: () async {
        _bloc?.getMusicLyrics(arguments['id']);
        _bloc?.getMusicDetail(arguments['id']);
      },
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Refresh",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  Container bottomSection(BuildContext context, musicModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.track_name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 28),
                ),
                Text(
                  data.artist_name,
                  style: const TextStyle(fontSize: 22),
                )
              ],
            ),
          ),
          Row(
            children: [
              MaterialButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(6),
                  minWidth: 0,
                  color: Colors.black,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.bookmark_add,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                  onPressed: () {
                    musicDetail(context, data);
                  },
                  padding: const EdgeInsets.all(6),
                  minWidth: 0,
                  color: Colors.black,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.dehaze,
                    color: Colors.white,
                  ))
            ],
          )
        ],
      ),
    );
  }

  Future<dynamic> musicDetail(BuildContext context, musicModel data) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    data.track_name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                Text(
                  data.artist_name,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Album Name"),
                          Text(
                            data.album_name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          data.num_favourite.toString(),
                          style: const TextStyle(fontSize: 19),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
