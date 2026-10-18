
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color teal = Color(0xFF008C8C);
  static const Color darkSlate = Color(0xFF263746);

  String name = 'Your Name';
  String email = 'your.email@example.com';
  String phone = '';

  void _editProfile() {
    final nameController = TextEditingController(text: name);
    final emailController = TextEditingController(text: email);
    final phoneController = TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                name = nameController.text.trim().isEmpty
                    ? 'Your Name'
                    : nameController.text.trim();
                email = emailController.text.trim().isEmpty
                    ? 'your.email@example.com'
                    : emailController.text.trim();
                phone = phoneController.text.trim();
              });
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated!')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDetails(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: teal,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),
            const CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xFFD9F0EE),
              child: Icon(Icons.person, size: 65, color: teal),
            ),
            const SizedBox(height: 15),
            Text(
              name,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: darkSlate,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            if (phone.isNotEmpty) ...[
              const SizedBox(height: 5),
              Text(phone, style: const TextStyle(color: Colors.grey)),
            ],
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _editProfile,
              icon: const Icon(Icons.edit, size: 18),
              label: const Text('Edit Profile'),
              style: OutlinedButton.styleFrom(
                foregroundColor: teal,
                side: const BorderSide(color: teal),
              ),
            ),
            const SizedBox(height: 30),
            _sectionTitle('Account Settings'),
            _menuItem(
              icon: Icons.person_outline,
              title: 'Personal Information',
              subtitle: 'Manage your name and contact details',
              onTap: _editProfile,
            ),
            _menuItem(
              icon: Icons.location_on_outlined,
              title: 'My Addresses',
              subtitle: 'Manage your saved addresses',
              onTap: () => _showDetails(
                'My Addresses',
                'Your saved addresses will appear here.',
              ),
            ),
            _menuItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Manage your notifications',
              onTap: () => _showDetails(
                'Notifications',
                'Notification settings will be available here.',
              ),
            ),
            const SizedBox(height: 20),
            _sectionTitle('Support'),
            _menuItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () => _showDetails(
                'Help & Support',
                'For assistance with LocalFix, contact your service provider or support team.',
              ),
            ),
            _menuItem(
              icon: Icons.info_outline,
              title: 'About LocalFix',
              subtitle: 'Local services, trusted people',
              onTap: () => _showDetails(
                'About LocalFix',
                'LocalFix connects customers with local household service professionals.',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showDetails(
                  'Log Out',
                  'Login and logout functionality has not been connected yet.',
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: darkSlate,
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFD9F0EE),
          child: Icon(icon, color: teal),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: darkSlate,
          ),
        ),
        subtitle: subtitle == null ? null : Text(subtitle),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
