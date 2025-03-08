import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'create_program_screen.dart';
import 'program_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Service Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(),
        buttonTheme: ButtonThemeData(buttonColor: Colors.blueAccent),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent,
        ),
      ),
      home: ProgramScreen(),
    );
  }
}

class ProgramScreen extends StatefulWidget {
  @override
  _ProgramScreenState createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  List<ProgramItem> programs = [
    ProgramItem(
      title: 'Community Cleanup',
      description: 'Help clean the community park.',
      time: '10:00 AM',
      location: 'Central Park',
      date: DateTime.now().add(Duration(days: 2)), // Future date
    ),
    ProgramItem(
      title: 'Tree Planting',
      description: 'Join us to plant trees in the neighborhood.',
      time: '1:00 PM',
      location: 'River Road',
      date: DateTime.now().subtract(Duration(days: 1)), // Past date (Completed)
    ),
  ];

  void _navigateToCreateProgramScreen([ProgramItem? program]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateProgramScreen(program: program),
      ),
    ).then((newProgram) {
      if (newProgram != null) {
        setState(() {
          if (program != null) {
            int index = programs.indexOf(program);
            programs[index] = newProgram;
          } else {
            programs.add(newProgram);
          }
        });
      }
    });
  }

  void _markAsCompleted(ProgramItem program) {
    setState(() {
      program.date = DateTime.now().subtract(Duration(days: 1));
    });
  }

  Widget _buildProgramCard(ProgramItem program, {bool isCompleted = false}) {
    return Card(
      color: isCompleted ? Colors.grey[300] : const Color.fromARGB(255, 182, 182, 182),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      child: ListTile(
        title: Text(
          program.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isCompleted ? Colors.grey : Colors.blueAccent,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(program.description),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.black54),
                SizedBox(width: 5),
                Text(program.time),
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.black54),
                SizedBox(width: 5),
                Text(program.location),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                SizedBox(width: 5),
                Text(DateFormat.yMMMd().format(program.date)),
              ],
            ),
          ],
        ),
        trailing: isCompleted
            ? Icon(Icons.check_circle, color: Colors.green)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _navigateToCreateProgramScreen(program),
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () => _markAsCompleted(program),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ProgramItem> upcomingPrograms =
        programs.where((program) => program.date.isAfter(DateTime.now())).toList();
    List<ProgramItem> completedPrograms =
        programs.where((program) => program.date.isBefore(DateTime.now())).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Community Service Platform'),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/COC-PHINMA.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Community Service Platform',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Settings'),
                    content: Text('The settings are under development. Stay tuned!'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context), child: Text('OK')),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('About Us'),
                    content: Text(
                        'We are Vincent Niel Quinto and Ryan Christian Tagapulot, second-year BSIT students passionate about technology and innovation. Currently, we are working on projects that enhance our skills in system development and IT solutions.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact Us'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Contact Us'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('For inquiries, please email us at:'),
                        Text('vincentnielquinto1@gmail.com'),
                        Text('ryantagapulot@gmail.com'),
                        SizedBox(height: 10),
                        Text('You can also contact us via Facebook:'),
                        GestureDetector(
                          onTap: () {
                            _launchURL('https://www.facebook.com/hollographic21/');
                          },
                          child: Text(
                            'Vincent\'s Facebook',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            _launchURL('https://www.facebook.com/ryantagz');
                          },
                          child: Text(
                            'Ryan\'s Facebook',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          if (upcomingPrograms.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Upcoming Events',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ...upcomingPrograms.map((program) => _buildProgramCard(program)).toList(),
          if (completedPrograms.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Completed Events',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ...completedPrograms.map((program) => _buildProgramCard(program, isCompleted: true)).toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateProgramScreen(),
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        elevation: 6,
        tooltip: 'Create New Program',
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
