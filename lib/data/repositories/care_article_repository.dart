import '../../domain/models/care_article.dart';
import '../services/reptile_service.dart';

class CareArticleRepository {
  final ReptileService _service;
  CareArticleRepository(this._service);

  List<CareArticle> _articles = [];
  bool isLoading = false;
  String? error;

  List<CareArticle> get articles => _articles;

  Future<void> loadArticles() async {
    isLoading = true;
    try {
      _articles = await _service.fetchArticles();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }
}