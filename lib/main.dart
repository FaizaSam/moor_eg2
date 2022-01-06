//import 'dart:ffi';

//import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:moor_eg2/data/moor_database.dart';
import 'package:provider/provider.dart';

import './ui/homepage.dart';

void main(List<String> args) => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        builder: (_) => AppDatabase(),
        create: (BuildContext context) {},
        child: MaterialApp(
          title: 'Material App',
          home: HomePage(),
        ));
  }
}
