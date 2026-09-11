import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class UserProfile {
  final String name;
  final String status;

  const UserProfile({required this.name, required this.status});
}

class UserDataManager extends InheritedWidget {
  final UserProfile profile;
  final Function(String, String) updateProfile;

  const UserDataManager({
    super.key,
    required this.profile,
    required this.updateProfile,
    required super.child,
  });

  static UserDataManager? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserDataManager>();
  }

  @override
  bool updateShouldNotify(UserDataManager oldWidget) {
    return oldWidget.profile != profile;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserProfile _profile = const UserProfile(
    name: 'Macky S. Maun',
    status: 'Pogi si Sir Rodney.',
  );

  void _updateProfile(String name, String status) {
    setState(() {
      _profile = UserProfile(name: name, status: status);
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserDataManager(
      profile: _profile,
      updateProfile: _updateProfile,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: const ProfileScreen(),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = UserDataManager.of(context)!;

    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                child: Icon(Icons.person, size: 60),
              ),
              const SizedBox(height: 24),
              Text(
                data.profile.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data.profile.status,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}