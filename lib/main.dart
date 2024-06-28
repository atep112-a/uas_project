import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sembast_web/sembast_web.dart';
import 'dashboard.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  print("WidgetsFlutterBinding initialized");

  if (kIsWeb) {
    // Use sembast for web
    // Initialization for sembast is handled internally
    print("Using sembast for web");
  } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Initialize FFI (only necessary for desktop, for mobile it's not needed)
    sqfliteFfiInit();
    // Change the default factory for sqflite to the FFI implementation
    databaseFactory = databaseFactoryFfi;
    print("Database factory initialized for FFI");
  }

  runApp(MyApp());
  print("App started");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    print("Building MyApp widget");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(),
    );
  }
}
