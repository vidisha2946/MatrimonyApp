import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> user = [
    {
      "Name": "Alice",
      "City": "New York",
      "phone": "123-456-7890",
      "Email": "alice@example.com",
      "isFav": false,
    },
    {
      "Name": "Bob",
      "City": "Los Angeles",
      "phone": "987-654-3210",
      "Email": "bob@example.com",
      "isFav": false,
    },
    {
      "Name": "Charlie",
      "City": "Chicago",
      "phone": "555-666-7777",
      "Email": "charlie@example.com",
      "isFav": true,
    },
  ];

  Widget getUserList(int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: user[i]["isFav"] ? Colors.pink.shade100 : Colors.white, // Change card color
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              user[i]["Name"][0],
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: Colors.pink.shade400,
            foregroundColor: Colors.white,
          ),
          title: Text(
            user[i]["Name"],
            style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_city_outlined,
                      size: 18, color: Colors.pink.shade400),
                  SizedBox(width: 5),
                  Text(
                    "City: ${user[i]["City"]}",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone_outlined,
                      size: 18, color: Colors.pink.shade400),
                  SizedBox(width: 5),
                  Text("Phone: ${user[i]["phone"]}"),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.email_outlined,
                      size: 18, color: Colors.pink.shade400),
                  SizedBox(width: 5),
                  Expanded(child: Text("Email: ${user[i]["Email"]}")),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        user[i]['isFav'] = !user[i]['isFav'];
                      });
                    },
                    icon: Icon(
                      user[i]['isFav']
                          ? Icons.favorite
                          : Icons.favorite_outline,
                    ),
                    color: Colors.red,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit, color: Colors.pinkAccent.shade200),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        user.removeAt(i);
                      });
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("User List", style: TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.pink.shade200,
        ),
        body: ListView.builder(
          itemCount: user.length,
          itemBuilder: (context, index) {
            return getUserList(index);
          },
        ),
      ),
    );
  }
}
