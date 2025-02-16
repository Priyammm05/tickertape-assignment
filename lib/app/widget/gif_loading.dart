import 'package:flutter/material.dart';
import 'package:tickertape_assignment/app/constants/constants.dart';

class GIFLoading extends StatelessWidget {
  const GIFLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Constants.loadingImage,
    );
  }
}
