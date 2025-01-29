import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'AboutUsPage.dart';
import 'AddPage.dart';
import 'FavoriteUserPage.dart';
import 'ProfilePage.dart';
import 'UserListPage.dart';
import 'login_page.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}
class DashboardScreen extends StatefulWidget {

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
   List<Map<String, dynamic>> users = [
     {
       'name': 'Ninja Hathori',
       'email': 'vidu@example.com',
       'mobile': '123-456-7890',
       'dob': '01/01/1990',
       'age': 35,
       'city': 'Kutch',
       'gender': 'Female',
       'hobbies': 'Reading, Traveling, Sports',
     },
     {
       'name': 'Doremon',
       'email': 'diya@example.com',
       'mobile': '9876543210',
       'dob': '01/01/1995',
       'age': 30,
       'city': 'Ahemdabad',
       'gender': 'Female',
       'hobbies': 'Painting, Running',
     },
     {
       'name': 'Sinchan',
       'email': 'nirav@example.com',
       'mobile': '5558883333',
       'dob': '01/01/1998',
       'age': 37,
       'city': 'Bharuch',
       'gender': 'Male',
       'hobbies': 'Swimming, Cooking',
     },
     {
       'name': 'Chhota Bheem',
       'email': 'atu@example.com',
       'mobile': '4442221111',
       'dob': '01/01/1985',
       'age': 40,
       'city': 'Rajkot',
       'gender': 'Male',
       'hobbies': 'Traveling, Gaming',
     },
  ];
   List<Map<String,dynamic>> fs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  int _currentIndex = 0;

   void addUser(Map<String,dynamic> u){
     users.add(u);
     setState(() {
     });
     _currentIndex = 0;
     print("usr :  $users");
   }

   void addF(Map<String,dynamic> f){
     fs.add(f);
     setState(() {

     });
     _currentIndex = 3;
     print("usr :  $users");
   }
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      UserListPage(users: users,favoriteUsers: fs,),
      AddPage(addUser: addUser,),
      FavoriteUserPage(f: fs,),
      AboutUsPage(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.pinkAccent.shade100,
        animationDuration: const Duration(milliseconds: 400),
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.list, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }

}

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.pinkAccent.shade100,
          ),
          child: Row(
            children: [
              // Image on the left side
              ClipOval(
                child: Image.asset(
                  'assets/images/Profit Logo.jpg', // Use the correct path to your image
                  width: 89, // Adjust the size as needed
                  height: 89, // Adjust the size as needed
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16), // Add space between image and text
              // Text next to the image
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'HEART SYNC',
                    style: TextStyle(
                      fontSize: 22, // Slightly larger for emphasis
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5, // Add letter spacing for better design
                      fontFamily: 'Montserrat', // Use a custom font
                    ),
                  ),
                  Text(
                    'Vidisha Bhagiya',
                    style: TextStyle(
                      fontSize: 16, // Larger than before
                      color: Colors.white, // Slightly muted color for secondary text
                      fontWeight: FontWeight.w500, // Medium weight
                      fontFamily: 'Roboto', // Use another custom font
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.home, size: 30),
          title: const Text(
            'Home',
            style: TextStyle(
              fontSize: 18, // Larger and more readable
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto', // Custom font
            ),
          ),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
                  (route) => false,
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.info, size: 30),
          title: const Text(
            'My Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.logout, size: 30),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                content: const Text(
                  'Are you sure you want to log out?',
                  style: TextStyle(fontFamily: 'Roboto'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontFamily: 'Roboto'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false,
                      );
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontFamily: 'Roboto'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
