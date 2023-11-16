import 'dart:convert';

class Music {
  String id;
  String title;
  String album;
  String artist;
  String genre;
  String source;
  String image;
  int trackNumber;
  int totalTrackCount;
  int duration;
  String site;

  Music({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.genre,
    required this.source,
    required this.image,
    required this.trackNumber,
    required this.totalTrackCount,
    required this.duration,
    required this.site,
  });

  factory Music.fromRawJson(String str) => Music.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        id: json["id"],
        title: json["title"],
        album: json["album"],
        artist: json["artist"],
        genre: json["genre"],
        source: json["source"],
        image: json["image"],
        trackNumber: json["trackNumber"],
        totalTrackCount: json["totalTrackCount"],
        duration: json["duration"],
        site: json["site"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "album": album,
        "artist": artist,
        "genre": genre,
        "source": source,
        "image": image,
        "trackNumber": trackNumber,
        "totalTrackCount": totalTrackCount,
        "duration": duration,
        "site": site,
      };
}
