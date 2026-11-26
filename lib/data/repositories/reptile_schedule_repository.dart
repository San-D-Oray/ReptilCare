import 'package:flutter/foundation.dart';
import '../../domain/models/reptile_schedule.dart';
import '../services/reptile_service.dart';

class ReptileScheduleRepository extends ChangeNotifier {
  final ReptileService _service;
  ReptileScheduleRepository(this._service);

  List<ReptileSchedule> _schedules = [];
  bool isLoading = false;
  String? error;

  List<ReptileSchedule> get schedules => _schedules;

  Future<void> loadSchedules() async {
    isLoading = true;
    notifyListeners();
    try {
      _schedules = await _service.fetchSchedules();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 1. Tambah Jadwal Baru & Memberitahu Listener (UI Beranda & Jadwal)
  void addSchedule(ReptileSchedule schedule) {
    _schedules.add(schedule);
    notifyListeners(); // <-- Ini kunci agar Home Screen & Jadwal ikut ter-update
  }

  // 2. Edit Jadwal & Memberitahu Listener
  void updateSchedule(ReptileSchedule updatedSchedule) {
    final index = _schedules.indexWhere((s) => s.id == updatedSchedule.id);
    if (index != -1) {
      _schedules[index] = updatedSchedule;
      notifyListeners(); // <-- Memperbarui UI secara real-time
    }
  }
}