import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: user == null
          ? Center(child: Text('No user information'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user.firstName} ${user.lastName}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Username: ${user.username}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Phone: ${user.phone}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      await authProvider.logout();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
    );
  }
}
