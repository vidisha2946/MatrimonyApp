import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_page.dart';
import 'screens/sign_up_page.dart';
import 'screens/dashboard_screen.dart';
void main() {
	runApp(
			DevicePreview(builder:(contex)=>
					MyApp()
			)
	);
}
// Main App Widget
class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext
	context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false, // Hides the debug banner
			title: 'HeartSync App',
			theme: ThemeData(primarySwatch: Colors.pink,// Sets the primary color for the app
			),
			initialRoute: '/splash', // Initial screen when the app launches
			routes: {
				'/splash': (context) => SplashScreen(), // Splash Screen route
				'/login': (context) => LoginPage(), // Login Screen route
				'/signup': (context) => SignUpPage(), // Sign Up Screen route
				'/dashboard': (context) => DashboardScreen()
			},
		);
	}
}
