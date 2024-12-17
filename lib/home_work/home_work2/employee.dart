
import 'package:hive/hive.dart';
part 'employee.g.dart';

@HiveType(typeId: 2)
class Workers{
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String surname;

  @HiveField(2)
  final int experience;

  @HiveField(3)
  final double salary;

  Workers({required this.name, required this.surname, required this.experience, required this.salary});
}