import 'package:flutter/material.dart';
import 'package:flutter_ai/constant/constant.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ResponseWidget extends StatelessWidget {
  final String responseText;
  const ResponseWidget({super.key, required this.responseText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.auto_awesome_rounded, color: AppColors.orange),
        HorizontalSpacing.medium,
        Expanded(
          child: Markdown(
            padding: EdgeInsets.zero,
            selectable: true,
            data: responseText,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }
}
