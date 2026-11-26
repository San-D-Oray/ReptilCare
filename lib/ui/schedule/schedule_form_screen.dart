import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/reptile_schedule_repository.dart';
import '../../domain/models/reptile_schedule.dart';

class ScheduleFormScreen extends StatefulWidget {
  final ReptileSchedule? scheduleToEdit; // Jika null berarti mode Tambah, jika ada berarti mode Edit

  const ScheduleFormScreen({super.key, this.scheduleToEdit});

  @override
  State<ScheduleFormScreen> createState() => _ScheduleFormScreenState();
}

class _ScheduleFormScreenState extends State<ScheduleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _category;
  late String _day;
  late String _time;
  late String _description;

  final List<String> categories = ['Ular', 'Cicak/Gecko', 'Kura-kura'];
  final List<String> days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];

  @override
  void initState() {
    super.initState();
    if (widget.scheduleToEdit != null) {
      _title = widget.scheduleToEdit!.title;
      _category = widget.scheduleToEdit!.category;
      _day = widget.scheduleToEdit!.day;
      _time = widget.scheduleToEdit!.time;
      _description = widget.scheduleToEdit!.description;
    } else {
      _title = '';
      _category = 'Ular';
      _day = 'Senin';
      _time = '08:00 WIB';
      _description = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.scheduleToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Jadwal Perawatan' : 'Tambah Jadwal Baru'),
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
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Judul Perawatan (Contoh: Beri Makan)'),
                validator: (val) => val == null || val.isEmpty ? 'Judul tidak boleh kosong' : null,
                onSaved: (val) => _title = val!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(labelText: 'Kategori Hewan'),
                items: categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) => setState(() => _category = val!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _day,
                decoration: const InputDecoration(labelText: 'Hari Perawatan'),
                items: days.map((d) {
                  return DropdownMenuItem(value: d, child: Text(d));
                }).toList(),
                onChanged: (val) => setState(() => _day = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _time,
                decoration: const InputDecoration(labelText: 'Waktu (Contoh: 19:00 WIB)'),
                validator: (val) => val == null || val.isEmpty ? 'Waktu tidak boleh kosong' : null,
                onSaved: (val) => _time = val!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Deskripsi / Catatan Tambahan'),
                maxLines: 3,
                onSaved: (val) => _description = val ?? '',
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
                    final repo = context.read<ReptileScheduleRepository>();

                    if (isEditing) {
                      // Update Jadwal yang sudah ada
                      final updated = widget.scheduleToEdit!.copyWith(
                        title: _title,
                        category: _category,
                        day: _day,
                        time: _time,
                        description: _description,
                      );
                      repo.updateSchedule(updated);
                    } else {
                      // Tambah Jadwal baru dengan ID unik berbasis waktu
                      final newSchedule = ReptileSchedule(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: _title,
                        category: _category,
                        day: _day,
                        time: _time,
                        description: _description,
                      );
                      repo.addSchedule(newSchedule);
                    }

                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  }
                },
                child: Text(isEditing ? 'Simpan Perubahan' : 'Tambah Jadwal', style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}