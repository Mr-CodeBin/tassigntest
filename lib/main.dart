import 'package:fb2/cubit/auth_cubit.dart';
import 'package:fb2/cubit/student_cubit.dart';
import 'package:fb2/repository/auth_repository.dart';
import 'package:fb2/repository/student_repository.dart';
import 'package:fb2/routes.dart';
import 'package:fb2/util.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.dotenv.load(); // Load .e

  DefaultFirebaseOptions.android = FirebaseOptions(
    apiKey: dotenv.dotenv.env['apiKey']!,
    appId: dotenv.dotenv.env['appId']!,
    messagingSenderId: dotenv.dotenv.env['messagingSenderId']!,
    projectId: dotenv.dotenv.env['projectId']!,
    storageBucket: dotenv.dotenv.env['storageBucket']!,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(AuthRepository())),
        BlocProvider(
          create: (context) => StudentCubit(
              StudentRepository(), context.read<AuthCubit>().currentUser!.uid),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: RoutesGenerator.generateRoute,
      ),
    );
  }
}
