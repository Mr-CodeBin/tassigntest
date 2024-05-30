import 'package:fb2/cubit/auth_cubit.dart';
import 'package:fb2/cubit/student_cubit.dart';
import 'package:fb2/repository/auth_repository.dart';
import 'package:fb2/repository/student_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddStudentScreen extends StatelessWidget {
  AddStudentScreen() {
    _selectedGender = _genderList[0];
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String? _selectedGender;

  final List<String> _genderList = ['Male', 'Female', 'Other'];

  bool isValidDateFormat(String input) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    try {
      dateFormat.parseStrict(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Student Name',
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextField(
            controller: dobController,
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              hintText: 'dd/mm/yyyy',
              hintStyle: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.grey,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2025),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                    dobController.text = formattedDate;
                  }
                },
                icon: const Icon(Icons.calendar_today),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          DropdownButtonFormField<String>(
            isExpanded: false,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.black,
            ),
            value: _selectedGender,
            items: _genderList.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (newValue) {
              _selectedGender = newValue as String;
            },
            decoration: const InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text;
              //check if dob and name is empty
              if (name.isEmpty || dobController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all the fields'),
                  ),
                );
                return;
              }

              final dob = DateFormat('dd/MM/yyyy').parse(dobController.text);
              final gender = _selectedGender;

              // check if the name is empty then return an error
              if (name.isEmpty || name.trim().isEmpty || name.length < 3) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid Name'),
                  ),
                );
                return;
              }
              // check if the data is not in the correct format then return an error
              if (!isValidDateFormat(dobController.text)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid Date Format'),
                  ),
                );
                return;
              }

              if (name.isNotEmpty && dob != null && gender != null) {
                final userId = context.read<AuthCubit>().currentUser!.uid;
                context.read<StudentCubit>().addStudent(name, dob, gender);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data Submitted Successfully'),
                  ),
                );
              }
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                Size(
                  MediaQuery.of(context).size.width,
                  50,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: Text('Submit Data',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
