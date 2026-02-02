import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/core/theme/colors.dart';

class TaskInfoItem extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String info;
  final String? icon;
  final VoidCallback onClick;

  const TaskInfoItem({
    super.key,
    required this.info,
    this.icon,
    required this.title,
    required this.leadingIcon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(leadingIcon),
        const SizedBox(width: 8),
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        const Spacer(),
        InkWell(
          onTap: onClick,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ColorDark.white21,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              spacing: 10,
              children: [
                if (icon != null)
                  SvgPicture.asset(icon!, width: 24, height: 24),
                Text(info, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
