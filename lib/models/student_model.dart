class StudentModel {
  final String id;
  final String name;
  final String grade;
  final String className;

  const StudentModel({
    required this.id,
    required this.name,
    required this.grade,
    required this.className,
  });

  String get firstName => name.split(' ').first;

  String get gradeLabel => '$grade / $className';
}
