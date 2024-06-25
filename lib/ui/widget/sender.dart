import 'package:flutter/material.dart';
import 'package:flutter_ai/constant/constant.dart';

class SenderWidget extends StatelessWidget {
  final String senderText;
  const SenderWidget({super.key, required this.senderText});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Card(
        child: Padding(
          padding: context.mediumGap,
          child: Text(senderText),
        ),
      ),
    );
  }
}
