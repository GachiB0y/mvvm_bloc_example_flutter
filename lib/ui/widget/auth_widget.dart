import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_example/domain/blocs/auth_bloc.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  static Widget create() {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(context),
      child: const AuthWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _ErrorTitleWidget(),
              SizedBox(
                height: 5,
              ),
              _LoginWidget(),
              SizedBox(
                height: 10,
              ),
              _PasswordWidget(),
              SizedBox(
                height: 10,
              ),
              AuthButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginWidget extends StatelessWidget {
  const _LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) => previous.login != current.login,
        builder: (context, state) {
          return TextField(
            decoration: const InputDecoration(
                labelText: 'Логин', border: OutlineInputBorder()),
            onChanged: (username) =>
                context.read<AuthBloc>().add(AuthChangeLoginEvent(username)),
          );
        });
  }
}

class _PasswordWidget extends StatelessWidget {
  const _PasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          decoration: const InputDecoration(
              labelText: 'Пароль', border: OutlineInputBorder()),
          onChanged: (password) =>
              context.read<AuthBloc>().add(AuthChangePasswordEvent(password)),
        );
      },
    );
  }
}

class _ErrorTitleWidget extends StatelessWidget {
  const _ErrorTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authErrorTitle =
        context.select((AuthBloc value) => value.state.authErrorTitle);
    return Text(
      authErrorTitle,
      style: const TextStyle(color: Colors.red),
    );
  }
}

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      final child =
          state.authButtonState == ViewModelAuthButtonState.authProcces
              ? const SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator())
              : const Text('Авторизация');
      return ElevatedButton(
        onPressed: () =>
            state.authButtonState == ViewModelAuthButtonState.canSubmit
                ? context.read<AuthBloc>().add(AuthButtonPressedEvent())
                : null,
        child: child,
      );
    });
  }
}
