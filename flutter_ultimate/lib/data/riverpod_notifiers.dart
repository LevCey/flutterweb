import 'package:flutter_riverpod/flutter_riverpod.dart';

//--------------------IsDarkMode--------------
final isDarkModeProvider = StateProvider<bool>((ref) {
  return false;
});

//--------------------SelectedPage--------------
class SelectedPageNotifierR extends StateNotifier<int> {
  SelectedPageNotifierR() : super(0);
  // Initial page is set to 0 (HomePage)
  void setPage(int page) {
    state = page;
  }
}

final selectedPageProvider = StateNotifierProvider<SelectedPageNotifierR, int>((
  ref,
) {
  return SelectedPageNotifierR();
});
