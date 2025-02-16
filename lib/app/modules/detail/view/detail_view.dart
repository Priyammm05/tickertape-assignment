import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tickertape_assignment/app/constants/date_utils.dart';
import 'package:tickertape_assignment/app/modules/detail/controller/detail_controller.dart';
import 'package:tickertape_assignment/app/widget/custom_network_image.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: controller.heroTag,
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitle(),
                          const SizedBox(height: 16),
                          _buildMetadata(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: CircleAvatar(
          backgroundColor: Colors.black,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: controller.shareArticle,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              icon: const Icon(
                Icons.bookmark_border,
                color: Colors.white,
              ),
              onPressed: controller.bookmarkArticle,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: controller.imageHeroTag,
          child: CustomNetworkImage(
            imageUrl: controller.article.urlToImage ?? '',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitHeight,
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      controller.article.title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.4,
      ),
    );
  }

  Widget _buildMetadata() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text(
            controller.article.source.name[0].toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.article.source.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (controller.article.author != null)
                Text(
                  'By ${controller.article.author}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              Text(
                CustomDateUtils.formatDateToCustomString(
                  controller.article.publishedAt,
                ),
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Obx(() {
      if (controller.isLoading.value) {
        return _buildShimmerContent();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.article.description,
            style: const TextStyle(
              fontSize: 18,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            controller.article.content ?? '',
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildShimmerContent() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          10,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              height: 16,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
