import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../core/theme/app_theme.dart';

class MedicineReminderScreen extends StatefulWidget {
  const MedicineReminderScreen({super.key});

  @override
  State<MedicineReminderScreen> createState() => _MedicineReminderScreenState();
}

class _MedicineReminderScreenState extends State<MedicineReminderScreen> {
  List<Map<String, dynamic>> _reminders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString('med_reminders');
    if (jsonStr != null) {
      setState(() {
        _reminders = List<Map<String, dynamic>>.from(json.decode(jsonStr));
        _isLoading = false;
      });
    } else {
      _reminders = [
        {'patient': 'Sunita Jadhav', 'medicine': 'Iron Tablets', 'dosage': '1 Tablet', 'time': 'Morning', 'isDone': false},
        {'patient': 'Arjun Pawar', 'medicine': 'Vitamin Syrup', 'dosage': '5ml', 'time': 'Evening', 'isDone': false},
      ];
      _saveReminders();
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('med_reminders', json.encode(_reminders));
  }

  void _addReminder() {
    final nameController = TextEditingController();
    final medController = TextEditingController();
    final timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Medicine Follow-up'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Patient Name')),
            TextField(controller: medController, decoration: const InputDecoration(labelText: 'Medicine')),
            TextField(controller: timeController, decoration: const InputDecoration(labelText: 'Schedule (e.g. Morning)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _reminders.add({
                    'patient': nameController.text,
                    'medicine': medController.text,
                    'dosage': 'As prescribed',
                    'time': timeController.text,
                    'isDone': false
                  });
                });
                _saveReminders();
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Trackers')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _reminders.isEmpty
                      ? const Center(child: Text('No medicine follow-ups scheduled.'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _reminders.length,
                          itemBuilder: (context, index) {
                            final item = _reminders[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: item['isDone'] ? AppColors.normalGreen.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(Icons.medication_rounded, color: item['isDone'] ? AppColors.normalGreen : Colors.orange),
                                ),
                                title: Text(
                                  item['patient'],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                                ),
                                subtitle: Text(
                                  '${item['medicine']} (${item['time']})',
                                  style: const TextStyle(fontSize: 13, fontFamily: 'Poppins'),
                                ),
                                trailing: Checkbox(
                                  value: item['isDone'],
                                  activeColor: AppColors.normalGreen,
                                  onChanged: (val) {
                                    setState(() {
                                      _reminders[index]['isDone'] = val;
                                    });
                                    _saveReminders();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addReminder,
        label: const Text('New Tracker'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
