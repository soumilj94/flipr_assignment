import 'package:flipr_assignment/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flipr_assignment/services/auth_service.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _fetchUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("No user information available."));
        }

        final userData = snapshot.data!;
        final email = userData['email'] ?? 'No email available';
        final name = userData['name'] ?? 'No name available';

        return Scaffold(
          appBar: AppBar(title: const Text("Profile")),
          body: Padding(padding: const EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: $name"),
                const SizedBox(height: 20),
                Text("Email: $email"),
                const SizedBox(height: 20),
                
                Column(
                  children: [
                    SizedBox(width: double.infinity, height: 50,
                      child: FilledButton(
                        onPressed: (){
                          AuthService().signOut();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const WelcomeScreen()), (route)=> false);
                        },
                        child: const Text("Logout"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /// Fetch user details
  Future<Map<String, dynamic>?> _fetchUserDetails() async {
    final authService = AuthService();
    final user = authService.getCurrentUser();

    if (user != null) {
      final userDetails = await authService.fetchUserDetails(user.uid);
      return {
        'email': user.email,
        ...?userDetails,
      };
    }

    return null;
  }
}
