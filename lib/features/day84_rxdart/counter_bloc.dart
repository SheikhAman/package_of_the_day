import 'package:rxdart/rxdart.dart';

/// A simple BLoC (Business Logic Component) using RxDart.
/// This demonstrates how to separate logic from UI using Streams.
class CounterBloc {
  // BehaviorSubject is a specialized StreamController that:
  // 1. Captures the latest item added to it
  // 2. Emits that latest item to any new listener
  final _counterSubject = BehaviorSubject<int>.seeded(0);

  // Expose the stream so the UI can listen to changes
  Stream<int> get counterStream => _counterSubject.stream;

  // Business Logic: Increment the current value
  void increment() => _counterSubject.add(_counterSubject.value + 1);

  // Business Logic: Decrement the current value
  void decrement() => _counterSubject.add(_counterSubject.value - 1);

  // Always close your subjects to prevent memory leaks
  void dispose() => _counterSubject.close();
}
