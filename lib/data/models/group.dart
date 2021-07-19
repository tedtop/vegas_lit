import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  Group({
    this.adminId,
    this.adminName,
    this.createdAt,
    this.createdBy,
    this.description,
    this.id,
    this.name,
    this.type,
    this.userLimit,
    this.users,
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
      createdAt: map['createdAt'],
      createdBy: map['createdBy'],
      description: map['description'],
      id: map['id'],
      name: map['name'],
      type: map['type'],
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
      createdAt: map['createdAt'],
      createdBy: map['createdBy'],
      description: map['description'],
      id: map['id'],
      name: map['name'],
      type: map['type'],
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
        'type': type,
        'userLimit': userLimit,
        'users': users,
      };

  Group copyWith({
    String adminId,
    String adminName,
    String createdAt,
    String createdBy,
    String description,
    String id,
    String name,
    String type,
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
      type: type ?? this.type,
      userLimit: userLimit ?? this.userLimit,
      users: users ?? this.users,
    );
  }

  final String adminId;
  final String adminName;
  final String createdAt;
  final String createdBy;
  final String description;
  final String id;
  final String name;
  final String type;
  final int userLimit;
  final List<String> users;
  final DocumentSnapshot snapshot;
  final DocumentReference reference;
  final String documentID;

  @override
  String toString() {
    return '${adminId.toString()}, ${adminName.toString()}, ${createdAt.toString()}, ${createdBy.toString()}, ${description.toString()}, ${id.toString()}, ${name.toString()}, ${type.toString()}, ${userLimit.toString()}, ${users.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Group && documentID == other.documentID;

  @override
  int get hashCode => documentID.hashCode;
}
