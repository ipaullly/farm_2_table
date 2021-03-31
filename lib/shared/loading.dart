import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent[200],
      child: Center(
        child: SpinKitWanderingCubes(
          color: Colors.black,
          size: 50.0,
        ),
      ),
    );
  }
}