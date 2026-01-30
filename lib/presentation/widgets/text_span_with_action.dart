import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextSpanWithAction extends StatelessWidget {
  final String text1;
  final String text2;
  final Function? onAction;

  const TextSpanWithAction({
    super.key,
    required this.text1,
    required this.text2,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.titleMedium,
        children: <TextSpan>[
          TextSpan(text: text1),
          TextSpan(
            text: text2,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onAction?.call();
              },
          ),
        ],
      ),
    );
  }
}