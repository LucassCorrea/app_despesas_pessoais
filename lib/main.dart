import 'package:app_despesas_pessoais/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:intl/intl.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // locale: const Locale("en", ""),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: tema.copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.purple,
        ),
        textTheme: TextTheme(),
        colorScheme: tema.colorScheme.copyWith(),
      ),
    );
  }
}
