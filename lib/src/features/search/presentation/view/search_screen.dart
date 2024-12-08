import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neomeet/src/core/styles/theme/app_theme.dart';
import 'package:neomeet/src/core/utils/extension/context_extension.dart';
import 'package:neomeet/src/shared/widgets/shared_appbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const route = '/search_screen';

  static setRoute() => '/search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _selectedTime;
  TextEditingController _hostnameController = TextEditingController();
  List<String> searchResult = ["aa"];

  // Format the DateTime as required (e.g., "MM/dd/yyyy")
  String get formattedDateRange {
    if (_startDate == null || _endDate == null) return "Select Date Range";
    return "${DateFormat('MM/dd/yyyy').format(_startDate!)} - ${DateFormat('MM/dd/yyyy').format(_endDate!)}";
  }

  // Time picker for selecting time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _showCustomTimePicker(BuildContext context) async {
    TimeOfDay? picked = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Time', style: TextStyle(fontSize: 20)),
          content: SizedBox(
            width: double.maxFinite,
            child: TimePickerDialog(
              initialTime: _selectedTime ?? TimeOfDay.now(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, null); // Cancel
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _selectedTime);
              },
              child: Text('Select'),
            ),
          ],
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Date range picker
  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: _startDate ?? DateTime.now(),
        end: _endDate ?? DateTime.now().add(Duration(days: 7)),
      ),
    );
    if (picked != null &&
        picked.start != _startDate &&
        picked.end != _endDate) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  // Submit search
  void _submitSearch() {
    String startDate = _startDate != null
        ? DateFormat('MM/dd/yyyy').format(_startDate!)
        : 'Not selected';
    String endDate = _endDate != null
        ? DateFormat('MM/dd/yyyy').format(_endDate!)
        : 'Not selected';
    String time =
        _selectedTime != null ? _selectedTime!.format(context) : 'Not selected';
    String hostname = _hostnameController.text.isNotEmpty
        ? _hostnameController.text
        : 'No hostname entered';

    // You can replace the print with actual search functionality
    print('Search Parameters:');
    print('Start Date: $startDate');
    print('End Date: $endDate');
    print('Time: $time');
    print('Hostname: $hostname');
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: SharedAppbar(
        title: Text("Search"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Range
                  Text("Select Date Range",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.start),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => _selectDateRange(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: formattedDateRange,
                          suffixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Time
                  Text("Select Time",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.start),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: _selectedTime != null
                              ? _selectedTime!.format(context)
                              : "Select Time",
                          suffixIcon: Icon(Icons.access_time),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Hostname Input Field
                  Text(
                    "Enter Hostname",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _hostnameController,
                    decoration: InputDecoration(
                      hintText: "Enter hostname",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Search Button
                  SizedBox(
                    width: context.width,
                    child: ElevatedButton(
                      onPressed: _submitSearch,
                      child: Text("Search"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              searchResult.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: lightTheme.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.only(top: 20),
                          child: ListTile(
                            title: Text("Name - $index"),
                            subtitle: Text(""),
                          ),
                        );
                      })
                  : Center(child: Text("No Data Found"))
            ],
          ),
        ),
      ),
    );
  }
}
