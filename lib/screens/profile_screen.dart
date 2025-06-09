import 'package:flutter/material.dart';
import '../constants/text_styles.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final User mockUser = const User(
    name: 'Diyanjani Jayamanne',
    email: 'diyanjanij@gmail.com',
    avatarUrl: 'assets/images/dili.JPG',
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyles.heading(context)),
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade50,
        foregroundColor: textColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(mockUser.avatarUrl),
            ),
            const SizedBox(height: 20),
            Text(
              mockUser.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              mockUser.email,
              style: TextStyle(fontSize: 16, color: textColor.withOpacity(0.7)),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
