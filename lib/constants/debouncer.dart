import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
