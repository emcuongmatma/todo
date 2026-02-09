import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/i18n/strings.g.dart';

Future<bool?> showDeleteTaskDialog(
    BuildContext context,
    String taskName,
    ) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.delete_task,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              const Divider(
                color: ColorDark.dividerColor,
                thickness: 1,
                height: 1,
              ),
              const SizedBox(height: 20),
              Text(
                t.are_you_sure_delete_task,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "${t.task_title} $taskName",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
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
                        if (context.canPop()) context.pop(true);
                      },
                      child: Text(
                        t.delete_task,
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