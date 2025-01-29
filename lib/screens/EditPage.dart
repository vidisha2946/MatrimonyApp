import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final Map<String, dynamic> userData; // Existing user data
  final Function(Map<String, dynamic>) updateUser; // Callback to save updated data
  EditPage({required this.userData, required this.updateUser});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dobController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _cityController;
  late TextEditingController _ageController;
  final TextEditingController _hobbyController = TextEditingController(); // Added age controller
  String? _selectedGender;
  List<String> _selectedHobbies = [];
  final List<String> _hobbies = ['Reading', 'Sports', 'Music', 'Traveling', 'Gaming'];
  List<String> cities = [
    "Ahmedabad",
    "Amreli",
    "Anand",
    "Bharuch",
    "Bhavnagar",
    "Bhuj",
    "Botad",
    "Dahod",
    "Deesa",
    "Gandhidham",
    "Gandhinagar",
    "Godhra",
    "Himmatnagar",
    "Jamnagar",
    "Junagadh",
    "Kheda",
    "Kutch",
    "Mahesana",
    "Morbi",
    "Nadiad",
    "Navsari",
    "Palanpur",
    "Patan",
    "Porbandar",
    "Rajkot",
    "Surat",
    "Surendranagar",
    "Valsad",
    "Vapi",
    "Veraval",
    "Vadodara",
    "Dhoraji",
    "Gondal",
    "Jetpur",
    "Kalol",
    "Kapadvanj",
    "Karamsad",
    "Khambhat",
    "Lathi",
    "Lunawada",
    "Mandvi",
    "Mangrol",
    "Mansa",
    "Modasa",
    "Petlad",
    "Radhanpur",
    "Sihor",
    "Thangadh",
    "Unjha",
    "Visnagar"
  ];

  @override
  void initState() {
    super.initState();
    _dobController = TextEditingController(text: widget.userData['dob']);
    _nameController = TextEditingController(text: widget.userData['name']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _mobileController = TextEditingController(text: widget.userData['mobile']);
    _cityController = TextEditingController(text: widget.userData['city']);
    _ageController = TextEditingController(); // Initialize age controller
    _selectedGender = widget.userData['gender'];
    _selectedHobbies = widget.userData['hobbies'].split(', ');


    // Update the age based on the initial DOB
    _updateAgeFromDOB();
  }

  @override
  // Calculate age from DOB and update the age controller
  void _updateAgeFromDOB() {
    if (_dobController.text.isNotEmpty) {
      final dobParts = _dobController.text.split('/');
      if (dobParts.length == 3) {
        final dob = DateTime.tryParse('${dobParts[2]}-${dobParts[1]}-${dobParts[0]}');
        if (dob != null) {
          final age = DateTime.now().difference(dob).inDays ~/ 365;
          _ageController.text = age.toString(); // Update age field
          return;
        }
      }
    }
    _ageController.text = ''; // Clear age if DOB is invalid
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
      // Prepare updated user data
      Map<String, dynamic> updatedUser = {
        'name': _nameController.text,
        'email': _emailController.text,
        'mobile': _mobileController.text,
        'dob': _dobController.text,
        'age': _ageController.text, // Include the updated age
        'city': _cityController.text,
        'gender': _selectedGender,
        'hobbies': _selectedHobbies.join(', '),
      };
      // Call the callback to update the user in parent state
      Navigator.pop(context, updatedUser); // Return the updated user to the parent screen
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
        title: const Text('Edit User'),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
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
                        _updateAgeFromDOB(); // Update age when DOB is picked
                      }
                    },
                  ),
                ),
                validator: _validateDOB,
                onChanged: (value) => _updateAgeFromDOB(), // Update age when DOB is changed
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _ageController,
                readOnly: true, // Age should be read-only
                decoration: InputDecoration(
                  labelText: 'Age',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'City',
                  prefixIcon: const Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
                value: _cityController.text.isNotEmpty ? _cityController.text : null, // Default to empty if no city selected
                items: cities
                    .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _cityController.text = value ?? ''; // Update the selected city in the controller
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'City is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              // Gender Selection
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female', 'Other'].map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Gender is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              // Hobbies Selection
              TextFormField(
                controller: _hobbyController,
                decoration: InputDecoration(
                  labelText: 'Add a Custom Hobby',
                  prefixIcon: const Icon(Icons.edit),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  final hobby = _hobbyController.text.trim();
                  if (hobby.isNotEmpty && !_selectedHobbies.contains(hobby)) {
                    setState(() {
                      _selectedHobbies.add(hobby); // Add the hobby to the list
                      _hobbyController.clear(); // Clear the input field
                    });
                  }
                },
                child: const Text('Add Hobby'),
              ),

              // Display manually added hobbies
              const SizedBox(height: 16.0),
              if (_selectedHobbies.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  children: _selectedHobbies.map((hobby) {
                    return Chip(
                      label: Text(hobby),
                      backgroundColor: Colors.pinkAccent.shade100,
                      deleteIcon: const Icon(Icons.cancel, size: 18, color: Colors.white),
                      onDeleted: () {
                        setState(() {
                          _selectedHobbies.remove(hobby); // Remove the hobby from the list
                        });
                      },
                    );
                  }).toList(),
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
                    'Update',
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
