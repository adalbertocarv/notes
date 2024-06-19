import 'package:flutter/material.dart';
import 'package:notes/models/note_database.dart';
import 'package:notes/theme/theme_provider.dart';
import 'pages/notes_page.dart';
import 'package:provider/provider.dart';

void main() async {

  // iniciar a nota
  WidgetsFlutterBinding.ensureInitialized();
    await NoteDatabase.initialize();


  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NoteDatabase()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NotesPage(),
        theme: Provider.of<ThemeProvider>(context).themeData,
      );
    }
  }