import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/home_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Consumer<AuthProvider>(
            builder: (context, auth, child) {
              final user = auth.user;
              return UserAccountsDrawerHeader(
                accountName: Text(user != null 
                    ? '${user.firstName} ${user.lastName}' 
                    : 'Guest'),
                accountEmail: Text(user?.email ?? 'guest@example.com'),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    user != null 
                        ? '${user.firstName[0]}${user.lastName[0]}'
                        : 'G',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              );
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Cart'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CartScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ProfileScreen()),
                    );
                  },
                ),
                Divider(),
                Consumer<ThemeProvider>(
                  builder: (context, theme, child) {
                    return ListTile(
                      leading: Icon(theme.themeMode == ThemeMode.dark 
                          ? Icons.light_mode 
                          : Icons.dark_mode),
                      title: Text(theme.themeMode == ThemeMode.dark 
                          ? 'Light Theme' 
                          : 'Dark Theme'),
                      onTap: () {
                        theme.toggleTheme();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Logout'),
                        content: Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              Provider.of<AuthProvider>(context, listen: false)
                                  .logout();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (_) => LoginScreen()),
                                (route) => false,
                              );
                            },
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}