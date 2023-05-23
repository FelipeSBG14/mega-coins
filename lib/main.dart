import 'package:firebase_core/firebase_core.dart';
import 'src/core/env/env.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import './src/app_module.dart';
import './src/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Env.instance.load();
  return runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ),
  );
}
