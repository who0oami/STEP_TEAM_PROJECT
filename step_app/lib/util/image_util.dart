import 'package:flutter/services.dart';

Future<Uint8List> loadImageBytes(String path) async {
  final data = await rootBundle.load(path);
  return data.buffer.asUint8List();
}
