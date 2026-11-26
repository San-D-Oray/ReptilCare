import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../data/services/reptile_service.dart';
import '../data/repositories/reptile_schedule_repository.dart';
import '../data/repositories/care_task_repository.dart';
import '../data/repositories/care_article_repository.dart';

List<SingleChildWidget> appProviders = [
  // 1. Service
  Provider<ReptileService>(
    create: (_) => ReptileService(),
  ),

  // 2. Repositories (Menggunakan ChangeNotifierProvider untuk state management real-time)
  ChangeNotifierProvider<ReptileScheduleRepository>(
    create: (context) => ReptileScheduleRepository(context.read<ReptileService>()),
  ),
  ChangeNotifierProvider<CareTaskRepository>(
    create: (context) => CareTaskRepository(context.read<ReptileService>()),
  ),
  Provider<CareArticleRepository>(
    create: (context) => CareArticleRepository(context.read<ReptileService>()),
  ),
];