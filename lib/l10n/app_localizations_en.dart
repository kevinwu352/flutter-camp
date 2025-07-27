// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String welcom_msg(Object name) {
    return 'Hello, $name!';
  }

  @override
  String n_wombats(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wombats',
      one: '1 wombat',
      zero: 'no wombats',
    );
    return 'Hello, $_temp0';
  }

  @override
  String get escap => 'Hello! {Isn\'t} this\'s a wonderful day?';
}
