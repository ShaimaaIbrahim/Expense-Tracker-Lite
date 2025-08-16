import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double? width;
  final double? height;
  const Space({super.key,  this.width,  this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height
    );
  }
}
