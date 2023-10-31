import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsEventDetailIsSavedNotifier extends StateNotifier<bool> {
  IsEventDetailIsSavedNotifier() : super(false);

  void resetBoolState(bool value) {
    state = value; // Reset to initial value
  }
}

class IsOpendedNotifier extends StateNotifier<bool> {
  IsOpendedNotifier() : super(false);

  void resetState(bool value) {
    state = value; // Reset to initial value
  }
}

class PriceNumberNotifier extends StateNotifier<int> {
  PriceNumberNotifier() : super(1);

  void decrementNumber() {
    state--;
  }

  void incrementNumber() {
    state++;
  }

  void updateIndex(int index) {}
}

class SelectPolicyStateNotifier extends StateNotifier<bool> {
  SelectPolicyStateNotifier() : super(false);

  void changeFalse() {
    state = false;
  }

  void changeTrue() {
    state = true;
  }
}

// class SelectPriceIndexNotifier extends StateNotifier<int> {
//   SelectPriceIndexNotifier() : super(0);

//   void updateIndex(int newIndex) {
//     state = newIndex;
//   }
// }

class SelectPriceIndexNotifier extends StateNotifier<int> {
  SelectPriceIndexNotifier([int initialIndex = 20]) : super(initialIndex);

  void resetState() {
    state = 20; // Reset to initial value
  }

  void updateIndex(int newIndex) {
    state = newIndex;
  }
}
