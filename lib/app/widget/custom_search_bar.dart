import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tickertape_assignment/app/modules/home/controller/home_controller.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSubmitted;
  final TextEditingController controller;
  final FocusNode focusNode;

  const CustomSearchBar({
    super.key,
    required this.onSubmitted,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      // focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Search news...',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.0,
                      ),
                      onChanged: (value) {
                        homeController.hasText.value = value.isNotEmpty;
                      },
                      onSubmitted: onSubmitted,
                    ),
                  ),
                  Obx(
                    () => homeController.hasText.value
                        ? GestureDetector(
                            onTap: () {
                              controller.clear();
                              homeController.hasText.value = false;
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          )
                        : const SizedBox(width: 12),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => homeController.hasText.value
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        onSubmitted(controller.text);
                        // focusNode.unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
