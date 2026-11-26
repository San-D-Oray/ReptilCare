import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/care_task_repository.dart';
import '../home/task_form_screen.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskRepo = context.watch<CareTaskRepository>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Checklist Tugas Perawatan', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '⏳ Tugas Belum Selesai',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          const SizedBox(height: 8),
          taskRepo.pendingTasks.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: const Text('Semua tugas perawatan reptil hari ini sudah selesai! 🎉', style: TextStyle(color: Colors.grey)),
                )
              : Column(
                  children: taskRepo.pendingTasks.map((task) {
                    return Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text(task.taskName, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('Hewan: ${task.reptileName} • ${task.deadline}', style: const TextStyle(fontSize: 12)),
                        value: task.isCompleted,
                        activeColor: Colors.green[800],
                        onChanged: (_) => taskRepo.toggleTask(task.id),
                      ),
                    );
                  }).toList(),
                ),
          const SizedBox(height: 24),
          const Text(
            '✅ Tugas Selesai',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 8),
          taskRepo.completedTasks.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: const Text('Belum ada tugas yang diselesaikan.', style: TextStyle(color: Colors.grey)),
                )
              : Column(
                  children: taskRepo.completedTasks.map((task) {
                    return Card(
                      color: Colors.grey[200],
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: CheckboxListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text(
                          task.taskName,
                          style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
                        ),
                        subtitle: Text('Hewan: ${task.reptileName}', style: const TextStyle(fontSize: 12)),
                        value: task.isCompleted,
                        activeColor: Colors.green[800],
                        onChanged: (_) => taskRepo.toggleTask(task.id),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Tugas'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TaskFormScreen()),
          );
        },
      ),
    );
  }
}