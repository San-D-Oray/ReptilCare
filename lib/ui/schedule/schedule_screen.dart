import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/reptile_schedule_repository.dart';
import 'schedule_form_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String selectedCategory = 'Ular';

  @override
  Widget build(BuildContext context) {
    final scheduleRepo = context.watch<ReptileScheduleRepository>();
    final schedules = scheduleRepo.schedules
        .where((s) => s.category.toLowerCase() == selectedCategory.toLowerCase())
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Jadwal per Kategori', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Segmented Button Kategori Modern
            Center(
              child: SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Ular', label: Text('Ular'), icon: Icon(Icons.pets, size: 16)),
                  ButtonSegment(value: 'Cicak/Gecko', label: Text('Gecko'), icon: Icon(Icons.bug_report, size: 16)),
                  ButtonSegment(value: 'Kura-kura', label: Text('Kura'), icon: Icon(Icons.shield, size: 16)),
                ],
                selected: {selectedCategory},
                onSelectionChanged: (val) => setState(() => selectedCategory = val.first),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: schedules.isEmpty
                  ? Center(
                      child: Text('Tidak ada jadwal untuk kategori $selectedCategory',
                          style: TextStyle(color: Colors.grey[600])))
                  : ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        final item = schedules[index];
                        return Card(
                          elevation: 1,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text('${item.day}, ${item.time}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(item.description, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.green),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ScheduleFormScreen(scheduleToEdit: item)),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Jadwal'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ScheduleFormScreen()),
          );
        },
      ),
    );
  }
}