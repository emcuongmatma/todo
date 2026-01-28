import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/core/constants/initial_data.dart';
import 'package:todo/data/models/category_model.dart';
import 'package:todo/data/models/task_model.dart';

class IsarService {
  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [TaskModelSchema,CategoryModelSchema],
      directory: dir.path,
    );
    await _seedInitialData(isar);
    return isar;
  }

  static Future<void> _seedInitialData(Isar isar) async {
    final categoryCount = await isar.categoryModels.count();

    if (categoryCount == 0) {
      await isar.writeTxn(() async {
        await isar.categoryModels.putAll(InitialData.categories.map((item)=> CategoryModel.fromEntity(item)).toList());
      });
    }
  }
}