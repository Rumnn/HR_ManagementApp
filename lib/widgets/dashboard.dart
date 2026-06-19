import 'package:flutter/material.dart';
import '../models/models.dart';

class DashboardPage extends StatelessWidget {
  final List<Employee> employees;
  final List<Position> positions;

  DashboardPage({required this.employees, required this.positions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Chào mừng đến với hệ thống HR", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Nhân viên", "${employees.length}", Colors.blue, Icons.person),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard("Chức vụ hiện có", "${positions.length}", Colors.orange, Icons.workspace_premium),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color, IconData icon) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border(left: BorderSide(color: color, width: 6))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
            Text(count, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}