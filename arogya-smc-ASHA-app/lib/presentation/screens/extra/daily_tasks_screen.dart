import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../core/theme/app_theme.dart';

class DailyTasksScreen extends StatefulWidget {
  const DailyTasksScreen({super.key});

  @override
  State<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  List<Map<String, dynamic>> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString('daily_tasks');
    if (tasksJson != null) {
      setState(() {
        _tasks = List<Map<String, dynamic>>.from(json.decode(tasksJson));
        _isLoading = false;
      });
    } else {
      // Default tasks if none found
      _tasks = [
        {'title': 'Visit 5 households in Ward', 'isCompleted': false},
        {'title': 'Follow-up on Immunization', 'isCompleted': false},
        {'title': 'Environmental risk check', 'isCompleted': false},
        {'title': 'Submit Monthly Data', 'isCompleted': false},
      ];
      _saveTasks();
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('daily_tasks', json.encode(_tasks));
  }

  void _addTask() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter task description'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _tasks.add({'title': controller.text, 'isCompleted': false});
                });
                _saveTasks();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Tasks')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    border: const Border(bottom: BorderSide(color: AppColors.divider)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 40),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Daily Progress',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                          ),
                          Text(
                            '${_tasks.where((t) => t['isCompleted'] == true).length} of ${_tasks.length} tasks completed',
                            style: const TextStyle(color: AppColors.textSecondary, fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _tasks.isEmpty
                      ? const Center(child: Text('No tasks for today!'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: _tasks.length,
                          itemBuilder: (context, index) {
                            final task = _tasks[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: CheckboxListTile(
                                title: Text(
                                  task['title'],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    decoration: task['isCompleted'] ? TextDecoration.lineThrough : null,
                                    color: task['isCompleted'] ? AppColors.textLight : AppColors.textPrimary,
                                  ),
                                ),
                                value: task['isCompleted'],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                activeColor: AppColors.primary,
                                onChanged: (val) {
                                  setState(() {
                                    _tasks[index]['isCompleted'] = val;
                                  });
                                  _saveTasks();
                                },
                                controlAffinity: ListTileControlAffinity.leading,
                                secondary: IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      _tasks.removeAt(index);
                                    });
                                    _saveTasks();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, size: 32, color: Colors.white),
      ),
    );
  }
}
