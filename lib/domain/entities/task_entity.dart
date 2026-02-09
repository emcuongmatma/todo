import 'package:intl/intl.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/i18n/strings.g.dart';

class TaskEntity {
  final int? id;
  final String title;
  final String description;
  final DateTime dateTime;
  final int priority;
  final CategoryEntity category;
  final bool isCompleted;
  final String? serverId;

  TaskEntity({
    this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.priority,
    required this.category,
    this.isCompleted = false,
    this.serverId,
  });

  TaskEntity copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
    int? priority,
    CategoryEntity? category,
    bool? isCompleted,
    String? serverId
  }) {
    return TaskEntity(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      serverId: serverId ?? this.serverId
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
      0 => '${t.today} ${t.at} $time',
      1 => '${t.yesterday} ${t.at} $time',
      _ => '${DateFormat.MMMd(LocaleSettings.currentLocale.languageCode).format(this)} ${t.at} $time',
    };
  }
}
