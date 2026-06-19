import 'package:flutter/material.dart';
import 'models/models.dart';
import './widgets/settingpage.dart';
import './widgets/dashboard.dart';
import './widgets/employeemanagementpage.dart';
import './widgets/positionmanagementpage.dart';
import './widgets/assignpositonpage.dart';

void main() => runApp(QlyNhanSuApp());

class QlyNhanSuApp extends StatefulWidget {
  @override
  _QlyNhanSuAppState createState() => _QlyNhanSuAppState();
}

class _QlyNhanSuAppState extends State<QlyNhanSuApp> {
  bool _isDarkMode = false;
  Color _primaryColor = Colors.blue;
  double _fontSizeScale = 1.0;

  List<Position> positions = [
    Position(id: "GD", name: "Giam Doc", description: "Quản lý toàn diện công ty"),
    Position(id: "TP", name: "Trưởng phòng", description: "Quản lý phòng ban chuyên môn"),
    Position(id: "NV", name: "Nhân viên", description: "Thực hiện công việc chuyên môn"),
  ];

  late List<Employee> employees;
  @override
  void initState() {
    super.initState();
    employees = [
      Employee(id: "NV01", name: "Nguyễn Văn A", birthYear: 1995, gender: "Nam", specialty: "Kỹ sư CNTT", hometown: "Hà Nội", position: positions[2]),
      Employee(id: "NV02", name: "Trần Thị B", birthYear: 1998, gender: "Nữ", specialty: "Cử nhân Kế toán", hometown: "Đà Nẵng", position: positions[1]),
    ];
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _changePrimaryColor(Color color) {
    setState(() {
      _primaryColor = color;
    });
  }

  void _changeFontSizeScale(double scale) {
    setState(() {
      _fontSizeScale = scale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HR Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryColor,
          brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(_fontSizeScale),
          ),
          child: child!,
        );
      },
      home: MainNavigationScreen(
        employees: employees,
        positions: positions,
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme,
        selectedColor: _primaryColor,
        onColorChanged: _changePrimaryColor,
        fontSizeScale: _fontSizeScale,
        onFontSizeChanged: _changeFontSizeScale,
      ),
    );
  }
}

// Bộ khung điều hướng chính tích hợp BottomNavigationBar
class MainNavigationScreen extends StatefulWidget {
  final List<Employee> employees;
  final List<Position> positions;
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;
  final double fontSizeScale;
  final ValueChanged<double> onFontSizeChanged;

  MainNavigationScreen({
    required this.employees,
    required this.positions,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.selectedColor,
    required this.onColorChanged,
    required this.fontSizeScale,
    required this.onFontSizeChanged,
  });

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Danh sách 5 trang chính của ứng dụng
    final List<Widget> _pages = [
      DashboardPage(employees: widget.employees, positions: widget.positions),
      EmployeeManagementPage(employees: widget.employees),
      PositionManagementPage(positions: widget.positions, employees: widget.employees),
      AssignPositionPage(employees: widget.employees, positions: widget.positions),
      SettingsPage(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.onThemeChanged,
        selectedColor: widget.selectedColor,
        onColorChanged: widget.onColorChanged,
        fontSizeScale: widget.fontSizeScale,
        onFontSizeChanged: widget.onFontSizeChanged,
      ),
    ];

    final List<String> _titles = [
      "Tổng quan hệ thống",
      "Quản lý Nhân viên",
      "Quản lý Chức vụ",
      "Gán Chức vụ",
      "Cài đặt hệ thống"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Nhân viên'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Chức vụ'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_ind), label: 'Gán chức vụ'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
    );
  }
}