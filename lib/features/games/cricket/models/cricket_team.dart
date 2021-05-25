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
        tid: json['tid'],
        title: json['title'],
        abbr: json['abbr'],
        thumbUrl: json['thumb_url'],
        logoUrl: json['logo_url'],
        type: json['type'],
        country: json['country'],
        altName: json['alt_name'],
        sex: json['sex'],
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
