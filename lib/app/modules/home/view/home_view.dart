import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:tickertape_assignment/app/constants/constants.dart';
import 'package:tickertape_assignment/app/constants/date_utils.dart';
import 'package:tickertape_assignment/app/model/news_article_model.dart';
import 'package:tickertape_assignment/app/modules/home/controller/home_controller.dart';
import 'package:tickertape_assignment/app/routes/app_pages.dart';
import 'package:tickertape_assignment/app/widget/custom_network_image.dart';
import 'package:tickertape_assignment/app/widget/custom_search_bar.dart';
import 'package:tickertape_assignment/app/widget/news_shimmer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.pullToRefresh,
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchBar(),
              Expanded(
                child: _buildNewsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            height: 40,
            width: 120,
            image: Svg(Constants.logo),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.search);
        },
        child: AbsorbPointer(
          child: CustomSearchBar(
            controller: controller.searchController,
            focusNode: controller.searchFocusNode,
            onSubmitted: (value) {},
          ),
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return Obx(
      () {
        if (controller.isLoading.value || controller.articles.isEmpty) {
          return const NewsShimmerList(isFeatured: true);
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 200) {
              controller.loadMore();
            }
            return false;
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: controller.articles.length +
                (controller.isLoadingMore.value && controller.hasMorePages.value
                    ? 1
                    : 0),
            itemBuilder: (context, index) {
              if (index == controller.articles.length) {
                return const NewsShimmerList(isFeatured: false);
              }

              final article = controller.articles[index];
              if (index == 0) {
                return _buildFeaturedArticle(article);
              }
              return _buildArticleItem(article);
            },
          ),
        );
      },
    );
  }

  Widget _buildArticleItem(NewsArticle article) {
    final String heroTag = article.url;
    final String imageHeroTag = "${article.url}_image";
    return GestureDetector(
      onTap: () {
        controller.navigateToDetailView(
          article: article,
          heroTag: heroTag,
          imageHeroTag: imageHeroTag,
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: Hero(
            tag: imageHeroTag,
            child: CustomNetworkImage(
              imageUrl: article.urlToImage,
              width: 60,
              height: 60,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          title: Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  article.source.name,
                  style: TextStyle(color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                flex: 1,
                child: Text(
                  CustomDateUtils.formatDateToCustomString(
                    article.publishedAt,
                  ),
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedArticle(NewsArticle article) {
    final String heroTag = article.url;
    final String imageHeroTag = "${article.url}_image";

    return GestureDetector(
      onTap: () {
        controller.navigateToDetailView(
          article: article,
          heroTag: heroTag,
          imageHeroTag: imageHeroTag,
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: imageHeroTag,
              child: CustomNetworkImage(
                imageUrl: article.urlToImage,
                width: double.infinity,
                height: 200,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          article.source.name,
                          style: TextStyle(color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: Text(
                          CustomDateUtils.formatDateToCustomString(
                            article.publishedAt,
                          ),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
