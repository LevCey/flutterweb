import 'package:flutter_riverpod/flutter_riverpod.dart';

//---------EASY LEVEL PROVIDER----------------
final riverpodEasyLevel = StateProvider<int>((ref) {
  return 0; // Initial value for the easy level
});

//---------1. StateNotifierProvider örneği ----------------
class HardLevelNotifier extends StateNotifier<int> {
  HardLevelNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

final hardLevelProvider = StateNotifierProvider<HardLevelNotifier, int>((ref) {
  return HardLevelNotifier();
});

//----------- 2. StateNotifierProvider örneği -------------
class TestNotifier extends StateNotifier<List<String>> {
  TestNotifier() : super(['Initial Item']);

  // Durumu güncelleyecek metotlarınızı buraya ekleyin, örneğin:
  void addItem(String item) {
    state = [...state, item]; // Yeni öğeyi listeye ekler
  }

  void removeItem(String item) {
    state = state
        .where((i) => i != item)
        .toList(); // Belirtilen öğeyi listeden kaldırır
  }

  void clearItems() {
    state = []; // Tüm öğeleri temizler
  }

  void updateItem(int index, String newItem) {
    if (index >= 0 && index < state.length) {
      final updatedList = List<String>.from(
        state,
      ); // riverpod immutable olduğu için yeni bir liste oluşturuyoruz
      updatedList[index] = newItem; // Belirtilen indeksteki öğeyi günceller
      state = updatedList;
    }
  }
}

final testProvider = StateNotifierProvider<TestNotifier, List<String>>((ref) {
  return TestNotifier();
});

/*// Example usage of the riverpodEasyLevel provider
ref.read(riverpodEasyLevel); // This will read the current value of the easy level
ref.read(riverpodEasyLevel.notifier).state = 1; // Example of changing the state
ref.watch(riverpodEasyLevel); // This will listen to changes in the easy level
ref.listen(riverpodEasyLevel, (previous, next) {
  // This will be called whenever the easy level changes
  print('Easy level changed from $previous to $next');
});
*/

/* 
// TestRCW is a ConsumerWidget, which is a widget that can read providers
class TestRCW extends ConsumerWidget {
  const TestRCW({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder(); // Burayı kendi widget'ınızla değiştirin
  }
}
*/

/*
// TestRCSFW is a ConsumerStatefulWidget, which is a widget that can read providers and has mutable state
class TestRCSFW extends ConsumerStatefulWidget {
  const TestRCSFW({super.key});

  @override
  ConsumerState<TestRCW> createState() => _TestState();
}

class _TestState extends ConsumerState<TestRCW> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(); // Burayı kendi widget'ınızla değiştirin
  }
}
*/
