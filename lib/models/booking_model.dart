import './exports.dart';

class Booking {
  String id;
  UserDetails user;
  Pet pet;
  String date;
  String time;

  Booking({
    required this.id,
    required this.user,
    required this.pet,
    required this.date,
    required this.time,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      user: UserDetails.fromJson(json['user']),
      pet: Pet.fromJson(json['pet']),
      date: json['date'],
      time: json['time'],
    );
  }
}

// class User {
//   String id;
//   String image;
//   String name;
//   String phone;
//   String mobile;
//   String address;
//   String email;

//   User({
//     required this.id,
//     required this.image,
//     required this.name,
//     required this.phone,
//     required this.mobile,
//     required this.address,
//     required this.email,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'],
//       image: json['image'],
//       name: json['name'],
//       phone: json['phone'],
//       mobile: json['mobile'],
//       address: json['address'],
//       email: json['email'],
//     );
//   }
// }

// class Pet {
//   String id;
//   String uid;
//   String nickname;
//   String category;
//   String breed;
//   String age;
//   String weight;
//   String health;
//   String color;
//   String location;
//   String image;
//   bool bookedFlag;
//   String gender;
//   int stars;

//   Pet({
//     required this.id,
//     required this.uid,
//     required this.nickname,
//     required this.category,
//     required this.breed,
//     required this.age,
//     required this.weight,
//     required this.health,
//     required this.color,
//     required this.location,
//     required this.image,
//     required this.bookedFlag,
//     required this.gender,
//     required this.stars,
//   });

//   factory Pet.fromJson(Map<String, dynamic> json) {
//     return Pet(
//       id: json['_id'],
//       uid: json['uid'],
//       nickname: json['nickname'],
//       category: json['category'],
//       breed: json['breed'],
//       age: json['age'],
//       weight: json['weight'],
//       health: json['health'],
//       color: json['color'],
//       location: json['location'],
//       image: json['image'],
//       bookedFlag: json['bookedFlag'],
//       gender: json['gender'],
//       stars: json['stars'],
//     );
//   }
// }
