import 'package:fb2/cubit/auth_cubit.dart';
import 'package:fb2/cubit/auth_state.dart';
import 'package:fb2/screens/emailVerification.dart';
import 'package:fb2/screens/homescreen.dart';
import 'package:fb2/screens/login.dart';
import 'package:fb2/screens/signup.dart';
import 'package:fb2/screens/studentViews/studentData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSignedIn) {
                return const HomeScreen();
              } else {
                return const LoginScreen();
              }
            },
          ),
        );
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case '/email-verification':
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: context.read<AuthCubit>(),
                  child: const EmailVerificationScreen(),
                ));
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return _errorRoute(settings);
    }
  }

  static MaterialPageRoute<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Page not found',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        body: Center(
          child: Text(
            'Page does not exist',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
    });
  }
}
