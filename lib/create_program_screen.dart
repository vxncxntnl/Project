import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'program_item.dart';

class CreateProgramScreen extends StatefulWidget {
  final ProgramItem? program;

  CreateProgramScreen({this.program});

  @override
  _CreateProgramScreenState createState() => _CreateProgramScreenState();
}

class _CreateProgramScreenState extends State<CreateProgramScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController(); // Added for displaying date

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.program != null) {
      _titleController.text = widget.program!.title;
      _descriptionController.text = widget.program!.description;
      _timeController.text = widget.program!.time;
      _locationController.text = widget.program!.location;
      _selectedDate = widget.program!.date;
      _dateController.text = _selectedDate != null
          ? DateFormat('MMMM d, y').format(_selectedDate!)
          : ''; // Format date to display
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('MMMM d, y').format(pickedDate);
      });
    }
  }

  void _saveProgram() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final newProgram = ProgramItem(
      title: _titleController.text,
      description: _descriptionController.text,
      time: _timeController.text,
      location: _locationController.text,
      date: _selectedDate!,
    );

    Navigator.pop(context, newProgram);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.local_activity, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Create or Edit Program',
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
      body: Container(
        // Ensure the container takes up the full height of the screen
        height: double.infinity, // Make sure the container fills the screen height
        color: const Color.fromARGB(255, 183, 193, 250), // Set background color for the body
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Program Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 20),

                // Title input
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Program Title',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),

                // Description input
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  style: TextStyle(fontSize: 16),
                  maxLines: 4,
                ),
                SizedBox(height: 16),

                // Time input
                TextField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: 'Time',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),

                // Location input
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),

                // Date input
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  readOnly: true,
                  onTap: _pickDate,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 30),

                // Save Button
                Center(
                  child: ElevatedButton(
                    onPressed: _saveProgram,
                    style: ElevatedButton.styleFrom(
                       backgroundColor: const Color.fromARGB(255, 206, 224, 255),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Save Program',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
