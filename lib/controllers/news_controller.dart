import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/signup_login_controller.dart';
import 'package:news_app/pages/news_page.dart';
import 'package:news_app/services/push_notification_service.dart';
import 'package:news_app/shared/my_toast.dart';
import 'package:news_app/shared/myloading.dart';

class NewsController extends GetxController {
  PushNotificationService pushNotificationService = PushNotificationService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignupLoginController _signupLoginController =
      Get.put(SignupLoginController());

  Future<void> saveNewsToCloudStorage(title, body) async {
    myLoading();
    try {
      await _firestore.collection('news').add({
        'title': title,
        'body': body,
        'author': _signupLoginController.name.value,
        'userid': _signupLoginController.id.value,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((value) {
        Get.back();
        showSuccessToast("News added successfully");
        Get.off(const NewsPage());
        pushNotificationService.sendNotificationToUsers(title);
      });
    } catch (e) {
      Get.back();
      showErrorToast(e.toString());
    }
  }

  Future<void> updateNews(String documentId, String title, String body) async {
    myLoading();
    try {
      await _firestore.collection('news').doc(documentId).update({
        'title': title,
        'body': body,
      });
      Get.back();
      showSuccessToast("Updated successfully");
      Get.off(const NewsPage());
    } catch (e) {
      Get.back();
      showErrorToast(e.toString());
    }
  }

  Future<void> deleteNews(String documentId) async {
    myLoading();
    try {
      await _firestore.collection('news').doc(documentId).delete();
      Get.back();
      showSuccessToast("Deleted successfully");
    } catch (e) {
      Get.back();
      showErrorToast(e.toString());
    }
  }
}
