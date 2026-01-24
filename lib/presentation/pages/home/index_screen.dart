import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/generated/assets.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Image.asset(
            Assets.imagesImageHomeBackground,
            width: 227,
            height: 227,
          ),
          Text(
            AppConstants.WHAT_DO_YOU_WANT_TO_DO,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: ColorDark.whiteFocus),
          ),
          Text(
            AppConstants.TAP_TO_ADD_TASK,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: ColorDark.whiteFocus),
          ),
        ],
      ),
    );
  }
}
