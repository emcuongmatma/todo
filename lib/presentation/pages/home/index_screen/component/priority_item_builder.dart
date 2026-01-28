import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/generated/assets.dart';

class PriorityItemBuilder extends StatelessWidget {
  final int priority;

  const PriorityItemBuilder({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
      decoration: BoxDecoration(
        border: BoxBorder.all(color: ColorDark.primary, width: 1),
        borderRadius: const BorderRadiusGeometry.all(Radius.circular(4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          SvgPicture.asset(Assets.iconsIcFlag, width: 14, height: 14),
          Text(
            priority.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}