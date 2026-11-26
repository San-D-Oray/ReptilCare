import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/dependencies.dart';
import 'app.dart';
import 'data/repositories/reptile_schedule_repository.dart';
import 'data/repositories/care_task_repository.dart';
import 'data/repositories/care_article_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: appProviders,
      child: const InitializerWidget(),
    ),
  );
}

class InitializerWidget extends StatelessWidget {
  const InitializerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReptileScheduleRepository>().loadSchedules();
    context.read<CareTaskRepository>().loadTasks();
    context.read<CareArticleRepository>().loadArticles();

    return const ReptileCareApp();
  }
}