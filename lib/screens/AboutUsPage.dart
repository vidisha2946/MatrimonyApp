import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_screen.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.aBeeZee(), // Stylish font for the AppBar title
        ),
        backgroundColor: Colors.pinkAccent.shade100,
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo Section
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/Profit Logo.jpg'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Heart Sync',
                      style: GoogleFonts.actor(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Team Section
              buildSectionTitle('Meet Our Team'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      InfoRow(
                        label: 'Developed by',
                        value: 'Vidisha Bhagiya (23010101017)',
                      ),
                      InfoRow(
                        label: 'Mentored by',
                        value: 'Prof. Mehul Bhundiya (Computer Engineering Department)',
                      ),
                      InfoRow(
                        label: 'Explored by',
                        value: 'ASWDC, School of Computer Science',
                      ),
                      InfoRow(
                        label: 'Eulogized by',
                        value: 'Darshan University, Rajkot, Gujarat - INDIA',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // About ASWDC Section
              buildSectionTitle('About ASWDC'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(child: Image.asset('assets/images/darshanlogo.jpg' , height: 100, width: 120,)),
                            Expanded(child: Image.asset('assets/images/ASWDC-logo.png' , height: 100, width: 120,))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'ASWDC is the Application, Software, and Website Development Center at Darshan University. It is run by students and staff of the School of Computer Science to bridge the gap between university curriculum and industry demands.',
                        style: GoogleFonts.openSans(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Contact Us Section
              buildSectionTitle('Contact Us'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      ContactRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: 'aswdc@darshan.ac.in',
                      ),
                      ContactRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: '+91-9727747317',
                      ),
                      ContactRow(
                        icon: Icons.language,
                        label: 'Website',
                        value: 'www.darshan.ac.in',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Footer Links
              buildFooterLinks(),

              // Copyright Footer
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    '© 2025 Darshan University\nMade with ❤️ in India',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.actor(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.actor(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.pinkAccent,
        ),
      ),
    );
  }

  Widget buildFooterLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildFooterButton(Icons.share, 'Share App'),
        buildFooterButton(Icons.apps, 'More Apps'),
        buildFooterButton(Icons.star, 'Rate Us'),
        buildFooterButton(Icons.thumb_up, 'Like on Facebook'),
        buildFooterButton(Icons.update, 'Check for Update'),
      ],
    );
  }

  Widget buildFooterButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.pinkAccent.shade100),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 10),
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.openSans(),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ContactRow({Key? key, required this.icon, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.pinkAccent.shade100),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
