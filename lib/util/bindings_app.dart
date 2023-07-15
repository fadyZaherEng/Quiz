import 'package:get/get.dart';
import 'package:quizes/layout/home/getx/quiz_controller.dart';

class BilndingsApp implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController());
  }
}
