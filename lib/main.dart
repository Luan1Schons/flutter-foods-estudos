// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './app/controllers/app_controller.dart';
import './app/views/home_widget.dart';
import './app/views/screen_widget.dart' as screen_page;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  runApp(AnimatedBuilder(
    animation: AppController.instance,
    builder: (context, child) {
      return MaterialApp(
        routes: {
          '/': (context) => const HomePage(titulo: 'Foods Machine'),
          '/screen': (context) => const screen_page.ScreenWidget(),
        },
        theme:
            ThemeData(primarySwatch: Colors.red, brightness: Brightness.light),
      );
    },
  ));
}
