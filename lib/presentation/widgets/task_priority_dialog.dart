import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/i18n/strings.g.dart';

enum TaskPriorityDialogMode { create, edit }

Future<int?> showTaskPriorityDialog({
  required BuildContext context,
  int? initialPriority,
  TaskPriorityDialogMode mode = TaskPriorityDialogMode.create,
}) async {
  return showDialog<int>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      int selectedItem = initialPriority ?? 1;
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.task_priority,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              const Divider(
                color: ColorDark.dividerColor,
                thickness: 1,
                height: 1,
              ),
              const SizedBox(height: 22),
              PriorityGridWidget(
                selectedPriority: selectedItem,
                onSelected: (priority) {
                  selectedItem = priority + 1;
                },
              ),
              const SizedBox(height: 18),
              Row(
                spacing: 5,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (context.canPop()) context.pop();
                      },
                      child: Text(
                        t.cancel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorDark.primary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        if (context.canPop()) context.pop(selectedItem);
                      },
                      child: Text(
                        mode == TaskPriorityDialogMode.create
                            ? t.save
                            : t.edit,
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class PriorityGridWidget extends StatefulWidget {
  final int? selectedPriority;
  final Function(int) onSelected;

  const PriorityGridWidget({
    super.key,
    this.selectedPriority,
    required this.onSelected,
  });

  @override
  State<PriorityGridWidget> createState() => _PriorityGridWidgetState();
}

class _PriorityGridWidgetState extends State<PriorityGridWidget> {
  int? priority;

  @override
  void initState() {
    priority = (widget.selectedPriority ?? 1) - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: List.generate(10, (index) {
        return InkWell(
          onTap: () {
            setState(() {
              priority = index;
              widget.onSelected(index);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: index == priority
                  ? ColorDark.primary
                  : ColorDark.cellItemInMonthBackground,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Column(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.iconsIcFlag),
                Text(
                  "${index + 1}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
