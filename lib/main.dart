import 'package:flutter/material.dart';
import 'src/core/injection/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/presentation/bloc/characters_bloc.dart';
import 'src/presentation/pages/characters_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<CharactersBloc>(
          create: (_) => getIt(), child: const CharactersView()),
    );
  }
}
