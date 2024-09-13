import 'package:exchange_app/src/extentions/mediaquery.dart';
import 'package:flutter/material.dart';

extension StringToDateTime on String {
  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }

  DateTime? toCustomDateTime() {
    try {
      final parts = split(' ');
      if (parts.length < 2) return null;

      final dateParts = parts[0].split('/');
      if (dateParts.length != 3) return null;

      final timeParts = parts[1].split(':');
      if (timeParts.length != 3) return null;

      int month = int.parse(dateParts[0]);
      int day = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);

      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      int second = int.parse(timeParts[2].substring(0, 2));

      if (parts[2] == 'PM' && hour != 12) hour += 12;
      if (parts[2] == 'AM' && hour == 12) hour = 0;

      return DateTime(year, month, day, hour, minute, second);
    } catch (e) {
      return null; 
    }
  }
}

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Responsive App',
          style: TextStyle(fontSize: context.responsiveFontSize(16)), 
        ),
      ),
      body: Center(
        child: Container(
          width: context.isDesktop ? 600 : context.percentWidth(80), 
          height: context.percentHeight(20),  
          color: Colors.blue,
          child: Center(
            child: Text(
              context.isMobile ? 'Mobile View' : context.isTablet ? 'Tablet View' : 'Desktop View',
              style: TextStyle(fontSize: context.responsiveFontSize(18)), 
            ),
          ),
        ),
      ),
    );
  }
}