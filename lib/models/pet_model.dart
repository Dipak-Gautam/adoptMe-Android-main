// // ignore_for_file: file_names

// import 'dart:ffi';

// class Pet {
//   final String nickname;
//   final String category;
//   final String breed;
//   final String age;
//   final String color;
//   final String gender;
//   final String weight;
//   final String health;
//   final String location;
//   final String imageUrl;
//   final Int stars;
//   final String uid;
//   final String pid;

//   Pet({
//     required this.nickname,
//     required this.category,
//     required this.breed,
//     required this.age,
//     required this.color,
//     required this.gender,
//     required this.weight,
//     required this.health,
//     required this.location,
//     required this.imageUrl,
//     required this.stars,
//     required this.uid,
//     required this.pid,
//   });

//   // factory Pet.fromJson(Map<String, dynamic> json) {
//   //   return Pet(
//   //     nickname: json['nickname'],
//   //     breed: json['breed'],
//   //     age: json['age'],
//   //     color: json['color'],
//   //     weight: json['weight'],
//   //     location: json['location'],
//   //     imageUrl: json['imageUrl'],
//   //   );
//   // }
//   factory Pet.fromJson(Map<String, dynamic> json) {
//     return Pet(
//       nickname: json['nickname'],
//       category: json['category'],
//       breed: json['breed'],
//       age: json['age'],
//       color: json['color'],
//       gender: json['gender'],
//       stars: json['stars'],
//       weight: json['weight'],
//       health: json['health'],
//       location: json['location'],
//       imageUrl: json['image'],
//       uid: json['uid'].toString(),
//       pid: json['_id'].toString(),
//     );
//   }
// }
class Pet {
  String pid;
  String uid;
  String nickname;
  String category;
  String gender;
  String breed;
  String age;
  String weight;
  String health;
  String color;
  String location;
  String imageUrl;
  String bookedFlag;
  int stars;

  Pet({
    required this.pid,
    required this.uid,
    required this.nickname,
    required this.category,
    required this.gender,
    required this.breed,
    required this.age,
    required this.weight,
    required this.health,
    required this.color,
    required this.location,
    required this.imageUrl,
    required this.bookedFlag,
    required this.stars,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      pid: json['_id'],
      uid: json['uid'],
      nickname: json['nickname'],
      category: json['category'],
      gender: json['gender'],
      breed: json['breed'],
      age: json['age'],
      weight: json['weight'],
      health: json['health'],
      color: json['color'],
      location: json['location'],
      imageUrl: json['image'],
      bookedFlag: json['bookedFlag'],
      stars: json['stars'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     '_id': uid,
  //     'nickname': nickname,
  //     'category': category,
  //     'breed': breed,
  //     'age': age,
  //     'weight': weight,
  //     'health': health,
  //     'color': color,
  //     'location': location,
  //     'image': image,
  //     'bookedFlag': bookedFlag,
  //     'stars': stars,
  //   };
  // }
}



// class Pet {
//   final String id;
//   final User user;
//   final String nickname;
//   final String category;
//   final String breed;
//   final String age;
//   final String weight;
//   final String health;
//   final String color;
//   final String location;
//   final String image;
//   final bool bookedFlag;
//   final int stars;
//   final String gender;

//   Pet({
//     required this.id,
//     required this.user,
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
//     required this.stars,
//     required this.gender,
//   });

//   factory Pet.fromJson(Map<String, dynamic> json) {
//     return Pet(
//       id: json['_id'],
//       user: User.fromJson(json['uid']),
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
//       stars: json['stars'],
//       gender: json['gender'],
//     );
//   }
// }

// class User {
//   final String id;
//   final String username;
//   final String email;
//   final bool isVerified;

//   User({
//     required this.id,
//     required this.username,
//     required this.email,
//     required this.isVerified,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'],
//       username: json['username'],
//       email: json['email'],
//       isVerified: json['isVerified'],
//     );
//   }
// }
