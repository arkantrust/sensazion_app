import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sensazion_app/src/authentication/authentication.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sensazion_app/src/app/snack_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static GoRoute route() => GoRoute(path: '/profile', builder: (_, __) => const ProfilePage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final name = '${user.firstName} ${user.lastName}';
    final palette = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: _CustomDrawClip(),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.32,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [palette.secondary, palette.primary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 48,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: CachedNetworkAvifImage(
                            user.avatarUrl,
                            height: 96,
                            width: 96,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _ProfileField(label: 'ID', value: user.id, icon: Icons.perm_identity_outlined),
            _ProfileField(label: 'Email', value: user.email, icon: Icons.email_outlined),
          ],
        ),
        floatingActionButton: FloatingActionButton.small(
          heroTag: 'signout',
          onPressed: () {
            HapticFeedback.mediumImpact();
            context.read<AuthenticationBloc>().add(AuthenticationSignOutPressed());
          },
          tooltip: 'Cerrar sesión',
          child: const Icon(Icons.logout),
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _ProfileField({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: palette.primary),
        ),
        subtitle: AutoSizeText(
          value,
          maxLines: 1,
          minFontSize: 8,
          maxFontSize: 16,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 8),
          child: Icon(icon, color: palette.primary),
        ),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: value));
          HapticFeedback.mediumImpact();
          if (context.mounted) {
            context.showSnackBar('Copiado!');
          }
        },
      ),
    );
  }
}

class _CustomDrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.cubicTo(
      size.width * 0.25,
      size.height,
      size.width * 0.75,
      size.height - 100,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
