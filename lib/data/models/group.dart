import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Group extends Equatable {
  Group({
    @required this.adminId,
    @required this.adminName,
    @required this.avatarUrl,
    @required this.createdAt,
    @required this.createdBy,
    @required this.description,
    @required this.id,
    @required this.name,
    @required this.isPublic,
    @required this.isUnlimited,
    @required this.userLimit,
    @required this.users,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Group.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final map = snapshot.data() as Map;

    return Group(
      adminId: map['adminId'] as String,
      adminName: map['adminName'] as String,
      avatarUrl: map['avatarUrl'] as String,
      createdAt: map['createdAt']?.toDate() as DateTime,
      createdBy: map['createdBy'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      isPublic: map['isPublic'] as bool,
      isUnlimited: map['isUnlimited'] as bool,
      userLimit: map['userLimit'] as int,
      users: map['users'] != null
          ? Map<String, bool>.from(
              map['users'] as Map<String, bool>,
            )
          : null,
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  final String adminId;
  final String adminName;
  final String avatarUrl;
  final DateTime createdAt;
  final String createdBy;
  final String description;
  final String id;
  final String name;
  final bool isPublic;
  final bool isUnlimited;
  final int userLimit;
  final Map<String, bool> users;
  final DocumentSnapshot snapshot;
  final DocumentReference reference;
  final String documentID;

  factory Group.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Group(
      adminId: map['adminId'] as String,
      adminName: map['adminName'] as String,
      avatarUrl: map['avatarUrl'] as String,
      createdAt: map['createdAt']?.toDate() as DateTime,
      createdBy: map['createdBy'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      isPublic: map['isPublic'] as bool,
      isUnlimited: map['isUnlimited'] as bool,
      userLimit: map['userLimit'] as int,
      users: map['users'] != null
          ? Map<String, bool>.from(
              map['users'] as Map<String, bool>,
            )
          : null,
    );
  }

  Map<String, Object> toMap() => {
        'adminId': adminId,
        'adminName': adminName,
        'avatarUrl': avatarUrl,
        'createdAt': createdAt,
        'createdBy': createdBy,
        'description': description,
        'id': id,
        'name': name,
        'isPublic': isPublic,
        'isUnlimited': isUnlimited,
        'userLimit': userLimit,
        'users': users,
      };

  Group copyWith({
    String adminId,
    String adminName,
    String avatarUrl,
    DateTime createdAt,
    String createdBy,
    String description,
    String id,
    String name,
    bool isPublic,
    bool isUnlimited,
    int userLimit,
    Map<String, bool> users,
  }) {
    return Group(
      adminId: adminId ?? this.adminId,
      adminName: adminName ?? this.adminName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      description: description ?? this.description,
      id: id ?? this.id,
      name: name ?? this.name,
      isPublic: isPublic ?? this.isPublic,
      isUnlimited: isUnlimited ?? this.isUnlimited,
      userLimit: userLimit ?? this.userLimit,
      users: users ?? this.users,
    );
  }

  @override
  List<Object> get props {
    return [
      adminId,
      adminName,
      avatarUrl,
      createdAt,
      createdBy,
      description,
      id,
      name,
      isPublic,
      isUnlimited,
      userLimit,
      users,
      snapshot,
      reference,
      documentID,
    ];
  }
}
