import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/reptile_schedule_repository.dart';
import '../../data/repositories/care_task_repository.dart';
import '../schedule/schedule_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleRepo = context.watch<ReptileScheduleRepository>();
    final taskRepo = context.watch<CareTaskRepository>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('ReptileCare Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        color: Colors.green[800],
        onRefresh: () async {
          await scheduleRepo.loadSchedules();
          await taskRepo.loadTasks();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Banner Selamat Datang yang Estetik
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[800]!, Colors.green[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.pets, size: 48, color: Colors.white70),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Halo, Keeper! 🐍',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Pantau kesehatan & jadwal reptil kesayangan dengan mudah.',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Tugas Perawatan Mendesak
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '🚨 Tugas Perawatan Mendesak',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                Text(
                  '${taskRepo.pendingTasks.length} Pending',
                  style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
            taskRepo.pendingTasks.isEmpty
                ? Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text('Hebat! Semua tugas mendesak sudah selesai 🎉', style: TextStyle(color: Colors.grey)),
                      ),
                    ),
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

            // Section: Jadwal Rutin Terdekat
            const Text(
              '📅 Jadwal Rutin Terdekat',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            scheduleRepo.schedules.isEmpty
                ? const Center(child: Text('Belum ada jadwal tersimpan.'))
                : Column(
                    children: scheduleRepo.schedules.take(3).map((sch) {
                      return Card(
                        elevation: 1,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.event_note, color: Colors.green[800]),
                          ),
                          title: Text(sch.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text('${sch.category} • ${sch.day} (${sch.time})', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit_outlined, color: Colors.green, size: 20),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => ScheduleFormScreen(scheduleToEdit: sch)),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}