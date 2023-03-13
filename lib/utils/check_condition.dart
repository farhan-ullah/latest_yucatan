import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

late Uint8List Imageurl;
Future<Uint8List> checkCondition() async {
  await Hive.openBox('mybox');

  var box = Hive.box('myBox');

  var name = box.get('imageData');

  Imageurl = name;

  return Imageurl;
}
