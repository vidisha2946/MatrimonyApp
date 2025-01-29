import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
class AddPage extends StatefulWidget {
  final Function addUser;
  AddPage ({required this.addUser});
  @override
  _AddPageState createState() => _AddPageState();

  void search(s) {}
}
class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  String? _selectedGender;
  List<String> _selectedHobbies = [];
  final List<String> _hobbies = ['Reading', 'Sports', 'Music', 'Traveling', 'Gaming'];

  get s => null;

  @override
  void dispose() {
    _dobController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  String? _validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return "Date of Birth is required";
    }
    final dob = DateTime.tryParse(value.split('/').reversed.join('-'));
    if (dob == null) return "Enter a valid date (DD/MM/YYYY)";
    final age = DateTime.now().difference(dob).inDays ~/ 365;
    if (age < 18) return "You must be at least 18 years old";
    if (age > 80) return "Age cannot exceed 80 years";
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedHobbies.isNotEmpty) {
      // Add user data to the list
      Map<String,dynamic> u = {
        'name': _nameController.text,
        'email': _emailController.text,
        'mobile': _mobileController.text,
        'dob': _dobController.text,
        'city': _cityController.text,
        'gender': _selectedGender,
        'hobbies': _selectedHobbies.join(', '),
      };
      widget.addUser(u);
      widget.search(s);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Full Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email Address is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile Number is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth (DD/MM/YYYY)',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.date_range),
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
                        firstDate: DateTime.now().subtract(const Duration(days: 80 * 365)),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        _dobController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      }
                    },
                  ),
                ),
                validator: _validateDOB,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  prefixIcon: const Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'City is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                value: _selectedGender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 8.0,
                children: _hobbies.map((hobby) {
                  return FilterChip(
                    label: Text(hobby),
                    selected: _selectedHobbies.contains(hobby),
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          _selectedHobbies.add(hobby);
                        } else {
                          _selectedHobbies.remove(hobby);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              if (_selectedHobbies.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Please select at least one hobby',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: Colors.pinkAccent.shade100,
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
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