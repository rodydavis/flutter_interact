import 'package:fb_auth/fb_auth.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FbApp get app => FbApp(
        apiKey: "AIzaSyBwM3MfNTOIn1mXd4iV3WNAFTVIKDRpkbQ",
        authDomain: "flutter-interact-78798.firebaseapp.com",
        databaseURL: "https://flutter-interact-78798.firebaseio.com",
        projectId: "flutter-interact-78798",
        storageBucket: "flutter-interact-78798.appspot.com",
        messagingSenderId: "838571112194",
        appId: "1:838571112194:web:dd59919b1a5c134509f41b",
        measurementId: "G-RJ16HL2MJR",
      );
  final _auth = AuthBloc(app: app);

  @override
  void initState() {
    try {
      FBAuth(app).onAuthChanged().listen((data) {
        if (data != null) {
          _auth.add(ChangeUser(data));
        } else {
          _auth.add(LogoutEvent(data));
        }
      });
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;
    final router = GetIt.instance.get<Router>();
    Routes.configureRoutes(router);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => _auth),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
