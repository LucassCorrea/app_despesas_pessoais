import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get helloWorld => 'Olá mundo';

  @override
  String valor_produto(double value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.currency(
      locale: localeName,
      
    );
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }
}
