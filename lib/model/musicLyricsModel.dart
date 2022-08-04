// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LyricsModel {
  String lyrics_body;
  LyricsModel({
    required this.lyrics_body,
  });

  LyricsModel copyWith({
    String? lyrics_body,
  }) {
    return LyricsModel(
      lyrics_body: lyrics_body ?? this.lyrics_body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lyrics_body': lyrics_body,
    };
  }

  factory LyricsModel.fromMap(Map<String, dynamic> map) {
    return LyricsModel(
      lyrics_body: map['lyrics_body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LyricsModel.fromJson(String source) => LyricsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LyricsModel(lyrics_body: $lyrics_body)';

  @override
  bool operator ==(covariant LyricsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.lyrics_body == lyrics_body;
  }

  @override
  int get hashCode => lyrics_body.hashCode;
}
