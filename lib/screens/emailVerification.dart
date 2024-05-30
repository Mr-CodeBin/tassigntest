// i want to verify the email of the user

import 'package:fb2/cubit/auth_cubit.dart';
import 'package:fb2/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSignedIn) {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Please verify your email'),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Email verification link sent. please verify your email')));
                },
                child: const Text('send verification email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
