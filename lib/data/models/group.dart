import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Group {
  Group({
    @required this.adminId,
    @required this.adminName,
    @required this.createdAt,
    @required this.createdBy,
    @required this.description,
    @required this.id,
    @required this.name,
    @required this.isPublic,
    @required this.userLimit,
    @required this.users,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Group.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final map = snapshot.data();

    return Group(
      adminId: map['adminId'],
      adminName: map['adminName'],
      createdAt: map['createdAt']?.toDate(),
      createdBy: map['createdBy'],
      description: map['description'],
      id: map['id'],
      name: map['name'],
      isPublic: map['isPublic'],
      userLimit: map['userLimit'],
      users: map['users'] != null ? List<String>.from(map['users']) : null,
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Group(
      adminId: map['adminId'],
      adminName: map['adminName'],
      createdAt: map['createdAt']?.toDate(),
      createdBy: map['createdBy'],
      description: map['description'],
      id: map['id'],
      name: map['name'],
      isPublic: map['isPublic'],
      userLimit: map['userLimit'],
      users: map['users'] != null ? List<String>.from(map['users']) : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'adminId': adminId,
        'adminName': adminName,
        'createdAt': createdAt,
        'createdBy': createdBy,
        'description': description,
        'id': id,
        'name': name,
        'isPublic': isPublic,
        'userLimit': userLimit,
        'users': users,
      };

  final String adminId;
  final String adminName;
  final DateTime createdAt;
  final String createdBy;
  final String description;
  final String id;
  final String name;
  final bool isPublic;
  final int userLimit;
  final List<String> users;
  final DocumentSnapshot snapshot;
  final DocumentReference reference;
  final String documentID;

  Group copyWith({
    String adminId,
    String adminName,
    DateTime createdAt,
    String createdBy,
    String description,
    String id,
    String name,
    bool isPublic,
    int userLimit,
    List<String> users,
  }) {
    return Group(
      adminId: adminId ?? this.adminId,
      adminName: adminName ?? this.adminName,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      description: description ?? this.description,
      id: id ?? this.id,
      name: name ?? this.name,
      isPublic: isPublic ?? this.isPublic,
      userLimit: userLimit ?? this.userLimit,
      users: users ?? this.users,
    );
  }
}
