import 'dart:convert';

class CricketTeam {
  CricketTeam({
    this.tid,
    this.title,
    this.abbr,
    this.thumbUrl,
    this.logoUrl,
    this.type,
    this.country,
    this.altName,
    this.sex,
  });

  factory CricketTeam.fromJson(String str) =>
      CricketTeam.fromMap(json.decode(str));

  factory CricketTeam.fromMap(Map<String, dynamic> json) => CricketTeam(
        tid: json['tid'] as int,
        title: json['title'] as String,
        abbr: json['abbr'] as String,
        thumbUrl: json['thumb_url'] as String,
        logoUrl: json['logo_url'] as String,
        type: json['type'] as String,
        country: json['country'] as String,
        altName: json['alt_name'] as String,
        sex: json['sex'] as String,
      );

  final int tid;
  final String title;
  final String abbr;
  final String thumbUrl;
  final String logoUrl;
  final String type;
  final String country;
  final String altName;
  final String sex;

  CricketTeam copyWith({
    int tid,
    String title,
    String abbr,
    String thumbUrl,
    String logoUrl,
    String type,
    String country,
    String altName,
    String sex,
  }) =>
      CricketTeam(
        tid: tid ?? this.tid,
        title: title ?? this.title,
        abbr: abbr ?? this.abbr,
        thumbUrl: thumbUrl ?? this.thumbUrl,
        logoUrl: logoUrl ?? this.logoUrl,
        type: type ?? this.type,
        country: country ?? this.country,
        altName: altName ?? this.altName,
        sex: sex ?? this.sex,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'tid': tid,
        'title': title,
        'abbr': abbr,
        'thumb_url': thumbUrl,
        'logo_url': logoUrl,
        'type': type,
        'country': country,
        'alt_name': altName,
        'sex': sex,
      };
}
