import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'articles_view_model.dart';
import '../../data/repositories/care_article_repository.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ArticlesViewModel(ctx.read<CareArticleRepository>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Info & Tips Perawatan'), backgroundColor: Colors.green[800], foregroundColor: Colors.white),
        body: Consumer<ArticlesViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) return const Center(child: CircularProgressIndicator());
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: vm.articles.length,
              itemBuilder: (context, index) {
                final art = vm.articles[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(art.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(art.summary, style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}