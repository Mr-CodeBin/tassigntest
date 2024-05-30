import 'package:bloc/bloc.dart';
import 'package:fb2/repository/student_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentCubit extends Cubit<StudentState> {
  final StudentRepository _studentRepository;
  final String userId;

  StudentCubit(this._studentRepository, this.userId) : super(StudentInitial());

  User? get currentUser => _studentRepository.currentUser;

  void addStudent(String name, DateTime dob, String gender) async {
    try {
      await _studentRepository.addStudent(
        userId,
        name,
        dob,
        gender,
      );
      emit(StudentAdded());
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  void loadStudents() async {
    try {
      final students =
          _studentRepository.getStudents(userId).listen((students) {
        emit(StudentLoaded(students));
      });
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  void updateStudent(
      String studentId, String name, DateTime dob, String gender) async {
    try {
      await _studentRepository.updateStudent(
          userId, studentId, name, dob, gender);
      emit(StudentUpdated());
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  // void deleteStudent(String studentId) async {
  //   try {
  //     await _studentRepository.deleteStudent(userId, studentId );
  //     emit(StudentUpdated());
  //   } catch (e) {
  //     emit(StudentError(e.toString()));
  //   }
  // }
}

abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentAdded extends StudentState {}

class StudentLoaded extends StudentState {
  final List<Student> students;

  StudentLoaded(this.students);
}

class StudentUpdated extends StudentState {}

class StudentError extends StudentState {
  final String message;

  StudentError(this.message);
}
