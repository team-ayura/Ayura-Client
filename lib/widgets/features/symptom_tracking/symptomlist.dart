import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SymptomList extends StatelessWidget {
  final DateTime selectedDay;

  SymptomList({required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    List<SymptomEntry> symptomEntries = symptomData[selectedDay] ?? [];

    // Check if symptomEntries is empty
    if (symptomEntries.isEmpty) {
      return Center(
        child: Text("No symptoms recorded for ${DateFormat('MMM dd, yyyy').format(selectedDay)}"),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            DateFormat('MMM dd, yyyy').format(selectedDay),
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: symptomEntries.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: _getBackgroundColor(symptomEntries[index].severity),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(symptomEntries[index].symptom),
            );
          },
        ),
      ],
    );
  }

  Color _getBackgroundColor(SymptomSeverity severity) {
    if (severity == SymptomSeverity.unbearable) {
      return Colors.red;
    } else if (severity == SymptomSeverity.moderate) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}

enum SymptomSeverity {
  light,
  moderate,
  unbearable,
}

class SymptomEntry {
  final String symptom;
  final SymptomSeverity severity;

  SymptomEntry(this.symptom, this.severity);
}

Map<DateTime, List<SymptomEntry>> symptomData = {
  DateTime(2023, 8, 3): [
    SymptomEntry('Headache', SymptomSeverity.light),
    SymptomEntry('Fatigue', SymptomSeverity.moderate),
    SymptomEntry('Nausea', SymptomSeverity.unbearable),
  ],
  DateTime(2023, 8, 5): [
    SymptomEntry('Dizziness', SymptomSeverity.light),
    SymptomEntry('Abdominal Pain', SymptomSeverity.moderate),
  ],
};