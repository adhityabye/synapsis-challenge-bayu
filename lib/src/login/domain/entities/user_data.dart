class UserData {
  final String userId;
  final String nik;
  final int systemRoleId;
  final String systemRole;
  final String name;
  final String email;
  final String phone;
  final String departmentId;
  final String department;
  final String siteLocationId;
  final String siteLocation;

  UserData({
    required this.userId,
    required this.nik,
    required this.systemRoleId,
    required this.systemRole,
    required this.name,
    required this.email,
    required this.phone,
    required this.departmentId,
    required this.department,
    required this.siteLocationId,
    required this.siteLocation,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['user_id'],
      nik: json['nik'],
      systemRoleId: json['system_role_id'],
      systemRole: json['system_role'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      departmentId: json['departement_id'],
      department: json['departement'],
      siteLocationId: json['site_location_id'],
      siteLocation: json['site_location'],
    );
  }
}
