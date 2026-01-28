class TaskRemoteDataSource {
  // final FirebaseFirestore firestore;
  // TaskRemoteDataSource(this.firestore);
  //
  // Future<void> syncTask(TaskModel task) async {
  //   // Dùng serverId hoặc id làm document path
  //   await firestore.collection('tasks').doc(task.id.toString()).set(task.toFirestore());
  // }
  //
  // Future<List<TaskModel>> fetchRemoteTasks() async {
  //   final snapshot = await firestore.collection('tasks').get();
  //   return snapshot.docs.map((doc) => TaskModel.fromFirestore(doc.data())).toList();
  // }
}