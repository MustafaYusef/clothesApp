import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class circularProgress extends StatelessWidget {
  const circularProgress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: Lottie.asset('assets/images/loading.json',
          fit: BoxFit.fill, width: 150),
      data: new ThemeData(
        primaryColor: Colors.blueAccent,
        primaryColorDark: Colors.red,
      ),
    );
  }
}
