import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/* debouncer class is for whenever we are searching results on pressing of 
keys in keypad to delay the search to avoid unwanted requests*/
class Debouncer {
  final int seconds;
  Timer? _timer;
  Debouncer({required this.seconds});
  void run(VoidCallback callBack) {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: seconds), callBack);
  }

  void dispose() {
    _timer?.cancel();
  }
}
