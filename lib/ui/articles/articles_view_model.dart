import 'package:flutter/foundation.dart';
import '../../data/repositories/care_article_repository.dart';
import '../../domain/models/care_article.dart';

class ArticlesViewModel extends ChangeNotifier {
  final CareArticleRepository _repository;
  ArticlesViewModel(this._repository) {
    load();
  }

  bool isLoading = false;
  String? error;
  List<CareArticle> get articles => _repository.articles;

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    try {
      await _repository.loadArticles();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}