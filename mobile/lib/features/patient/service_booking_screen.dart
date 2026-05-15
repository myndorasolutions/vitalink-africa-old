import 'package:flutter/material.dart';

class ServiceBookingScreen extends StatefulWidget {
  const ServiceBookingScreen({super.key});

  @override
  State<ServiceBookingScreen> createState() => _ServiceBookingScreenState();
}

class _ServiceBookingScreenState extends State<ServiceBookingScreen> {
  String _serviceType = 'home_visit';
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _time = const TimeOfDay(hour: 10, minute: 0);

  final _services = [
    ('home_visit', 'Home health visit', '₦8,000'),
    ('bp_check', 'BP check only', '₦2,500'),
    ('lab_pickup', 'Lab sample pickup', '₦5,000'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book a service')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Service type', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ..._services.map((s) {
            return RadioListTile<String>(
              title: Text(s.$2),
              subtitle: Text(s.$3),
              value: s.$1,
              groupValue: _serviceType,
              onChanged: (v) => setState(() => _serviceType = v!),
            );
          }),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Date'),
            subtitle: Text(
              '${_date.year}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')}',
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
                initialDate: _date,
              );
              if (picked != null) setState(() => _date = picked);
            },
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Time'),
            subtitle: Text(_time.format(context)),
            onTap: () async {
              final picked = await showTimePicker(context: context, initialTime: _time);
              if (picked != null) setState(() => _time = picked);
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking request saved — payment step connects to Paystack'),
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Request booking'),
          ),
        ],
      ),
    );
  }
}
