import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ticky/firebase_options.dart';
import 'package:ticky/flavors/flavor_config.dart';
import 'package:ticky/flavors/flavour_functions.dart';
import 'package:ticky/initialization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  initialFunction();

  flavors = Flavors.staging;

  runApp(
    MyApp(
      flavors: flavors,
    ),
  );
}
