class Youtubes {
  Youtubes({
    this.youtubes,
    this.error,
    this.errorMsg,
  });

  List<Youtube> youtubes;
  bool error;
  String errorMsg;

  factory Youtubes.fromJson(Map<String, dynamic> json) => Youtubes(
        youtubes: List<Youtube>.from(
            json["youtubes"].map((x) => Youtube.fromJson(x))),
        error: json["error"],
        errorMsg: json["error_msg"],
      );
}

class Youtube {
  Youtube({
    this.id,
    this.title,
    this.subtitle,
    this.avatarImage,
    this.youtubeImage,
  });

  String id;
  String title;
  String subtitle;
  String avatarImage;
  String youtubeImage;


  factory Youtube.fromJson(Map<String, dynamic> json) => Youtube(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        avatarImage: json["avatar_image"],
        youtubeImage: json["youtube_image"],
      );
}
