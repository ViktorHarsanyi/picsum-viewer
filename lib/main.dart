import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pic_sum/logic/logic.dart';
import 'ui/ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    return MaterialApp(
      title: 'Picsum API Demo',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
        ),
        dialogBackgroundColor: Colors.indigoAccent,
        dialogTheme: const DialogTheme(
            titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        )),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.indigo,
          linearTrackColor: Colors.red,
          circularTrackColor: Colors.indigoAccent,
        ),
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.indigoAccent,
        ),
      ),
      home: BlocProvider<PicsCubit>(
        create: (context) => PicsCubit(),
        child: const SafeArea(child: AppShell()),
      ),
    );
  }
}
