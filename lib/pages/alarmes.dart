
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class TelaAlarmes extends StatefulWidget {
  const TelaAlarmes({super.key});

  @override
  State<TelaAlarmes> createState() => _TelaAlarmesState();
}

class _TelaAlarmesState extends State<TelaAlarmes> {
  bool loading = false;
  late DateTime selectedDateTime;
  bool loopAudio = true;
  bool vibrate = true;
  String assetAudio = 'assets/marimba.mp3';

  @override
  void initState() {
    super.initState();
    selectedDateTime = DateTime.now().add(const Duration(minutes: 1));
  }

  Future<void> pickTime() async {
    final res = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      context: context,
    );

    if (res != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          res.hour,
          res.minute,
        );
        if (selectedDateTime.isBefore(DateTime.now())) {
          selectedDateTime = selectedDateTime.add(const Duration(days: 1));
        }
      });
    }
  }

  Future<void> saveAlarm() async {
    if (loading) return;
    setState(() => loading = true);
    try {
      final permissionStatus = await Permission.notification.request();
      if (permissionStatus.isGranted) {
        final alarmSettings = AlarmSettings(
          id: DateTime.now().millisecondsSinceEpoch % 10000 + 1,
          dateTime: selectedDateTime,
          loopAudio: loopAudio,
          vibrate: vibrate,
          assetAudioPath: assetAudio,
          notificationSettings: NotificationSettings(
            title: 'Alarme',
            body: 'Seu alarme está tocando!',
            stopButton: 'Parar',
            icon: 'notification_icon',
          ),
        );
        final res = await Alarm.set(alarmSettings: alarmSettings);
        if (res) {
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Alarme salvo com sucesso!')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permissão de notificação negada!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar o alarme: $e')),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Defina o horário do alarme:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          Text(
            "${selectedDateTime.hour}:${selectedDateTime.minute.toString().padLeft(2, '0')}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: pickTime,
            child: const Text('Escolher Hora'),
          ),
          SwitchListTile(
            title: const Text('Repet ir Áudio'),
            value: loopAudio,
            onChanged: (value) => setState(() => loopAudio = value),
          ),
          SwitchListTile(
            title: const Text('Vibrar'),
            value: vibrate,
            onChanged: (value) => setState(() => vibrate = value),
          ),
          ElevatedButton(
            onPressed: saveAlarm,
            child: loading
                ? const CircularProgressIndicator()
                : const Text('Salvar Alarme'),
          ),
        ],
      ),
    );
  }
}
/*import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class TelaAlarmes extends StatefulWidget {
  const TelaAlarmes({super.key});

  @override
  State<TelaAlarmes> createState() => _TelaAlarmesState();
}

class _TelaAlarmesState extends State<TelaAlarmes> {
  bool loading = false;
  late DateTime selectedDateTime;
  bool loopAudio = true;
  bool vibrate = true;
  String assetAudio = 'assets/marimba.mp3';

  @override
  void initState() {
    super.initState();
    selectedDateTime = DateTime.now().add(const Duration(minutes: 1));
  }

  Future<void> pickTime() async {
    final res = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      context: context,
    );

    if (res != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          res.hour,
          res.minute,
        );
        if (selectedDateTime.isBefore(DateTime.now())) {
          selectedDateTime = selectedDateTime.add(const Duration(days: 1));
        }
      });
    }
  }

  Future<void> saveAlarm() async {
    if (loading) return;
    setState(() => loading = true);
    try {
      final permissionStatus = await Permission.notification.request();
      if (permissionStatus.isGranted) {
        final alarmSettings = AlarmSettings(
          id: DateTime.now().millisecondsSinceEpoch % 10000 + 1,
          dateTime: selectedDateTime,
          loopAudio: loopAudio,
          vibrate: vibrate,
          assetAudioPath: assetAudio,
          volumeSettings: VolumeSettings.fixed(volume: 0.5), // Volume fixo
          notificationSettings: NotificationSettings(
            title: 'Alarme',
            body: 'Seu alarme está tocando!',
            stopButton: 'Parar',
            icon: 'notification_icon',
          ),
        );
        final res = await Alarm.set(alarmSettings: alarmSettings);
        if (res) {
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Alarme salvo com sucesso!')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permissão de notificação negada!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar o alarme: $e')),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Defina o horário do alarme:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          Text(
            "${selectedDateTime.hour}:${selectedDateTime.minute.toString().padLeft(2, '0')}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: pickTime,
            child: const Text('Escolher Hora'),
          ),
          SwitchListTile(
            title: const Text('Repetir Áudio'),
            value: loopAudio,
            onChanged: (value) => setState(() => loopAudio = value),
          ),
          SwitchListTile(
            title: const Text('Vibrar'),
            value: vibrate,
            onChanged: (value) => setState(() => vibrate = value),
          ),
          ElevatedButton(
            onPressed: saveAlarm,
            child: loading
                ? const CircularProgressIndicator()
                : const Text('Salvar Alarme'),
          ),
        ],
      ),
    );
  }
}*/