enum UserRole { parent, teacher }

/// Public user profile; never carries phone numbers or identity data.
class UserModel {
  final String id;
  final String displayName;
  final UserRole role;

  const UserModel({
    required this.id,
    required this.displayName,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        displayName: json['display_name'] as String,
        role: UserRole.values.byName(json['role'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'display_name': displayName,
        'role': role.name,
      };
}
