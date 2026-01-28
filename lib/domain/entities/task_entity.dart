import 'package:intl/intl.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/domain/entities/category_entity.dart';

class TaskEntity {
  final int? id;
  final String title;
  final String description;
  final DateTime dateTime;
  final int priority;
  final CategoryEntity category;
  final bool isCompleted;

  TaskEntity({
    this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.priority,
    required this.category,
    this.isCompleted = false,
  });

  TaskEntity copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
    int? priority,
    CategoryEntity? category,
    bool? isCompleted,
  }) {
    return TaskEntity(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

extension DateTimeEx on DateTime {
  String toCustomString() {
    final now = DateTime.now();
    final time = DateFormat.Hm().format(this);
    final diff = DateTime(
      now.year,
      now.month,
      now.day,
    ).difference(DateTime(year, month, day)).inDays;

    return switch (diff) {
      0 => '${AppConstants.TODAY} ${AppConstants.AT} $time',
      1 => '${AppConstants.YESTERDAY} ${AppConstants.AT} $time',
      _ => '${DateFormat.MMMd().format(this)} ${AppConstants.AT} $time',
    };
  }
}
