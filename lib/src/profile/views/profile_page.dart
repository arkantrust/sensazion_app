import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sensazion_app/src/authentication/authentication.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static GoRoute route() {
    return GoRoute(path: '/profile', builder: (context, state) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('ID: ${user.id}'),
              const SizedBox(height: 8),
              Text(user.email),
              const SizedBox(height: 8),
              CircleAvatar(
                radius: 64,
                child: CachedNetworkAvifImage(user.avatarUrl, height: 128, fit: BoxFit.cover),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'signout',
          onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationSignOutPressed()),
          child: const Icon(Icons.logout),
        ),
      ),
    );
  }
}
