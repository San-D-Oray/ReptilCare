import '../../domain/models/reptile_schedule.dart';
import '../../domain/models/care_task.dart';
import '../../domain/models/care_article.dart';

class ReptileService {
  Future<List<ReptileSchedule>> fetchSchedules() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      const ReptileSchedule(id: '1', title: 'Beri Makan Tikus Putih', category: 'Ular', day: 'Senin', time: '19:00 WIB', description: 'Pastikan ukuran tikus sesuai dengan girt tubuh ular.'),
      const ReptileSchedule(id: '2', title: 'Cek Kelembapan Kandang', category: 'Ular', day: 'Senin', time: '08:00 WIB', description: 'Jaga kelembapan kandang Ball Python di kisaran 60-70%.'),
      const ReptileSchedule(id: '3', title: 'Beri Makan Jangkrik & Kalsium', category: 'Cicak/Gecko', day: 'Selasa', time: '18:30 WIB', description: 'Taburi jangkrik dengan bubuk kalsium D3.'),
      const ReptileSchedule(id: '4', title: 'Ganti Air Minum & Rendam', category: 'Kura-kura', day: 'Rabu', time: '09:00 WIB', description: 'Rendam kura-kura dalam air hangat selama 15 menit.'),
      const ReptileSchedule(id: '5', title: 'Pembersihan Total Enclosure', category: 'Ular', day: 'Kamis', time: '10:00 WIB', description: 'Ganti alas substrate dan cuci disinfektan kandang.'),
    ];
  }

  Future<List<CareTask>> fetchTasks() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      const CareTask(id: 't1', taskName: 'Memberi makan frozen mouse', reptileName: 'Cleo (Corn Snake)', isCompleted: false, deadline: 'Hari Ini'),
      const CareTask(id: 't2', taskName: 'Semprot kandang (Misting)', reptileName: 'Draco (Ball Python)', isCompleted: false, deadline: 'Hari Ini'),
      const CareTask(id: 't3', taskName: 'Membersihkan kotoran & ganti alas', reptileName: 'Gekko (Leopard Gecko)', isCompleted: true, deadline: 'Kemarin'),
      const CareTask(id: 't4', taskName: 'Menjemur kura-kura sinar UV', reptileName: 'Shellby (Sulcata)', isCompleted: false, deadline: 'Besok'),
    ];
  }

  Future<List<CareArticle>> fetchArticles() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      const CareArticle(id: 'a1', title: 'Mengatasi Ular Gagal Shedding', category: 'Kesehatan', summary: 'Cara aman membantu ular meluruhkan kulit.', content: 'Rendam ular dalam air hangat suam-kuku selama 20-30 menit, lalu usap perlahan.'),
      const CareArticle(id: 'a2', title: 'Pentingnya Lampu UVB', category: 'Pencahayaan', summary: 'Menghindari MBD pada reptil gurun.', content: 'Reptil diurnal membutuhkan sinar UVB 10.0 untuk menyintesis kalsium.'),
      const CareArticle(id: 'a3', title: 'Tanda Ular Mengalami Stress', category: 'Perilaku', summary: 'Kenali gestur tubuh saat ular terancam.', content: 'Sering melakukan strike tiba-tiba atau menolak makan.'),
    ];
  }
}