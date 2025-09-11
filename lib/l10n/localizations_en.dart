// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

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

  @override
  String dt_msg(DateTime val) {
    final intl.DateFormat valDateFormat = intl.DateFormat(
      'yyyy-MM-dd HH:mm:ss',
      localeName,
    );
    final String valString = valDateFormat.format(val);

    return 'Hello, dt:$valString';
  }

  @override
  String num_msg(int val) {
    final intl.NumberFormat valNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String valString = valNumberFormat.format(val);

    return 'Hello, num:$valString';
  }

  @override
  String str_msg(String val) {
    return 'Hello, str:$val';
  }
}
