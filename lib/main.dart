import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pipmovie/halamanUtama.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
  runApp(
    GetMaterialApp(
      title: 'PMovie',
      debugShowCheckedModeBanner: false,
      home: HalamanUtama(),
    )
  );
}

