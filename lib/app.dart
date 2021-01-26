import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_motivation_quotes/blocs/bloc/quote_bloc.dart';
import 'package:flutter_motivation_quotes/models/quote.dart';
import 'package:flutter_motivation_quotes/repositories/sample_quote_repository.dart';

import 'screens/home/home.dart';
import 'utils/locales/global_localizations.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    globalLocales.setNewLanguage('vi');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
          create: (_) => QuoteBloc(quoteRepository: SampleQuoteRepository())
            ..add(FetchQuotes()),
          child: Home()),
      debugShowCheckedModeBanner: false,
    );
  }
}
