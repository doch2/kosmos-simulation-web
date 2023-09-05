import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kosmos_simulation_web/routes/pages.dart';

import 'routes/routes.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  Get.put<Dio>(Dio(), permanent: true);


  runApp(
    GetMaterialApp(
        title: 'KOSMOS',
        initialRoute: PageRoutes.HOME,
        getPages: KOSMOSSimulationWebPages.pages,
        debugShowCheckedModeBanner: false
    ),
  );
}