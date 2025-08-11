class EmployeeModel {
  final int id;
  final String name;
  final String role;
  final String department;
  final String email;
  final String? profilePicture;
  final String? phone;
  final DateTime joinDate;

  const EmployeeModel({
    required this.id,
    required this.name,
    required this.role,
    required this.department,
    required this.email,
    this.profilePicture,
    this.phone,
    required this.joinDate,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      department: json['department'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      phone: json['phone'],
      joinDate: DateTime.parse(json['join_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'department': department,
      'email': email,
      'profile_picture': profilePicture,
      'phone': phone,
      'join_date': joinDate.toIso8601String(),
    };
  }

  EmployeeModel copyWith({
    int? id,
    String? name,
    String? role,
    String? department,
    String? email,
    String? profilePicture,
    String? phone,
    DateTime? joinDate,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      department: department ?? this.department,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      phone: phone ?? this.phone,
      joinDate: joinDate ?? this.joinDate,
    );
  }

  @override
  String toString() {
    return 'EmployeeModel(id: $id, name: $name, role: $role, department: $department, email: $email, profilePicture: $profilePicture, phone: $phone, joinDate: $joinDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeeModel &&
        other.id == id &&
        other.name == name &&
        other.role == role &&
        other.department == department &&
        other.email == email &&
        other.profilePicture == profilePicture &&
        other.phone == phone &&
        other.joinDate == joinDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        role.hashCode ^
        department.hashCode ^
        email.hashCode ^
        profilePicture.hashCode ^
        phone.hashCode ^
        joinDate.hashCode;
  }
}
