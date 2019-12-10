import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interact/generated/i18n.dart';
import 'package:flutter_interact/plugins/navigator/navigator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

import 'ui/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final sl = GetIt.instance;
  sl.registerSingleton<Router>(Router());
  sl.registerSingleton<Firestore>(firestore());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;
    final router = GetIt.instance.get<Router>();
    Routes.configureRoutes(router);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Interact 2019',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: NavUtils.initialUrl,
      onGenerateTitle: (context) => I18n.of(context).title,
      locale: Locale("en", "US"),
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback: i18n.resolution(
        fallback: Locale("en", "US"),
      ),
      onGenerateRoute: router.generator,
    );
  }
}
