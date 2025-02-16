import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tickertape_assignment/app/constants/constants.dart';
import 'package:tickertape_assignment/app/constants/news_utils.dart';
import 'package:tickertape_assignment/app/constants/snackbar_utils.dart';
import 'package:tickertape_assignment/app/model/news_article_model.dart';
import 'package:tickertape_assignment/app/routes/app_pages.dart';
import 'package:tickertape_assignment/app/services/network_service.dart';
import 'package:tickertape_assignment/app/services/news_api_service.dart';
import 'package:tickertape_assignment/app/services/news_cache.dart';

class HomeController extends GetxController {
  final NewsApiService _newsService = NewsApiService();
  final NetworkService _networkService = Get.find<NetworkService>();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  RxList<NewsArticle> articles = <NewsArticle>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxString searchQuery = ''.obs;
  RxInt page = 1.obs;
  RxBool hasMorePages = true.obs;
  final RxBool hasText = false.obs;

  late final NewsCache _cache;

  @override
  void onInit() async {
    super.onInit();
    _cache = await NewsCache.initialize();
    fetchInitialNews();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  void navigateToDetailView({
    required NewsArticle article,
    required String heroTag,
    required String imageHeroTag,
  }) {
    if (_networkService.isConnected.value) {
      Get.toNamed(
        Routes.detail,
        arguments: {
          'article': article,
          'heroTag': heroTag,
          'imageHeroTag': imageHeroTag,
        },
      );
    } else {
      SnackbarUtils.showSnackbar(
        message: "No internet! Cannot navigate to detail page",
        isSuccess: false,
      );
    }
  }

  Future<void> fetchInitialNews() async {
    try {
      isLoading.value = true;
      page.value = 1;
      hasMorePages.value = true;

      if (!_networkService.isConnected.value) {
        final recentSearches = await _cache.getRecentSearches();
        if (recentSearches.isNotEmpty) {
          final latestQuery = recentSearches.first;
          final cachedArticles = await _cache.getCachedArticles(latestQuery);

          if (cachedArticles != null) {
            articles.value = cachedArticles;
            searchQuery.value = latestQuery;
            hasMorePages.value = false;
            SnackbarUtils.showSnackbar(
              message: "Showing cached results for query: $latestQuery",
              isSuccess: true,
            );
            return;
          }
        }
      }

      // If online or no cache available, proceed with normal search
      final response = await _newsService.searchArticles(
        query: searchQuery.value.isEmpty
            ? NewsUtils.getRandomTopic()
            : searchQuery.value,
        page: page.value,
        useCache: !_networkService.isConnected.value,
      );

      articles.value = response.articles;
      hasMorePages.value = response.articles.length >= Constants.pageSize;
    } catch (e) {
      SnackbarUtils.showSnackbar(
        message: "Something went wrong! Please try again later",
        isSuccess: false,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pullToRefresh() async {
    searchQuery.value = "";
    searchController.text = "";
    hasText.value = false;
    page.value = 1;
    await fetchInitialNews();
  }

  Future<void> searchNews(String query) async {
    if (!_networkService.isConnected.value) {
      SnackbarUtils.showSnackbar(
        message: "No internet connection. Search is disabled.",
        isSuccess: false,
      );
      return;
    }

    searchQuery.value = query;
    page.value = 1;
    await fetchInitialNews();

    searchQuery.value = "";
    searchController.text = "";
    hasText.value = false;
  }

  Future<void> loadMore() async {
    if (!hasMorePages.value ||
        isLoadingMore.value ||
        !_networkService.isConnected.value) return;

    try {
      isLoadingMore.value = true;
      page.value++;

      final response = await _newsService.searchArticles(
        query: searchQuery.value.isEmpty
            ? NewsUtils.getRandomTopic()
            : searchQuery.value,
        page: page.value,
      );

      articles.addAll(response.articles);
      hasMorePages.value = response.articles.length >= Constants.pageSize;
    } catch (e) {
      SnackbarUtils.showSnackbar(
        message: "Failed to load more news",
        isSuccess: false,
      );
      page.value--;
    } finally {
      isLoadingMore.value = false;
    }
  }
}
