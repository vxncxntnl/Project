import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'create_program_screen.dart';
import 'program_item.dart';
import 'package:url_launcher/url_launcher.dart';

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
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.grey[100],
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
      date: DateTime.now().add(Duration(days: 2)),
    ),
    ProgramItem(
      title: 'Tree Planting',
      description: 'Join us to plant trees in the neighborhood.',
      time: '1:00 PM',
      location: 'River Road',
      date: DateTime.now().subtract(Duration(days: 1)),
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
            programs.insert(0, newProgram); // Insert the new program at the first position
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

  void _deleteProgram(ProgramItem program) {
    setState(() {
      programs.remove(program);
    });
  }

  Widget _buildProgramCard(ProgramItem program, {bool isCompleted = false}) {
    return Card(
      color: isCompleted
          ? const Color.fromARGB(255, 183, 217, 255) // Neutral grey color for completed events
          : Colors.orange[50], // Orange color for upcoming events
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(program.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
            ? Icon(Icons.check_circle, color: Colors.green) // Green icon to indicate completion
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _navigateToCreateProgramScreen(program),
                  ),
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () => _markAsCompleted(program),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProgram(program),
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
        title: Row(
          children: [
            Icon(Icons.local_activity, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Community Service Platform',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
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
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text('Home', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Settings', style: TextStyle(color: Colors.white)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Settings'),
                      content: Text('The settings is currently under development. Stay tuned!'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text('About Us', style: TextStyle(color: Colors.white)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('About Us'),
                      content: Text(
                        'We are Vincent Niel Quinto and Ryan Christian Tagapulot, second-year BSIT students passionate about technology and innovation. Currently, we are working on projects that enhance our skills in system development and IT solutions.',
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_mail, color: Colors.white),
                title: Text('Contact Us', style: TextStyle(color: Colors.white)),
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
      ),
      body: Container(
        color: const Color.fromARGB(255, 183, 193, 250), // Set background color for the body
        child: ListView(
          children: [
            if (upcomingPrograms.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Upcoming Events',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 8, 96, 248)),
                ),
              ),
            ...upcomingPrograms.map((program) => _buildProgramCard(program)).toList(),
            if (completedPrograms.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Completed Events',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 126, 109, 95)),
                ),
              ),
            ...completedPrograms.map((program) => _buildProgramCard(program, isCompleted: true)).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToCreateProgramScreen(),
        label: Text('Create New Program Here'),
        icon: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 206, 224, 255),
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
