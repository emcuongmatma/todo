import 'package:flutter/material.dart';
import 'package:todo/core/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final Function(String) onChange;

  const CustomTextField({
    super.key,
    required this.onChange,
    required this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 18,
        color: ColorDark.whiteFocus,
      ),
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontSize: 18, color: ColorDark.gray),
        errorText: errorText,
      ),
    );
  }
}
