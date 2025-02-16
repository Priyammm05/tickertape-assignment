import 'package:get/get.dart';
import 'package:tickertape_assignment/app/services/news_cache.dart';

class CustomSearchController extends GetxController {
  final RxList<String> recentSearches = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    final cache = await NewsCache.initialize();
    recentSearches.value = await cache.getRecentSearches();
  }

  void addSearchQuery(String query) async {
    if (query.isNotEmpty) {
      final cache = await NewsCache.initialize();
      await cache.cacheArticles(query, []);
      _loadRecentSearches();
    }
  }

  void clearRecentSearches() async {
    final cache = await NewsCache.initialize();
    await cache.clearCache();
    recentSearches.clear();
  }
}
