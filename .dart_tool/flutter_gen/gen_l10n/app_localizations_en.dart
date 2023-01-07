import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World';

  @override
  String valor_produto(double value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.currency(
      locale: localeName,
      
    );
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }
}
