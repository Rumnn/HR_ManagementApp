import 'package:flutter/material.dart';
import '../models/models.dart';

class AssignPositionPage extends StatefulWidget {
  final List<Employee> employees;
  final List<Position> positions;

  AssignPositionPage({required this.employees, required this.positions});

  @override
  _AssignPositionPageState createState() => _AssignPositionPageState();
}

class _AssignPositionPageState extends State<AssignPositionPage> {
  Employee? selectedEmployee;
  Position? selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Chọn nhân viên cần gán nhiệm vụ:", style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<Employee>(
            isExpanded: true,
            hint: Text("Chọn nhân viên"),
            value: selectedEmployee,
            items: widget.employees.map((emp) {
              return DropdownMenuItem<Employee>(
                value: emp,
                child: Text("${emp.id} - ${emp.name} (${emp.position?.name ?? 'Chưa có chức vụ'})"),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedEmployee = value;
                selectedPosition = value?.position; // Hiển thị chức vụ hiện tại nếu có
              });
            },
          ),
          SizedBox(height: 24),
          Text("Chọn chức vụ mới muốn gán:", style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<Position>(
            isExpanded: true,
            hint: Text("Chọn chức vụ"),
            value: selectedPosition,
            items: widget.positions.map((pos) {
              return DropdownMenuItem<Position>(
                value: pos,
                child: Text("${pos.id} - ${pos.name}"),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedPosition = value;
              });
            },
          ),
          SizedBox(height: 30),
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.check_circle),
              label: Text("Xác nhận gán chức vụ"),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
              onPressed: (selectedEmployee != null && selectedPosition != null)
                  ? () {
                setState(() {
                  selectedEmployee!.position = selectedPosition;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Đã gán chức vụ ${selectedPosition!.name} cho ${selectedEmployee!.name} thành công!")),
                );
              }
                  : null, // Vô hiệu hóa nút nếu chưa chọn đủ dữ liệu
            ),
          )
        ],
      ),
    );
  }
}