import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tickertape_assignment/app/constants/constants.dart';
import 'package:tickertape_assignment/app/constants/snackbar_utils.dart';
import 'package:tickertape_assignment/app/model/news_article_model.dart';
import 'package:tickertape_assignment/app/services/api_exception.dart';
import 'package:tickertape_assignment/app/services/news_cache.dart';
import 'package:tickertape_assignment/app/services/news_response.dart';

class NewsApiService {
  static const String _baseUrl = Constants.baseUrl;
  static const int _pageSize = Constants.pageSize;
  static const Duration _cacheExpiration = Duration(hours: 1);

  late final NewsCache _cache;
  bool _isInitialized = false;

  // Singleton pattern
  static final NewsApiService _instance = NewsApiService._internal();

  factory NewsApiService() {
    return _instance;
  }

  NewsApiService._internal();

  Future<void> initialize() async {
    if (!_isInitialized) {
      _cache = await NewsCache.initialize();
      _isInitialized = true;
    }
  }

  String get _apiKey => dotenv.env['NEWS_API_KEY'] ?? '';

  Future<NewsResponse> searchArticles({
    required String query,
    int page = 1,
    bool useCache = true,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      // Validate API key
      if (_apiKey.isEmpty) {
        throw ApiException('NEWS_API_KEY not found in environment variables');
      }

      // Check cache first if enabled and it's the first page
      if (useCache && page == 1) {
        final cachedArticles = await _cache.getCachedArticles(query);
        final cacheTimestamp = await _cache.getCacheTimestamp(query);

        if (cachedArticles != null && cacheTimestamp != null) {
          final cacheAge = DateTime.now().difference(cacheTimestamp);
          if (cacheAge < _cacheExpiration) {
            SnackbarUtils.showSnackbar(
              message: "Retrieving articles from cache",
              isSuccess: true,
            );
            return NewsResponse(
              articles: cachedArticles,
              currentPage: page,
              hasMore: true,
            );
          }
        }
      }

      final Uri uri = Uri.parse('$_baseUrl/everything').replace(
        queryParameters: {
          'q': query,
          'apiKey': _apiKey,
          'pageSize': _pageSize.toString(),
          'page': page.toString(),
          'language': 'en',
          'sortBy': 'publishedAt',
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<NewsArticle> articles = (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article))
            .toList();

        // Cache only first page results
        if (page == 1) {
          await _cache.cacheArticles(query, articles);
        }

        return NewsResponse(
          articles: articles,
          currentPage: page,
          hasMore: articles.length >= _pageSize,
        );
      } else {
        throw ApiException(_getErrorMessage(response.statusCode));
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }

      throw ApiException('Failed to fetch news articles: ${e.toString()}');
    }
  }

  Future<void> clearCache() async {
    if (!_isInitialized) {
      await initialize();
    }
    await _cache.clearCache();
  }

  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 401:
        return 'Invalid API key. Please check your API key and try again.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'An error occurred while fetching news articles.';
    }
  }
}
