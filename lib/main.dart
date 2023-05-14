import 'package:dev_connector_app/src/core/navigation/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dev Connector',
      theme: ThemeData(
        useMaterial3: true,
        canvasColor: Colors.deepPurple,
        textTheme: GoogleFonts.righteousTextTheme().copyWith(
          displayLarge: TextStyle(
            fontFamily: GoogleFonts.righteous().fontFamily,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontFamily: GoogleFonts.righteous().fontFamily,
            color: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
