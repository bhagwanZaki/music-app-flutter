import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_lyric_app/bloc/musicBloc.dart';
import 'package:music_lyric_app/model/musicModel.dart';
import 'package:music_lyric_app/response/musicResponse.dart';
import 'package:music_lyric_app/widget/MusicCard.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({Key? key}) : super(key: key);

  @override
  State<MusicListPage> createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage>
    with AutomaticKeepAliveClientMixin<MusicListPage> {
  MusicBloc? _bloc;
  List<musicModel>? musicList = [];

  @override
  void initState() {
    _bloc = MusicBloc();
    _bloc?.getMusic();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _bloc?.getMusic(),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                upperSection(),
                const SizedBox(
                  height: 20,
                ),
                musicImage(),
                StreamBuilder<MusicResponse<List<musicModel>>>(
                    stream: _bloc?.musicStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data?.status) {
                          case Status.LOADING:
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black),
                            );
                          case Status.COMPLETED:
                            musicList = snapshot.data?.data;
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: musicList?.length,
                              itemBuilder: (context, index) => MusicCard(
                                  id: musicList![index].track_id,
                                  title: musicList![index].track_name,
                                  artistName: musicList![index].artist_name,
                                  favourite: musicList![index].num_favourite),
                            );
                          case Status.ERROR:
                            if (snapshot.data!.msg ==
                                "Error During Communication: No Internet Connection") {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
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

                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Somthing Went Wrong",
                                      style: TextStyle(fontSize: 32)),
                                  refreshButton()
                                ],
                              ),
                            );
                        }
                      }
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Somthing Went Wrong",
                                style: TextStyle(fontSize: 32)),
                            refreshButton()
                          ],
                        ),
                      );
                    }),
              ],
            ),
          )),
        ),
      ),
    );
  }

  MaterialButton refreshButton() {
    return MaterialButton(
      onPressed: () async {
        _bloc?.getMusic();
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

  Padding upperSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Good Evening",
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          MaterialButton(
            onPressed: () {},
            shape: const CircleBorder(),
            elevation: 0,
            color: Colors.white,
            padding: const EdgeInsets.all(5),
            child: const Icon(
              Icons.bookmark_outline_outlined,
              size: 42,
              color: Color(0xffF7DB29),
            ),
          )
        ],
      ),
    );
  }

  Padding musicImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: const DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.black26, BlendMode.dstOver),
                image: AssetImage("images/bg2-min.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Musics",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
