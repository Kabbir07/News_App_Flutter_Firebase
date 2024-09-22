import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:news_app/pages/news_page.dart';
import 'package:news_app/shared/my_toast.dart';
import 'package:news_app/shared/myloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupLoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var id = ''.obs;
  var name = ''.obs;

  Future<void> signInWithEmailAndPassword(email, password) async {
    myLoading();
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.back();

      if (userCredential.user != null) {
        showSuccessToast("Successfully logged in with email: $email");
        Get.off(const NewsPage());
        saveData(userCredential.user!.uid,
                userCredential.user!.displayName ?? '')
            .then((value) {
          loadData();
        });
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      showErrorToast(e.message.toString());
    }
  }

  Future<void> signUpWithEmailAndPassword(email, password) async {
    myLoading();
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.back();
      if (userCredential.user != null) {
        showSuccessToast("Successfully signed up with email: $email");
        Get.off(const NewsPage());
        saveData(userCredential.user!.uid,
                userCredential.user!.displayName ?? '')
            .then((value) {
          loadData();
        });
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      showErrorToast(e.message.toString());
    }
  }

  Future<void> saveData(id, name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userid', id.toString());
    await prefs.setString('name', name.toString());
  }

  Future<String> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    name.value = prefs.getString('name') ?? '';
    id.value = prefs.getString('userid') ?? '';
    print(id.value);
    return userid == null ? '' : userid.toString();
  }

  Future<void> removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
