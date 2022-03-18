import 'package:get/get.dart';
import 'package:sendeaze/utils/sharedPrefs.dart';

class LocaleController extends GetxController {
  Rx<bool> _isEnglish = false.obs;

  bool get isEnglish => _isEnglish.value;
  changeLanguage(bool isEng) async {
    _isEnglish.value = isEng;
    await SharedPrefs.writeValue(PrefConstants.IS_ENGLISH, isEng);
    update();
  }
}
