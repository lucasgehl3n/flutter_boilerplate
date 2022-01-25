import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit({int initialState = 0}) : super(initialState);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
