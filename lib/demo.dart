import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Matrimony App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationFormPage(),
    );
  }
}

class RegistrationFormPage extends StatefulWidget {
  @override
  _RegistrationFormPageState createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  List<Map<String, String>> users = [];
  List<Map<String, String>> filteredUsers = [];

  // Function to add a new user
  void addUser(String fullName, String email, String mobile, String dob, String city, String gender, String password) {
    setState(() {
      users.add({
        'fullName': fullName,
        'email': email,
        'mobile': mobile,
        'dob': dob,
        'city': city,
        'gender': gender,
        'password': password,
        'isFavorite': 'false',
      });
      filteredUsers = List.from(users);
    });
  }

  // Validation methods
  String? _validateFullName(String? value) {
    final regex = RegExp(r"^[a-zA-Z\s'-]{3,50}$");
    if (value == null || value.isEmpty) {
      return 'Please enter your full name.';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid full name (3-50 characters, alphabets only)';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    final regex = RegExp(r"^\+?[0-9]{10,15}$");
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number.';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid 10-digit mobile number.';
    }
    return null;
  }

  String? _validateDOB(String? value) {
    final regex = RegExp(r"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$");
    if (value == null || value.isEmpty) {
      return 'Please enter your date of birth.';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid date in DD/MM/YYYY format.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  // When Submit button is pressed
  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      addUser(
        _fullNameController.text,
        _emailController.text,
        _mobileController.text,
        _dobController.text,
        _cityController.text,
        _selectedGender ?? '',
        _passwordController.text,
      );

      // Navigate to User List page after adding the user
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserListPage(users: filteredUsers),
        ),
      );

      // Clear the form after submitting
      _fullNameController.clear();
      _emailController.clear();
      _mobileController.clear();
      _dobController.clear();
      _cityController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      setState(() {
        _selectedGender = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: _validateFullName,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email Address'),
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(labelText: 'Mobile Number'),
                validator: _validateMobile,
              ),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(labelText: 'Date of Birth (DD/MM/YYYY)'),
                validator: _validateDOB,
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _validatePassword,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: _validateConfirmPassword,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onSubmit,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class UserListPage extends StatefulWidget {
  final List<Map<String, String>> users;

  UserListPage({required this.users});

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late List<Map<String, String>> filteredUsers;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredUsers = widget.users;
    searchController.addListener(_filterUsers);
  }

  // Filter users based on the search input
  void _filterUsers() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredUsers = widget.users.where((user) {
        return user['fullName']!.toLowerCase().contains(query) ||
            user['email']!.toLowerCase().contains(query) ||
            user['city']!.toLowerCase().contains(query) ||
            user['mobile']!.toLowerCase().contains(query);
      }).toList();
    });
  }
  // Handle deleting a user
  void _deleteUser(Map<String, String> user) {
    setState(() {
      widget.users.remove(user);
      filteredUsers = List.from(widget.users);
    });
  }

  // Handle editing a user
  void _editUser(Map<String, String> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserPage(
          user: user,
          onSave: (updatedUser) {
            setState(() {
              int index = widget.users.indexOf(user);
              widget.users[index] = updatedUser;
              filteredUsers = List.from(widget.users);
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Users',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            filteredUsers.isEmpty
                ? Text('No User Found')
                : Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return Card(
                    child: ListTile(
                      title: Text(user['fullName']!),
                      subtitle: Text(user['email']!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                            ),
                            onPressed: () {
                              // Toggle favorite state
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editUser(user); // Navigate to Edit page
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteUser(user); // Delete the user
                            },
                          ),
                        ],
                      ),
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

class EditUserPage extends StatefulWidget {
  final Map<String, String> user;
  final Function(Map<String, String>) onSave;

  EditUserPage({required this.user, required this.onSave});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _dobController;
  late TextEditingController _cityController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.user['fullName']);
    _emailController = TextEditingController(text: widget.user['email']);
    _mobileController = TextEditingController(text: widget.user['mobile']);
    _dobController = TextEditingController(text: widget.user['dob']);
    _cityController = TextEditingController(text: widget.user['city']);
    _passwordController = TextEditingController(text: widget.user['password']);
    _confirmPasswordController = TextEditingController(text: widget.user['password']);
    _selectedGender = widget.user['gender'];
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _dobController.dispose();
    _cityController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_fullNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _mobileController.text.isNotEmpty &&
        _dobController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _selectedGender != null) {
      final updatedUser = {
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'mobile': _mobileController.text,
        'dob': _dobController.text,
        'city': _cityController.text,
        'gender': _selectedGender!,
        'password': _passwordController.text,
      };

      widget.onSave(updatedUser); // Call onSave callback to update user
      Navigator.pop(context); // Close edit page
    } else {
      // Show a message if validation fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            TextFormField(
              controller: _mobileController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
            ),
            TextFormField(
              controller: _dobController,
              decoration: InputDecoration(labelText: 'Date of Birth (DD/MM/YYYY)'),
            ),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
              decoration: InputDecoration(labelText: 'Gender'),
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              ))
                  .toList(),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onSave,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
