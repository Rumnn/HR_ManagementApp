import 'package:flutter/material.dart';

import '../models/models.dart';

class EmployeeManagementPage extends StatefulWidget {
  final List<Employee> employees;
  EmployeeManagementPage({required this.employees});

  @override
  _EmployeeManagementPageState createState() => _EmployeeManagementPageState();
}

class _EmployeeManagementPageState extends State<EmployeeManagementPage> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  final _genderController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _hometownController = TextEditingController();

  void _showEmployeeForm({Employee? employee}) {
    if (employee != null) {
      _idController.text = employee.id;
      _nameController.text = employee.name;
      _yearController.text = employee.birthYear.toString();
      _genderController.text = employee.gender;
      _specialtyController.text = employee.specialty;
      _hometownController.text = employee.hometown;
    } else {
      _idController.clear();
      _nameController.clear();
      _yearController.clear();
      _genderController.clear();
      _specialtyController.clear();
      _hometownController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(employee == null ? "Thêm Nhân viên" : "Sửa Nhân viên"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _idController, decoration: InputDecoration(labelText: 'Mã NV'), enabled: employee == null),
              TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Họ tên')),
              TextField(controller: _yearController, decoration: InputDecoration(labelText: 'Năm sinh'), keyboardType: TextInputType.number),
              TextField(controller: _genderController, decoration: InputDecoration(labelText: 'Giới tính')),
              TextField(controller: _specialtyController, decoration: InputDecoration(labelText: 'Chuyên môn')),
              TextField(controller: _hometownController, decoration: InputDecoration(labelText: 'Quê quán')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (employee == null) {
                  // Thêm mới
                  widget.employees.add(Employee(
                    id: _idController.text,
                    name: _nameController.text,
                    birthYear: int.tryParse(_yearController.text) ?? 2000,
                    gender: _genderController.text,
                    specialty: _specialtyController.text,
                    hometown: _hometownController.text,
                  ));
                } else {
                  // Cập nhật thông tin sửa
                  employee.name = _nameController.text;
                  employee.birthYear = int.tryParse(_yearController.text) ?? employee.birthYear;
                  employee.gender = _genderController.text;
                  employee.specialty = _specialtyController.text;
                  employee.hometown = _hometownController.text;
                }
              });
              Navigator.pop(context);
            },
            child: Text('Lưu'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.employees.length,
        itemBuilder: (context, index) {
          final emp = widget.employees[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text("${emp.id} - ${emp.name}"),
              subtitle: Text("Chức vụ: ${emp.position?.name ?? 'Chưa gán'}\nChuyên môn: ${emp.specialty} | Quê: ${emp.hometown}"),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () => _showEmployeeForm(employee: emp)),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        widget.employees.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEmployeeForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}