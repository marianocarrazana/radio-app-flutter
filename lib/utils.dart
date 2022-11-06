import 'dart:typed_data';
import 'package:get_storage/get_storage.dart';

Uint8List getImageFromStorage(String name) {
	final box = GetStorage();
    var out;
    if (box.read(name) is List) {
      List<int> tmpout = new List<int>.from(box.read(name));
      out = Uint8List.fromList(List<int>.from(tmpout));
    } else
      out = box.read(name);
    return out;
  }
