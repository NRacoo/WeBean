class ProfileModel {
  final String username;
  final String? email;
  final String? phone;
  final String? address;
  final DateTime? birth;
  final String? imageProfile;

  ProfileModel({
    required this.username,
    this.email,
    this.phone,
    this.address,
    this.birth,
    this.imageProfile,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      birth: json['birth'] != null ? DateTime.parse(json['birth']) : null,
      imageProfile: json['imageProfile'],
    );
  }

  ProfileModel copyWith({
    String? username,
    String? email,
    String? phone,
    String? address,
    String? imageProfile,
    DateTime? birth,
  }) {
    return ProfileModel(
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      imageProfile: imageProfile ?? this.imageProfile,
      birth: birth ?? this.birth
    );
  }
}
