import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetailPage({super.key, required this.user});

  // Method to calculate age from DOB
  int _calculateAge(String dob) {
    final dobDate = DateTime.tryParse(dob.split('/').reversed.join('-')); // Convert DD/MM/YYYY to DateTime
    if (dobDate == null) return 0;
    final today = DateTime.now();
    int age = today.year - dobDate.year;
    if (today.month < dobDate.month || (today.month == dobDate.month && today.day < dobDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final age = _calculateAge(user['dob']); // Calculate age based on DOB

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.pinkAccent.shade100,
                    child: Text(
                      user['name'][0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DetailRow(title: "Full Name", value: user['name']),
                const Divider(),
                DetailRow(title: "Email", value: user['email']),
                const Divider(),
                DetailRow(title: "Mobile Number", value: user['mobile']),
                const Divider(),
                DetailRow(title: "Date of Birth", value: user['dob']),
                const Divider(),
                DetailRow(title: "Age", value: "$age years"), // Display the calculated age
                const Divider(),
                DetailRow(title: "City", value: user['city']),
                const Divider(),
                DetailRow(title: "Gender", value: user['gender']),
                const Divider(),
                DetailRow(title: "Hobbies", value: user['hobbies']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String? value;

  const DetailRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value ?? "Not provided",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
