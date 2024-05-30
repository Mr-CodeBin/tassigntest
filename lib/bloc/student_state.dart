part of 'student_bloc.dart';

sealed class StudentState extends Equatable {
  const StudentState();
  
  @override
  List<Object> get props => [];
}

final class StudentInitial extends StudentState {}
