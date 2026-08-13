import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/counter_cubit.dart';
import 'views/counter_view.dart';

class Day100FlutterBloc extends StatelessWidget {
  const Day100FlutterBloc({super.key});

  @override
  Widget build(BuildContext context) {
    // We inject the "Brain" here so the View can use it.
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: const CounterView(),
    );
  }
}
