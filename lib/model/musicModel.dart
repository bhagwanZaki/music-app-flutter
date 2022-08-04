// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class musicModel {
  int track_id;
  String track_name;
  int track_rating;
  String album_name;
  String artist_name;
  int num_favourite;
  musicModel({
    required this.track_id,
    required this.track_name,
    required this.track_rating,
    required this.album_name,
    required this.artist_name,
    required this.num_favourite,
  });

  musicModel copyWith({
    int? track_id,
    String? track_name,
    int? track_rating,
    String? album_name,
    String? artist_name,
    int? num_favourite,
  }) {
    return musicModel(
      track_id: track_id ?? this.track_id,
      track_name: track_name ?? this.track_name,
      track_rating: track_rating ?? this.track_rating,
      album_name: album_name ?? this.album_name,
      artist_name: artist_name ?? this.artist_name,
      num_favourite: num_favourite ?? this.num_favourite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'track_id': track_id,
      'track_name': track_name,
      'track_rating': track_rating,
      'album_name': album_name,
      'artist_name': artist_name,
      'num_favourite': num_favourite,
    };
  }

  factory musicModel.fromMap(Map<String, dynamic> map) {
    return musicModel(
      track_id: map['track_id'] as int,
      track_name: map['track_name'] as String,
      track_rating: map['track_rating'] as int,
      album_name: map['album_name'] as String,
      artist_name: map['artist_name'] as String,
      num_favourite: map['num_favourite'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory musicModel.fromJson(String source) => musicModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'musicModel(track_id: $track_id, track_name: $track_name, track_rating: $track_rating, album_name: $album_name, artist_name: $artist_name, num_favourite: $num_favourite)';
  }

  @override
  bool operator ==(covariant musicModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.track_id == track_id &&
      other.track_name == track_name &&
      other.track_rating == track_rating &&
      other.album_name == album_name &&
      other.artist_name == artist_name &&
      other.num_favourite == num_favourite;
  }

  @override
  int get hashCode {
    return track_id.hashCode ^
      track_name.hashCode ^
      track_rating.hashCode ^
      album_name.hashCode ^
      artist_name.hashCode ^
      num_favourite.hashCode;
  }
}
