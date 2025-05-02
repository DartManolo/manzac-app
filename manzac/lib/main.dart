import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/date_symbol_data_local.dart';

import 'app/modules/alpha/alpha_binding.dart';
import 'app/modules/alpha/alpha_page.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/app_configuration.dart';
import 'app/utils/color_list.dart';

void main() {
  AppConfiguration.init();
  initializeDateFormatting(
    'es_MX',
    null
  ).then((_) => runApp(const Manzac()));
}

class Manzac extends StatelessWidget {
  const Manzac({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Manzac",
      theme: ThemeData(
        primarySwatch: Color(
          ColorList.sys[0],
        ).toMaterialColor(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      getPages: AppPages.pages,
      home: const AlphaPage(),
      initialBinding: AlphaBinding(),
    );
  }
}