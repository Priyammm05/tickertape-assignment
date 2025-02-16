import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsShimmerList extends StatelessWidget {
  final bool isFeatured;

  const NewsShimmerList({
    super.key,
    this.isFeatured = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isFeatured ? 1 : 2,
      itemBuilder: (context, index) {
        if (index == 0 && isFeatured) {
          return _buildFeaturedShimmer();
        }
        return _buildListItemShimmer();
      },
    );
  }

  Widget _buildFeaturedShimmer() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 24,
                            width: double.infinity,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 16,
                            width: 150,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildListItemShimmer();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListItemShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              width: 60,
              height: 60,
              color: Colors.white,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                Container(
                  height: 16,
                  width: 200,
                  color: Colors.white,
                ),
              ],
            ),
            subtitle: Container(
              height: 14,
              width: 100,
              margin: const EdgeInsets.only(top: 8),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
