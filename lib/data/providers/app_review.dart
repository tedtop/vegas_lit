import 'package:in_app_review/in_app_review.dart';

class AppReviewClient {
  AppReviewClient({InAppReview inAppReview})
      : _inAppReview = inAppReview ?? InAppReview.instance;

  final InAppReview _inAppReview;

  Future<void> openAppReview() async {
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
    }
  }
}
