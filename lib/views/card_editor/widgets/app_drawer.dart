import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/controllers/auth_controller.dart';
import 'package:nappy_mobile/utilities/constants.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: kPrimaryVariantColor,
              ),
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1542273917363-3b1817f69a2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8OXx8fGVufDB8fHx8&w=1000&q=80',
                ),
              ),
              accountName: Text("Daniel"),
              accountEmail: Text("danikingrd@gmail.com"),
            ),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
            GestureDetector(
              onTap: () {
                ref.read(authControllerProvider.notifier).signOut(context);
              },
              child: const ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app),
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.read(authControllerProvider.notifier).deleteUser(context);
              },
              child: const ListTile(
                title: Text('Delete Account'),
                leading: Icon(Icons.delete),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
