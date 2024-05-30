// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';

// class StudentModel extends Equatable {
//   final String name;
//   final String dateOfBirth;
//   final String gender;

//   StudentModel({
//     required this.name,
//     required this.dateOfBirth,
//     required this.gender,
//   });

//   @override
//   List<Object?> get props => [
//         name,
//         dateOfBirth,
//         gender,
//       ];

//   static StudentModel fromSnapshot(DocumentSnapshot snap) {
//     StudentModel student = StudentModel(
//       name: snap['name'],
//       dateOfBirth: snap['dateOfBirth'],
//       gender: snap['gender'],
//     );
//     return student;
//   }

//   static List<StudentModel> students = [
//     StudentModel(
//       name: 'John Doe',
//       dateOfBirth: '01-01-2000',
//       gender: 'male',
//     )
//   ];

//   // factory StudentModel.fromJson(Map<String, dynamic> json) {
//   //   return StudentModel(
//   //     name: json['name'],
//   //     dateOfBirth: json['dateOfBirth'],
//   //     gender: json['gender'],
//   //   );
//   // }
// }
