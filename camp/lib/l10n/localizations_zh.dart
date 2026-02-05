// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String welcom_msg(Object name) {
    return '你好, $name!';
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
    return '你好, $_temp0';
  }

  @override
  String get escap => '你好! {Isn\'t} this\'s a wonderful day?';

  @override
  String dt_msg(DateTime val) {
    final intl.DateFormat valDateFormat = intl.DateFormat.Hms(localeName);
    final String valString = valDateFormat.format(val);

    return '你好, dt:$valString';
  }

  @override
  String num_msg(int val) {
    final intl.NumberFormat valNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String valString = valNumberFormat.format(val);

    return '你好, num:$valString';
  }

  @override
  String str_msg(String val) {
    return '你好, str:$val';
  }
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String welcom_msg(Object name) {
    return '您好, $name!';
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
    return '您好, $_temp0';
  }

  @override
  String get escap => '您好! {Isn\'t} this\'s a wonderful day?';

  @override
  String dt_msg(DateTime val) {
    final intl.DateFormat valDateFormat = intl.DateFormat.Hms(localeName);
    final String valString = valDateFormat.format(val);

    return '您好, dt:$valString';
  }

  @override
  String num_msg(int val) {
    final intl.NumberFormat valNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String valString = valNumberFormat.format(val);

    return '您好, num:$valString';
  }

  @override
  String str_msg(String val) {
    return '您好, str:$val';
  }
}
