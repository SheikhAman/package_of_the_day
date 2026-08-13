import 'package:flutter_bloc/flutter_bloc.dart';

// THE LOGIC (The Brain)
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  // Prevent negative values ──
  void decrement() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void reset() => emit(0);
}
