import 'package:first_block_app/components/container.dart';
import 'package:first_block_app/models/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterContainer extends BlocContainer {
  const CounterContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Column(children: [
              Text(state.toString()),
            ]);
          },
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => _increment(context)),
    );
  }

  Set<void> _increment(BuildContext context) {
    return {
      context.read<CounterCubit>().increment(),
    };
  }
}
