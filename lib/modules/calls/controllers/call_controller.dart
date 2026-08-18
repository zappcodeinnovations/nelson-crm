import 'package:get/get.dart';
import '../../../data/models/enums/call_enums.dart';

class CallOutcomeController extends GetxController {
  final step = 0.obs; // 0: choose, 1: no answer, 2: answered
  final isLoading = false.obs;
  final noAnswerReason = Rxn<NoAnswerReason>();
  final callResult = Rxn<CallResult>();
  final nextAction = Rxn<NextAction>();
}
