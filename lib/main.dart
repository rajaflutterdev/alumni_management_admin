import 'package:alumni_management_admin/Screens/Signin.dart';
import 'package:alumni_management_admin/Screens/demo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var delegate = await LocalizationDelegate.create(
      basePath: 'assets/i18n/',
      fallbackLocale: 'en_US',
      supportedLocales: ['ta','te','ml','kn','en_US','bn','hi','es','pt','fr','nl','de','it','sv','mr','gu','ory','IN','or','ori']);
  runApp(LocalizedApp(delegate, MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
     return

      LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child:
      MaterialApp(
        title: 'Alumni_Management_Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
        //Testing_screen(),
        FirebaseAuth.instance.currentUser==null?const SigninPage():MyWidget(email: FirebaseAuth.instance.currentUser!.email),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,

      ),
    );
  }
}

