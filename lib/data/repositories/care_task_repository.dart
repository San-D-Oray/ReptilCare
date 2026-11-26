// lib/data/repositories/care_task_repository.dart
import 'package:flutter/foundation.dart';
import '../../domain/models/care_task.dart';
import '../services/reptile_service.dart';

class CareTaskRepository extends ChangeNotifier {
  final ReptileService _service;
  CareTaskRepository(this._service);

  List<CareTask> _tasks = [];
  bool isLoading = false;
  String? error;

  List<CareTask> get tasks => _tasks;
  List<CareTask> get pendingTasks => _tasks.where((t) => !t.isCompleted).toList();
  List<CareTask> get completedTasks => _tasks.where((t) => t.isCompleted).toList();

  Future<void> loadTasks() async {
    isLoading = true;
    notifyListeners();
    try {
      _tasks = await _service.fetchTasks();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(isCompleted: !_tasks[index].isCompleted);
      notifyListeners();
    }
  }

  // --- FITUR BARU: Tambah Tugas Aksi Baru ---
  void addTask(CareTask newTask) {
    _tasks.add(newTask);
    notifyListeners(); // Memperbarui Beranda & Checklist secara real-time
  }
}