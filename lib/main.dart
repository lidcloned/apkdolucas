import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/user_provider.dart';
import 'utils/theme_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Forçar orientação retrato
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const LAMAFIAApp());
}

class LAMAFIAApp extends StatelessWidget {
  const LAMAFIAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'LaMafia: Federação',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            primary: ThemeConstants.primaryColor,
            secondary: ThemeConstants.accentColor,
            background: ThemeConstants.backgroundColor,
            surface: ThemeConstants.surfaceColor,
            error: ThemeConstants.dangerColor,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: ThemeConstants.backgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: ThemeConstants.surfaceColor,
            foregroundColor: ThemeConstants.textColor,
            elevation: 4,
          ),
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: ThemeConstants.textColor),
            bodyMedium: TextStyle(color: ThemeConstants.textSecondaryColor),
            titleLarge: TextStyle(
              color: ThemeConstants.textColor, 
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          cardTheme: CardThemeData(
            color: ThemeConstants.surfaceColor,
            elevation: 2,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeConstants.primaryColor,
              foregroundColor: ThemeConstants.textColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: ThemeConstants.inputBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ThemeConstants.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ThemeConstants.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ThemeConstants.accentColor, width: 2),
            ),
            labelStyle: TextStyle(color: ThemeConstants.textSecondaryColor),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
