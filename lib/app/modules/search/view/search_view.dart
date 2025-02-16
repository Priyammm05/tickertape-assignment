import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:tickertape_assignment/app/constants/constants.dart';
import 'package:tickertape_assignment/app/modules/home/controller/home_controller.dart';
import 'package:tickertape_assignment/app/modules/search/controller/search_controller.dart';
import 'package:tickertape_assignment/app/widget/custom_search_bar.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final CustomSearchController searchController =
        Get.put(CustomSearchController());

    return Scaffold(
      appBar: AppBar(
        title: const Image(
          height: 40,
          width: 120,
          image: Svg(Constants.logo),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomSearchBar(
            onSubmitted: (value) {
              Get.back();
              homeController.searchNews(value).then((value) {
                searchController.addSearchQuery(
                  homeController.searchController.text,
                );
              });
              homeController.searchFocusNode.unfocus();
            },
            controller: homeController.searchController,
            focusNode: homeController.searchFocusNode,
          ),
          const SizedBox(height: 20),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: searchController.recentSearches.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      homeController.searchNews(
                        searchController.recentSearches[index],
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          searchController.recentSearches[index],
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 15,
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
