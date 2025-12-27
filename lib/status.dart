import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final List<Map<String, dynamic>> _flights = [
    {
      'airline': 'Flutter Air',
      'flightNumber': 'FA 123',
      'status': 'On Time',
      'statusColor': Colors.green,
      'departureCity': 'SFO',
      'arrivalCity': 'JFK',
      'departureTime': '10:30 AM',
      'arrivalTime': '6:45 PM',
    },
    {
      'airline': 'Dart Express',
      'flightNumber': 'DE 456',
      'status': 'Delayed',
      'statusColor': Colors.orange,
      'departureCity': 'LHR',
      'arrivalCity': 'CDG',
      'departureTime': '1:00 PM',
      'arrivalTime': '3:15 PM',
    },
    {
      'airline': 'Widget Wings',
      'flightNumber': 'WW 789',
      'status': 'Boarding',
      'statusColor': Colors.blue,
      'departureCity': 'HND',
      'arrivalCity': 'SYD',
      'departureTime': '8:00 PM',
      'arrivalTime': '6:30 AM',
    },
    {
      'airline': 'Pixel Perfect',
      'flightNumber': 'PP 101',
      'status': 'Landed',
      'statusColor': Colors.grey,
      'departureCity': 'DXB',
      'arrivalCity': 'SIN',
      'departureTime': '3:20 AM',
      'arrivalTime': '2:40 PM',
    },
  ];

  void _addFlight() {
    setState(() {
      _flights.add({
        'airline': 'New Flight',
        'flightNumber': 'NF 007',
        'status': 'On Time',
        'statusColor': Colors.green,
        'departureCity': 'LAX',
        'arrivalCity': 'ORD',
        'departureTime': '4:00 PM',
        'arrivalTime': '10:00 PM',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('Flight Status'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        titleTextStyle: TextStyle(
          color: Colors.blueGrey[800],
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _flights.length,
        itemBuilder: (context, index) {
          final flight = _flights[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildFlightStatusCard(
              context: context,
              airline: flight['airline'],
              flightNumber: flight['flightNumber'],
              status: flight['status'],
              statusColor: flight['statusColor'],
              departureCity: flight['departureCity'],
              arrivalCity: flight['arrivalCity'],
              departureTime: flight['departureTime'],
              arrivalTime: flight['arrivalTime'],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlight,
        backgroundColor: Colors.blueGrey[800],
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFlightStatusCard({
    required BuildContext context,
    required String airline,
    required String flightNumber,
    required String status,
    required Color statusColor,
    required String departureCity,
    required String arrivalCity,
    required String departureTime,
    required String arrivalTime,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$airline - $flightNumber',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFlightInfo(city: departureCity, time: departureTime),
                const FaIcon(FontAwesomeIcons.plane, color: Colors.blueGrey),
                _buildFlightInfo(
                  city: arrivalCity,
                  time: arrivalTime,
                  isArrival: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightInfo({
    required String city,
    required String time,
    bool isArrival = false,
  }) {
    return Column(
      crossAxisAlignment: isArrival
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          city,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(time, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}
