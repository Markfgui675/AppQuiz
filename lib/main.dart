import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home.dart';

void main(){
  runApp(ProviderScope(child: MaterialApp(
    routes: {
      "/home": (cotext) => Home()
    },
    home: Home(),
  )));
}
