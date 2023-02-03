import 'package:calculator_app_getx/database_services/history_database.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var visiblityBool = false.obs;
  var history = [].obs;
  HistoryHelper historyHelper = HistoryHelper();

  changeVisiblity() {
    if (visiblityBool.value == false) {
      visiblityBool.value = true;
    } else {
      visiblityBool.value = false;
    }
  }

  getHistory() async {
    var resp = await historyHelper.getCalculations();
    for (var element in resp) {
      history.add(element);
    }
  }

  clearHistory() {
    historyHelper.deleteAllCalculations();
    history.clear();
  }
}
