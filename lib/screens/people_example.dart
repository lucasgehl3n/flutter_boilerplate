import 'package:first_block_app/components/container.dart';
import 'package:first_block_app/database/dao/people_dao.dart';
import 'package:first_block_app/models/people.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class PeopleListState {
  const PeopleListState();
}

@immutable
class InitContactsListState extends PeopleListState {
  const InitContactsListState();
}

@immutable
class LoadingPeopleListState extends PeopleListState {
  const LoadingPeopleListState();
}

@immutable
class LoadedPeopleListState extends PeopleListState {
  final List<People> _registers;
  const LoadedPeopleListState(this._registers);
}

@immutable
class FatalErrorPeopleListState extends PeopleListState {
  const FatalErrorPeopleListState();
}

class PeopleListCubit extends Cubit<PeopleListState> {
  PeopleListCubit() : super(const InitContactsListState());

  void reload(PeopleDao dao) async {
    emit(const LoadingPeopleListState());
    var registers = await dao.findRegisters();
    emit(LoadedPeopleListState(registers));
  }
}

class PeopleListContainer extends BlocContainer {
  const PeopleListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PeopleDao dao = PeopleDao();
    return BlocProvider<PeopleListCubit>(
      create: (BuildContext context) {
        final cubit = PeopleListCubit();
        cubit.reload(dao);
        return cubit;
      },
      child: const PeopleView(),
    );
  }
}

class PeopleView extends StatelessWidget {
  const PeopleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<PeopleListCubit, PeopleListState>(
          builder: (context, state) {
            if (state is InitContactsListState ||
                state is LoadingPeopleListState) {
              return const Text('Carregando');
            }

            if (state is LoadedPeopleListState) {
              final registers = state._registers;
              return ListView.builder(itemBuilder: (context, index) {
                final register = registers[index];

                //List my registers
                return Text(register.name);
              });
            }

            return const Text('Erro desconhecido');
          },
        ),
      ),
    );
  }
}
