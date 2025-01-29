import 'package:flutter/material.dart';
import 'UserDetailPage.dart';
import 'dashboard_screen.dart';

class FavoriteUserPage extends StatefulWidget {
  final List<Map<String, dynamic>> f;
  FavoriteUserPage({required this.f});
  @override
  _FavoriteUserPageState createState() => _FavoriteUserPageState();
}

class _FavoriteUserPageState extends State<FavoriteUserPage> {
  late List<Map<String, dynamic>> favoriteUsers;

  @override
  void initState() {
    super.initState();
    favoriteUsers = widget.f;
  }

  void _deleteUser(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                favoriteUsers.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _favUser(int index) {
    setState(() {
      favoriteUsers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Users'),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Check if the list is empty
            if (favoriteUsers.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_off_outlined,
                        color: Colors.pinkAccent.shade100,
                        size: 80,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'No favorite users yet!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent.shade100,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add users to your favorites to see them here.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              )

            else
              Expanded(
                child: ListView.builder(
                  itemCount: favoriteUsers.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> user = favoriteUsers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.pinkAccent.shade100,
                          child: Text(
                            user['name'][0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        title: Text(
                          user['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          '${user['city']} | Age: ${user['age']}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                user['isFavorite'] ?? true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () => _favUser(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteUser(index),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailPage(user: user),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
