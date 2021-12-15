import 'dart:convert';

class Driver {
  Driver({
    this.driverId,
    this.firstName,
    this.lastName,
    this.number,
    this.numberDisplay,
    this.team,
    this.birthDate,
    this.birthPlace,
    this.gender,
    this.height,
    this.weight,
    this.manufacturer,
    this.engine,
    this.chassis,
    this.sponsors,
    this.crewChief,
    this.photoUrl,
    this.updated,
    this.created,
  });

  Driver copyWith({
    int? driverId,
    String? firstName,
    String? lastName,
    int? number,
    String? numberDisplay,
    String? team,
    DateTime? birthDate,
    String? birthPlace,
    String? gender,
    int? height,
    int? weight,
    String? manufacturer,
    String? engine,
    String? chassis,
    String? sponsors,
    String? crewChief,
    String? photoUrl,
    DateTime? updated,
    DateTime? created,
  }) =>
      Driver(
        driverId: driverId ?? this.driverId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        number: number ?? this.number,
        numberDisplay: numberDisplay ?? this.numberDisplay,
        team: team ?? this.team,
        birthDate: birthDate ?? this.birthDate,
        birthPlace: birthPlace ?? this.birthPlace,
        gender: gender ?? this.gender,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        manufacturer: manufacturer ?? this.manufacturer,
        engine: engine ?? this.engine,
        chassis: chassis ?? this.chassis,
        sponsors: sponsors ?? this.sponsors,
        crewChief: crewChief ?? this.crewChief,
        photoUrl: photoUrl ?? this.photoUrl,
        updated: updated ?? this.updated,
        created: created ?? this.created,
      );

  factory Driver.fromJson(String str) =>
      Driver.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory Driver.fromMap(Map<String, dynamic> json) => Driver(
        driverId: json['DriverID'] as int?,
        firstName: json['FirstName'] as String?,
        lastName: json['LastName'] as String?,
        number: json['Number'] as int?,
        numberDisplay: json['NumberDisplay'] as String?,
        team: json['Team'] as String?,
        birthDate: json['BirthDate'] == null
            ? null
            : DateTime.parse(json['BirthDate'] as String),
        birthPlace: json['BirthPlace'] as String?,
        gender: json['Gender'] as String?,
        height: json['Height'] as int?,
        weight: json['Weight'] as int?,
        manufacturer: json['Manufacturer'] as String?,
        engine: json['Engine'] as String?,
        chassis: json['Chassis'] as String?,
        sponsors: json['Sponsors'] as String?,
        crewChief: json['CrewChief'] as String?,
        photoUrl: json['PhotoUrl'] as String?,
        updated: json['Updated'] == null
            ? null
            : DateTime.parse(
                json['Updated'] as String,
              ),
        created: json['Created'] == null
            ? null
            : DateTime.parse(
                json['Created'] as String,
              ),
      );

  final int? driverId;
  final String? firstName;
  final String? lastName;
  final int? number;
  final String? numberDisplay;
  final String? team;
  final DateTime? birthDate;
  final String? birthPlace;
  final String? gender;
  final int? height;
  final int? weight;
  final String? manufacturer;
  final String? engine;
  final String? chassis;
  final String? sponsors;
  final String? crewChief;
  final String? photoUrl;
  final DateTime? updated;
  final DateTime? created;

  Map<String, Object?> toMap() => {
        'DriverID': driverId,
        'FirstName': firstName,
        'LastName': lastName,
        'Number': number,
        'NumberDisplay': numberDisplay,
        'Team': team,
        'BirthDate': birthDate == null ? null : birthDate!.toIso8601String(),
        'BirthPlace': birthPlace,
        'Gender': gender,
        'Height': height,
        'Weight': weight,
        'Manufacturer': manufacturer,
        'Engine': engine,
        'Chassis': chassis,
        'Sponsors': sponsors,
        'CrewChief': crewChief,
        'PhotoUrl': photoUrl,
        'Updated': updated == null ? null : updated!.toIso8601String(),
        'Created': created == null ? null : created!.toIso8601String(),
      };
}
