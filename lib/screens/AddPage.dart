import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  final Function addUser;
  AddPage({required this.addUser});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController(); // For manual hobby input
  String? _selectedGender;
  List<String> _manualHobbies = []; // List to store manually added hobbies
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

  int? _calculatedAge;

  // Helper to calculate age
  void _calculateAge(String dob) {
    final parsedDOB = DateTime.tryParse(dob.split('/').reversed.join('-'));
    if (parsedDOB != null) {
      final age = DateTime.now().difference(parsedDOB).inDays ~/ 365;
      setState(() {
        _calculatedAge = age;
      });
    }
  }

  // Validate date of birth
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

  // Submit form
  void _submitForm() {
    if (_formKey.currentState!.validate() && _manualHobbies.isNotEmpty) {
      // Calculate age based on DOB
      final dob = DateTime.tryParse(_dobController.text.split('/').reversed.join('-'));
      int age = 0;
      if (dob != null) {
        final today = DateTime.now();
        age = today.year - dob.year;
        if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
          age--;
        }
      }

      // Add user data to the list
      Map<String, dynamic> u = {
        'name': _nameController.text,
        'email': _emailController.text,
        'mobile': _mobileController.text,
        'dob': _dobController.text,
        'age': age,
        'city': _cityController.text,
        'gender': _selectedGender,
        'hobbies': _manualHobbies.join(', '),
      };

      widget.addUser(u);
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
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

              // Email
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

              // Mobile Number
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

              // Date of Birth
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
                        final formattedDate =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        _dobController.text = formattedDate;
                        _calculateAge(formattedDate);
                      }
                    },
                  ),
                ),
                validator: _validateDOB,
                onChanged: (value) {
                  _calculateAge(value);
                },
              ),
              const SizedBox(height: 16.0),

              // Age display
              if (_calculatedAge != null)
                Text(
                  'Age: $_calculatedAge years',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 16.0),

              // City
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

              // Gender
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

              // Manual Hobby Input
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
                  if (hobby.isNotEmpty && !_manualHobbies.contains(hobby)) {
                    setState(() {
                      _manualHobbies.add(hobby); // Add the hobby to the list
                      _hobbyController.clear(); // Clear the input field
                    });
                  }
                },
                child: const Text('Add Hobby'),
              ),

              // Display manually added hobbies
              const SizedBox(height: 16.0),
              if (_manualHobbies.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  children: _manualHobbies.map((hobby) {
                    return Chip(
                      label: Text(hobby),
                      backgroundColor: Colors.pinkAccent.shade100,
                      deleteIcon: const Icon(Icons.cancel, size: 18, color: Colors.white),
                      onDeleted: () {
                        setState(() {
                          _manualHobbies.remove(hobby); // Remove the hobby from the list
                        });
                      },
                    );
                  }).toList(),
                ),
              const SizedBox(height: 16.0),

              // Submit button
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
