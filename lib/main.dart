import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
/*import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';*/
import 'app/data/local/my_shared_pref.dart';
import 'app/modules/splash/bindings/splash_binding.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';
import 'config/translations/localization_service.dart';

import 'app/modules/dashboard/controllers/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MySharedPref.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

 /*await FacebookAuth.instance.login();*/

  await initializeDateFormatting(
      LocalizationService.getCurrentLocal().languageCode);

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Controller()),
          ],
          child: GetMaterialApp(
            title: 'FarmMate',
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return Theme(
                data: MyTheme.getThemeData(
                    isLight: MySharedPref.getThemeIsLight()),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                ),
              );
            },
            initialBinding: SplashBinding(),
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            translations: LocalizationService.getInstance(),
          ),
        );
      },
    ),
  );
}
