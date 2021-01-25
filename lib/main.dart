import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_motivation_quotes/app.dart';
import 'customIcons.dart';
import 'config/data.dart';
import 'dart:math';

import 'screens/home/home.dart';
import 'utils/locales/global_localizations.dart';
import 'widgets/widgets.dart';

///
/// https://github.com/jamesseanwright/ron-swanson-quotes
/// http://forismatic.com/en/api/
/// https://quotesondesign.com/api/
/// https://pprathameshmore.github.io/QuoteGarden/
/// https://github.com/lukePeavey/quotable
/// https://kanye.rest/
///
/// http://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;

  // Handling any errors
  // TODO: re-open
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   print('=== onError ============>');
  //   FlutterError.dumpErrorToConsole(details);
  //   if (kReleaseMode) exit(1);
  //   // Send report: using sentry.io
  // };

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  // Initializes the translation module
  await globalLocales.init();

  return runApp(AppView());
}
