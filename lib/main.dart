import 'package:flutter/material.dart';

import 'screens/home.dart';

void main(){
  runApp(MaterialApp(
    routes: {
      "/home": (cotext) => Home()
    },
    home: Home(),
  ));
}
