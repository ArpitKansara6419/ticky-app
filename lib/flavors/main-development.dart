import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ticky/firebase_options.dart';
import 'package:ticky/flavors/flavour_functions.dart';
import 'package:ticky/initialization.dart';

import 'flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  initialFunction();

  flavors = Flavors.development;

  runApp(
    MyApp(
      flavors: flavors,
    ),
  );
}
