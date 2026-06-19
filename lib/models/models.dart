
class Position {
  String id;
  String name;
  String description;

  Position({required this.id, required this.name, required this.description});
}

class Employee {
  String id;
  String name;
  int birthYear;
  String gender;
  String specialty;
  String hometown;
  Position? position;

  Employee({
    required this.id,
    required this.name,
    required this.birthYear,
    required this.gender,
    required this.specialty,
    required this.hometown,
    this.position,
  });
}