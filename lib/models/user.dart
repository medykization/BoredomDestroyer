import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(1)
  String name;
  @HiveField(2)
  String accessToken;
  @HiveField(3)
  String refreshToken;

  User({this.name, this.accessToken, this.refreshToken});
}
