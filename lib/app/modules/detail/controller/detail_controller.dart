import 'package:get/get.dart';
import 'package:tickertape_assignment/app/constants/snackbar_utils.dart';
import 'package:tickertape_assignment/app/model/news_article_model.dart';

class DetailController extends GetxController {
  late final NewsArticle article;
  late final String heroTag;
  late final String imageHeroTag;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeArguments();
    _loadContent();
  }

  void _initializeArguments() {
    final args = Get.arguments as Map<String, dynamic>;
    article = args['article'] as NewsArticle;
    heroTag = args['heroTag'] as String;
    imageHeroTag = args['imageHeroTag'] as String;
  }

  Future<void> _loadContent() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading
    isLoading.value = false;
  }

  void shareArticle() {
    SnackbarUtils.showSnackbar(
      message: "Sorry, currently not supported",
      isSuccess: true,
    );
  }

  void bookmarkArticle() {
    SnackbarUtils.showSnackbar(
      message: "Article has been saved to your bookmarks",
      isSuccess: true,
    );
  }
}
