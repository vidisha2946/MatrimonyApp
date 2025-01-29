import 'package:flutter/material.dart';
import '../demo.dart';
import 'AddPage.dart';
import 'EditPage.dart';
import 'UserDetailPage.dart';
import 'dashboard_screen.dart';

class UserListPage extends StatefulWidget {
  final List<Map<String, dynamic>> users;
  final List<Map<String, dynamic>> favoriteUsers;

  const UserListPage({
    super.key,
    required this.users,
    required this.favoriteUsers,
  });

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  get updateUser => null;
  get onSave => null;

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
                widget.users.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
  void _toggleFavorite(int index) {
    setState(() {
      if (widget.favoriteUsers.contains(widget.users[index])) {
        widget.favoriteUsers.remove(widget.users[index]);
      } else {
        widget.favoriteUsers.add(widget.users[index]);
      }
    });
  }
  @override
  @override
  Widget build(BuildContext context) {
    final filteredUsers = widget.users
        .where((user) =>
        user['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
        user['city'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
        user['age'].toString().toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      drawer: buildDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name, city, or age',
                labelStyle: const TextStyle(color: Colors.grey), // Label text color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  borderSide: const BorderSide(color: Colors.grey), // Border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey), // Default border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.black), // Highlighted border
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.blueGrey), // Pink search icon
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // Update the search query
                });
              },
            ),
          ),


          Expanded(
            child: filteredUsers.isEmpty
                ? const Center(child: Text('No users available.',))
                : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                var user = filteredUsers[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.pinkAccent.shade100,
                      child: Text(
                        user['name'][0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      user['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${user['city']} | Age: ${user['age']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            widget.favoriteUsers.contains(user)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              _toggleFavorite(widget.users.indexOf(user)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deleteUser(widget.users.indexOf(user)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(
                                  userData: user,
                                  updateUser: (updatedData) {
                                    setState(() {
                                      user = updatedData;
                                    });
                                  },
                                ),
                              ),
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  widget.users[index] = value;
                                });
                              }
                            });
                          },
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
    );
  }

}

