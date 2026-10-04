import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ProfileScreen(),
  ));
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _currentUsername = 'Guest';

  void _updateUsername(String newName) {
    setState(() {
      _currentUsername = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile Manager'),
      ),
      body: Column(
        children: [
          UserBanner(username: _currentUsername),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ProfileForm(
              onSaveUsername: _updateUsername,
            ),
          ),
        ],
      ),
    );
  }
}

class UserBanner extends StatelessWidget {
  final String username;

  const UserBanner({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text('Welcome, $username!'),
            const FavoriteButton(),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorited ? Icons.star : Icons.star_border,
        color: _isFavorited ? Colors.amber : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _isFavorited = !_isFavorited;
        });
      },
    );
  }
}

class ProfileForm extends StatefulWidget {
  final ValueChanged<String> onSaveUsername;

  const ProfileForm({
    super.key,
    required this.onSaveUsername,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Username cannot be empty';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSaveUsername(_usernameController.text);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Profile saved: ${_usernameController.text}',
                    ),
                  ),
                );
              }
            },
            child: const Text('Save Profile'),
          ),
        ],
      ),
    );
  }
}