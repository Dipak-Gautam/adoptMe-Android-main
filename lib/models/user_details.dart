import 'dart:convert';

class UserDetails {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String phone;
  final String address;
  final String urlImage;

  UserDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.phone,
    required this.address,
    required this.urlImage,
  });
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      phone: json['phone'],
      address: json['address'],
      urlImage: json['image'],
    );
  }
}
