// lib/ui/checklist/task_form_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/care_task_repository.dart';
import '../../domain/models/care_task.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenTaskState();
}

class _TaskFormScreenTaskState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _taskName = '';
  String _reptileName = '';
  String _deadline = 'Hari Ini';

  final List<String> deadlines = ['Hari Ini', 'Besok', 'Minggu Ini'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas Perawatan'),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama Tugas (Contoh: Beri Vitamin)'),
                validator: (val) => val == null || val.isEmpty ? 'Nama tugas tidak boleh kosong' : null,
                onSaved: (val) => _taskName = val!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama Hewan (Contoh: Ular Corn Snake)'),
                validator: (val) => val == null || val.isEmpty ? 'Nama hewan tidak boleh kosong' : null,
                onSaved: (val) => _reptileName = val!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _deadline,
                decoration: const InputDecoration(labelText: 'Tenggat Waktu (Deadline)'),
                items: deadlines.map((d) {
                  return DropdownMenuItem(value: d, child: Text(d));
                }).toList(),
                onChanged: (val) => setState(() => _deadline = val!),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    
                    final newTask = CareTask(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      taskName: _taskName,
                      reptileName: _reptileName,
                      isCompleted: false,
                      deadline: _deadline,
                    );

                    // Masukkan ke task repository
                    context.read<CareTaskRepository>().addTask(newTask);

                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  }
                },
                child: const Text('Simpan Tugas Baru', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}