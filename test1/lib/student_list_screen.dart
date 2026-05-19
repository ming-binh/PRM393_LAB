import 'package:flutter/material.dart';
import 'package:test1/Entities/Student.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final List<Student> _students = [
    Student(id: '1', name: 'John Doe', age: 20),
    Student(id: '2', name: 'Jane Smith', age: 22),
  ];

  String _searchQuery = '';

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _idController = TextEditingController();

  List<Student> get _filteredStudents {
    if (_searchQuery.isEmpty) return _students;
    return _students
        .where((s) =>
            s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            s.id.contains(_searchQuery))
        .toList();
  }

  void _showStudentDialog({Student? student}) {
    if (student != null) {
      _idController.text = student.id;
      _nameController.text = student.name;
      _ageController.text = student.age.toString();
    } else {
      _idController.clear();
      _nameController.clear();
      _ageController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(student == null ? 'Add Student' : 'Edit Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID'),
              enabled: student == null,
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final id = _idController.text;
              final name = _nameController.text;
              final age = int.tryParse(_ageController.text) ?? 0;

              if (id.isNotEmpty && name.isNotEmpty) {
                setState(() {
                  if (student == null) {
                    _students.add(Student(id: id, name: name, age: age));
                  } else {
                    student.name = name;
                    student.age = age;
                  }
                });
                Navigator.pop(context);
              }
            },
            child: Text(student == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _deleteStudent(String id) {
    setState(() {
      _students.removeWhere((s) => s.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredStudents;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or ID...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: filtered.isEmpty
          ? const Center(child: Text('No students found.'))
          : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final student = filtered[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('ID: ${student.id} | Age: ${student.age}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showStudentDialog(student: student),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteStudent(student.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStudentDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _idController.dispose();
    super.dispose();
  }
}
