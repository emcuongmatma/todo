import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/generated/assets.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final bool? isSearchBar;
  final bool? isPasswordTextField;
  final Function(String)? onChange;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.onChange,
    required this.hintText,
    this.errorText,
    this.isSearchBar,
    this.controller,
    this.isPasswordTextField,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 18,
        color: ColorDark.whiteFocus,
      ),
      controller: controller,
      focusNode: focusNode,
      obscureText: isPasswordTextField ?? false,
      textAlignVertical: TextAlignVertical.center,
      onChanged: (value) => onChange?.call(value),
      decoration: InputDecoration(
        prefixIcon: isSearchBar == true
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(Assets.iconsIcSearch),
              )
            : null,
        hintText: hintText,
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontSize: 18, color: ColorDark.gray),
        errorText: errorText,
      ),
    );
  }
}
