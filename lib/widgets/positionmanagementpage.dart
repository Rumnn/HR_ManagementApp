import 'package:flutter/material.dart';
import '../models/models.dart';

class PositionManagementPage extends StatefulWidget {
  final List<Position> positions;
  final List<Employee> employees;
  PositionManagementPage({required this.positions, required this.employees});

  @override
  _PositionManagementPageState createState() => _PositionManagementPageState();
}

class _PositionManagementPageState extends State<PositionManagementPage> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  void _showPositionForm({Position? position}) {
    if (position != null) {
      _idController.text = position.id;
      _nameController.text = position.name;
      _descController.text = position.description;
    } else {
      _idController.clear();
      _nameController.clear();
      _descController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(position == null ? "Thêm Chức vụ" : "Sửa Chức vụ"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _idController, decoration: InputDecoration(labelText: 'Mã chức vụ'), enabled: position == null),
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Tên chức vụ')),
            TextField(controller: _descController, decoration: InputDecoration(labelText: 'Mô tả')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (position == null) {
                  widget.positions.add(Position(
                    id: _idController.text,
                    name: _nameController.text,
                    description: _descController.text,
                  ));
                } else {
                  position.name = _nameController.text;
                  position.description = _descController.text;
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
        itemCount: widget.positions.length,
        itemBuilder: (context, index) {
          final pos = widget.positions[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text("${pos.id} - ${pos.name}"),
              subtitle: Text(pos.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () => _showPositionForm(position: pos)),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        // Nghiệp vụ bảo vệ: Hủy gán chức vụ này ở các nhân viên trước khi xóa danh mục
                        for (var emp in widget.employees) {
                          if (emp.position?.id == pos.id) {
                            emp.position = null;
                          }
                        }
                        widget.positions.removeAt(index);
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
        onPressed: () => _showPositionForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}