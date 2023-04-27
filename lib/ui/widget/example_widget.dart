import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_example/domain/blocs/users_bloc.dart';
import 'package:mvvm_example/ui/widget/nav_bar_widget.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  static Widget create() {
    return BlocProvider<UsersBloc>(
      create: (context) => UsersBloc(context),
      child: const ExampleWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () => {bloc.add(UsersLogoutEvent())},
              child: const Text('Выход')),
        ],
      ),
      drawer: const NavBarWidget(),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _AgeTitle(),
            _AgeIncrementWidget(),
            _AgeDecrementWidget(),
          ],
        ),
      )),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        final age = state.currentUser.age;
        return Text('$age');
      },
    );
  }
}

class _AgeIncrementWidget extends StatelessWidget {
  const _AgeIncrementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    return ElevatedButton(
        onPressed: () => bloc.add(UsersIncrementAgeEvent()),
        child: const Text('+'));
  }
}

class _AgeDecrementWidget extends StatelessWidget {
  const _AgeDecrementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();

    return ElevatedButton(
        onPressed: () => bloc.add(UsersDecrementAgeEvent()),
        child: const Text('-'));
  }
}
