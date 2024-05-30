import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb2/cubit/auth_cubit.dart';
import 'package:fb2/cubit/student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StudentDataScreen extends StatelessWidget {
  const StudentDataScreen({super.key});

  // late User user;
  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthCubit>().currentUser!.uid;

    context.read<StudentCubit>().loadStudents();
    return BlocBuilder<StudentCubit, StudentState>(builder: (context, state) {
      if (state is StudentLoaded) {
        final std = state.students;
        return ListView.builder(
          itemCount: std.length,
          itemBuilder: (context, index) {
            final student = std[index];
            String formattedDate =
                DateFormat('dd/MM/yyyy').format(student.dateOfBirth);
            String captilizedName = student.name
                .split(' ')
                .map((word) => word[0].toUpperCase() + word.substring(1))
                .join(' ');

            return ListTile(
                title: Text(
                  captilizedName,
                ),
                subtitle: Text('${formattedDate} - ${student.gender}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('teachers')
                        .doc(userId)
                        .collection('students')
                        .doc(student.id)
                        .delete();
                  },
                ));
          },
        );
      } else if (state is StudentError) {
        return Center(
          child: Text('Failed to load students: ${state.message}'),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
