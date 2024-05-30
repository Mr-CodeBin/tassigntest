import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class StudentRepository {
  final FirebaseFirestore _firestore;

  StudentRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> addStudent(
      String userId, String name, DateTime dateOfBirth, String gender) {
    // String formattedDate = DateFormat('dd-MM-yyyy').format(dateOfBirth);
    return _firestore
        .collection('teachers')
        .doc(userId)
        .collection('students')
        .add({
      'name': name,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
    });
  }

  Stream<List<Student>> getStudents(String userId) {
    return _firestore
        .collection('teachers')
        .doc(userId)
        .collection('students')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Student.fromSnapshot(doc)).toList());
  }

  Future<void> updateStudent(String userId, String studentId, String name,
      DateTime dateOfBirth, String gender) {
    return _firestore
        .collection('teachers')
        .doc(userId)
        .collection('students')
        .doc(studentId)
        .update({
      'name': name,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
    });
  }

  Future<void> deleteStudent(String userId, Student student) {
    return FirebaseFirestore.instance
        .collection('teachers')
        .doc(userId)
        .collection('students')
        .doc(student.id)
        .delete();
  }
}

class Student {
  final String id;
  final String name;
  final DateTime dateOfBirth;
  final String gender;

  Student({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
  });

  factory Student.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return Student(
      id: snap.id,
      name: data['name'],
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
      gender: data['gender'],
    );
  }
}
