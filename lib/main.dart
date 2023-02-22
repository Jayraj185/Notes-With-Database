import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes/Screens/HomeScreen/view/HomePage.dart';
import 'package:notes/Screens/NoteAddScreen/View/NoteAddPage.dart';
import 'package:sizer/sizer.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/' : (context) => HomePage(),
            'NoteAdd' : (context) => NoteAddPage(),
          },
        );
      },
    )
  );
}