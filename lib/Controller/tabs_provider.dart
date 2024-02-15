import 'package:flutter_riverpod/flutter_riverpod.dart';
class TabsNotifier extends StateNotifier<int> {
  TabsNotifier() : super(0);

  void changeIndex(int index) {
    state = index;
  }

  void resetIndex() {
    state = 0;
  }


}
final tabsProvider = StateNotifierProvider<TabsNotifier, int>((ref) {
  return TabsNotifier();
});