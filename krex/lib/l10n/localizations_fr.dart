// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String welcom_msg(Object name) {
    return 'Bonjour, $name!';
  }

  @override
  String some_apples(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apples',
      one: '1 apple',
      zero: 'no apples',
    );
    return 'Bonjour, $_temp0';
  }

  @override
  String get escap => 'Bonjour! {Isn\'t} this\'s a wonderful day?';
}
