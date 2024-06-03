import 'package:contoh_ulangan_gw/login_view.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LogoutController extends GetxController {
  void logout() {
    // Logika untuk logout, misalnya menghapus token pengguna, dll.
    // Setelah logout, arahkan ke halaman login
    final LoginController loginController = Get.find();
    // loginController.clearData();
    Get.offAll(() => LoginPage());
  }
}
