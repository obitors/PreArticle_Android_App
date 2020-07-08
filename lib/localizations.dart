import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

part 'localizations2.dart';
//https://github.com/aloisdeniel/flutter_sheet_localization
//to rebuild language files
//delete the localizations.g.dart file
//on command line run...
//flutter packages pub run build_runner build

@SheetLocalization("1sWpGZVJTzp_hVdcGyZknE00iWYC9DNtb6etV0se_Q7k",
    "0") // <- See 1. to get DOCID and SHEETID
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.languages.containsKey(locale);
  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
