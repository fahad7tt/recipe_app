import 'package:hive/hive.dart';
part 'hive_adapter.g.dart';

@HiveType(typeId: 0)
class SignupDetails extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  String role; // "admin" or "user"

  SignupDetails({
    required this.username,
    required this.email,
    required this.password,
    this.role = "user",
  });
}
