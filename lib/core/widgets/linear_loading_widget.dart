
import 'package:flutter/material.dart';

class LinearLoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.black,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );
  }
}
