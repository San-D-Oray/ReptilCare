import 'package:flutter/material.dart';
import 'ui/shell/app_shell.dart';

class ReptileCareApp extends StatelessWidget {
  const ReptileCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReptileCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), useMaterial3: true),
      home: const AppShell(),
    );
  }
}