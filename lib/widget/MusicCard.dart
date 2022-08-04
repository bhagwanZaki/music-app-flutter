import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_lyric_app/contants/routes.dart';

class MusicCard extends StatelessWidget {
  const MusicCard(
      {Key? key,
      required this.title,
      required this.artistName,
      required this.favourite,
      required this.id})
      : super(key: key);

  final int id;
  final String title;
  final String artistName;
  final int favourite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.pushNamed(context, Routes.lyricsRoute,
          arguments: {'id': id})),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        artistName,
                        style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54),
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
                            favourite.toString(),
                            style: const TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
