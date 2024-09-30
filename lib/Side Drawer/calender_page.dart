import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _changesMade = false;

  // Track the working status and job details
  final Map<DateTime, bool> _workingStatus = {};
  final Map<DateTime, int> _jobsCommitted = {};
  final Map<DateTime, int> _hoursWorking = {};

  // List of working days (e.g., Monday to Friday)
  List<bool> _weekDaysWorking = List.filled(7, false);
  int _usualJobsCommitted = 0;
  int _usualHoursWorking = 0;

  // Initialize the working days for the entire calendar
  void _initializeWorkingDays() {
    DateTime startDate = DateTime.now().subtract(Duration(days: 365));
    DateTime endDate = DateTime.now().add(Duration(days: 365));
    for (DateTime day = startDate;
    day.isBefore(endDate);
    day = day.add(Duration(days: 1))) {
      int weekDay = day.weekday - 1; // Monday is 0, Sunday is 6
      if (_weekDaysWorking[weekDay]) {
        _workingStatus[day] = true;
        _jobsCommitted[day] = _usualJobsCommitted;
        _hoursWorking[day] = _usualHoursWorking;
      } else {
        _workingStatus[day] = false;
      }
    }
  }

  // Toggle working status for a day
  void _toggleWorkingStatus(DateTime day) {
    setState(() {
      _workingStatus[day] = !(_workingStatus[day] ?? false);
      _changesMade = true; // Mark that changes were made
      if (!_workingStatus[day]!) {
        // Clear job and hours details if marked as not working
        _jobsCommitted.remove(day);
        _hoursWorking.remove(day);
      } else {
        _jobsCommitted[day] = _usualJobsCommitted;
        _hoursWorking[day] = _usualHoursWorking;
      }
    });
  }

  // Save the changes and update the calendar
  void _saveChanges() {
    setState(() {
      // Apply the usual working days, jobs, and hours to the whole calendar
      _initializeWorkingDays();
      _changesMade = false; // Reset the changes made flag
    });
    // Perform any necessary save operations here, such as sending data to a backend
  }

  @override
  void initState() {
    super.initState();
    _initializeWorkingDays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Calendar'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Your Usual Working Days:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ToggleButtons(
                    children: [
                      Text('Mon'),
                      Text('Tue'),
                      Text('Wed'),
                      Text('Thu'),
                      Text('Fri'),
                      Text('Sat'),
                      Text('Sun'),
                    ],
                    isSelected: _weekDaysWorking,
                    onPressed: (int index) {
                      setState(() {
                        _weekDaysWorking[index] = !_weekDaysWorking[index];
                        _changesMade = true; // Mark that changes were made
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    title: Text('Usual Jobs Committed'),
                    subtitle: Text('$_usualJobsCommitted jobs committed'),
                    trailing: DropdownButton<int>(
                      value: _usualJobsCommitted,
                      items: List.generate(
                        10,
                            (index) => DropdownMenuItem(
                          value: index,
                          child: Text('$index'),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _usualJobsCommitted = value!;
                          _changesMade = true; // Mark that changes were made
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Usual Hours Working'),
                    subtitle: Text('$_usualHoursWorking hours working'),
                    trailing: DropdownButton<int>(
                      value: _usualHoursWorking,
                      items: List.generate(
                        12,
                            (index) => DropdownMenuItem(
                          value: index,
                          child: Text('$index'),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _usualHoursWorking = value!;
                          _changesMade = true; // Mark that changes were made
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                ),
                eventLoader: (day) {
                  // Return a list with one element for working days, which shows the green dot
                  if (_workingStatus[day] == true) {
                    return [day];
                  }
                  return [];
                },
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),
            if (_selectedDay != null)
              Column(
                children: [
                  ListTile(
                    title: Text(_workingStatus[_selectedDay] == true
                        ? 'Marked as working'
                        : _workingStatus[_selectedDay] == false
                        ? 'Marked as not working'
                        : 'Not marked'),
                    trailing: IconButton(
                      icon: Icon(
                        _workingStatus[_selectedDay] == true
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        color: _workingStatus[_selectedDay] == true
                            ? Colors.green
                            : _workingStatus[_selectedDay] == false
                            ? Colors.red
                            : Colors.grey,
                      ),
                      onPressed: () {
                        _toggleWorkingStatus(_selectedDay!);
                      },
                    ),
                  ),
                  if (_workingStatus[_selectedDay] == true) ...[
                    ListTile(
                      title: Text('Jobs committed'),
                      subtitle: Text(
                          '${_jobsCommitted[_selectedDay] ?? 0} jobs committed'),
                      trailing: DropdownButton<int>(
                        value: _jobsCommitted[_selectedDay],
                        items: List.generate(
                          10,
                              (index) => DropdownMenuItem(
                            value: index,
                            child: Text('$index'),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _jobsCommitted[_selectedDay!] = value!;
                            _changesMade = true; // Mark that changes were made
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Hours working'),
                      subtitle: Text(
                          '${_hoursWorking[_selectedDay] ?? 0} hours working'),
                      trailing: DropdownButton<int>(
                        value: _hoursWorking[_selectedDay],
                        items: List.generate(
                          12,
                              (index) => DropdownMenuItem(
                            value: index,
                            child: Text('$index'),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _hoursWorking[_selectedDay!] = value!;
                            _changesMade = true; // Mark that changes were made
                          });
                        },
                      ),
                    ),
                  ]
                ],
              ),
            if (_changesMade)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  child: Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
