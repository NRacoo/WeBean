class ProfileModel {
  final String username;
  final String? email;
  final String? phone;
  final String? address;
  final String? birth;
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
      birth: json['birth'],
      imageProfile: json['imageProfile'],
    );
  }
}
