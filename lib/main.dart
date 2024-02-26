import 'package:flutter/material.dart';
import 'package:note_pad/controllers/notes_provider.dart';
import 'package:note_pad/views/screens/home/home_screen.dart';
import 'package:note_pad/views/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<NotesProvider>(create: (_) => NotesProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().getAppTheme(),
      home: HomeScreen(),
    );
  }
}
