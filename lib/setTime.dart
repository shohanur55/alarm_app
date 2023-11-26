import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SetTime extends StatefulWidget {
  const SetTime({super.key});

  @override
  State<SetTime> createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> {

  @override
  Widget build (BuildContext context) {
    return
      ElevatedButton(
        onPressed: () async {
          TimeOfDay? selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.inputOnly,
          );

          if (selectedTime != null) {
            // Calculate the duration until the selected time
            DateTime now = DateTime.now();
            DateTime scheduledTime = DateTime(
              now.year,
              now.month,
              now.day,
              selectedTime.hour,
              selectedTime.minute,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                Text('Alarm set for ${selectedTime.format(context)}'),
                //content: Text('Alarm set for ${durationUntilScheduled.inHours}'),
              ),
            );


            // Calculate the duration until the scheduled time
            Duration durationUntilScheduled = scheduledTime.difference(now);
            print(durationUntilScheduled.toString());

            // Set up the alarm
            await AndroidAlarmManager.periodic(durationUntilScheduled, 0,
              speakCurrentTime,
            );

            // Display a confirmation message

          }
        },
        child: Text('Set Alarm'),
      );




  }
}
