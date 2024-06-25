import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40,
      width: 40,
      child: LoadingIndicator(
        indicatorType: Indicator.ballClipRotateMultiple,
      ),
    );
  }
}
