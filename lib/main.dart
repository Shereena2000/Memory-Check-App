import 'package:flip_card/providers/memory_game_provider.dart';
import 'package:flip_card/screens/splash_screen.dart';

import 'package:flip_card/utils/colors_constand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => MemoryGameProvider(),child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          displaySmall: GoogleFonts.orbitron(
            fontSize:20,
            color: yellowColor,
            letterSpacing: 2,
          ),
          
          displayMedium: GoogleFonts.orbitron(
            fontSize: 25,
            color:whiteColor,
            letterSpacing: 2,
          ),
        ),
        appBarTheme: AppBarTheme(color:blackColor),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen()
    );
  }
}
