import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:yucatan/routes/custom_routes.dart';
import 'package:yucatan/screens/splash_screen/splash_screen.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yucatan/utils/theme_model.dart';

import 'l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  await Hive.initFlutter();
  Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState>? navigatorKey;
    return ChangeNotifierProvider<ThemeModel>(
      create: (BuildContext context) => ThemeModel(),
      child: Consumer<ThemeModel>(builder: (context, model, __) {
        return ScreenUtilInit(
          designSize: const Size(1284, 2778),
          builder: (context, child) => MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              //to add support for each generated language
              //supportedLocales: AppLocalizations.supportedLocales,

              supportedLocales: L10n.all,
              locale: model.locale,
              theme: ThemeData(
                dividerColor: model.dividerColor,
                textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: model.textColor, displayColor: model.textColor),
                appBarTheme: AppBarTheme(color: model.primaryMainColor),
                primaryColor: model.primaryMainColor,
                accentColor: model.accentColor,
              ),
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              initialRoute: SplashScreen.route,
              routes: CustomRoutes.routes),
        );
      }),
    );
  }
}
