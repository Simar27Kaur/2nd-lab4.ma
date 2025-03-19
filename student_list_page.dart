import 'package:flutter/material.dart';
import 'database_helper.dart';  // Importing the DatabaseHelper

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController marksController = TextEditingController();
  late Future<List<Map<String, dynamic>>> students;

  @override
  void initState() {
    super.initState();
    students = DatabaseHelper().getStudents();  // Fetch the list of students
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Marks Management'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Student Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: marksController,
              decoration: InputDecoration(
                labelText: 'Marks',
              ),
              keyboardType: TextInputType.number, // Correctly added keyboardType
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty && marksController.text.isNotEmpty) {
                Map<String, dynamic> student = {
                  'name': nameController.text,
                  'marks': int.parse(marksController.text),
                };
                int result = await DatabaseHelper().insertStudent(student);
                print("Student Added, Result: $result");  // Debugging line
                setState(() {
                  students = DatabaseHelper().getStudents();  // Refresh the list
                });
                nameController.clear();
                marksController.clear();
              }
            },
            child: Text('Add Student'),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: students,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No students found'));
                } else {
                  print("Students Fetched: ${snapshot.data}");  // Debugging line
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var student = snapshot.data![index];
                      return ListTile(
                        title: Text(student['name']),
                        subtitle: Text('Marks: ${student['marks']}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
