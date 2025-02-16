import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickertape_assignment/app/constants/constants.dart';
import 'package:tickertape_assignment/app/model/news_article_model.dart';

class NewsCache {
  static const int _maxCacheSize = 5;

  final SharedPreferences _prefs;

  NewsCache._(this._prefs);

  static Future<NewsCache> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    return NewsCache._(prefs);
  }

  // Get cached articles for a query
  Future<List<NewsArticle>?> getCachedArticles(String query) async {
    final cacheData = _prefs.getString(Constants.cacheKey);
    if (cacheData != null) {
      final Map<String, dynamic> cache = json.decode(cacheData);
      if (cache.containsKey(query)) {
        final List<dynamic> articles = cache[query];
        return articles
            .map((article) => NewsArticle.fromJson(article))
            .toList();
      }
    }
    return null;
  }

  // Save articles to cache
  Future<void> cacheArticles(String query, List<NewsArticle> articles) async {
    final cacheData = _prefs.getString(Constants.cacheKey);
    Map<String, dynamic> cache = {};
    if (cacheData != null) {
      cache = json.decode(cacheData);
    }

    List<String> searches = await getRecentSearches();

    searches.remove(query);
    searches.insert(0, query);

    if (searches.length > _maxCacheSize) {
      final oldestQuery = searches.removeLast();
      cache.remove(oldestQuery);
    }

    cache[query] = articles.map((article) => article.toJson()).toList();

    final timestamps = _prefs.getString('${Constants.cacheKey}_timestamps');
    Map<String, String> timeMap = {};
    if (timestamps != null) {
      timeMap = Map<String, String>.from(json.decode(timestamps));
    }
    timeMap[query] = DateTime.now().toIso8601String();

    await Future.wait([
      _prefs.setString(Constants.cacheKey, json.encode(cache)),
      _prefs.setStringList(Constants.searchHistoryKey, searches),
      _prefs.setString(
        '${Constants.cacheKey}_timestamps',
        json.encode(timeMap),
      ),
    ]);
  }

  // Get list of recent searches
  Future<List<String>> getRecentSearches() async {
    return _prefs.getStringList(Constants.searchHistoryKey) ?? [];
  }

  // Clear cache
  Future<void> clearCache() async {
    await Future.wait([
      _prefs.remove(Constants.cacheKey),
      _prefs.remove(Constants.searchHistoryKey),
    ]);
  }

  Future<DateTime?> getCacheTimestamp(String query) async {
    final timestamps = _prefs.getString('${Constants.cacheKey}_timestamps');
    if (timestamps != null) {
      final Map<String, dynamic> timeMap = json.decode(timestamps);
      if (timeMap.containsKey(query)) {
        return DateTime.parse(timeMap[query]);
      }
    }
    return null;
  }
}
