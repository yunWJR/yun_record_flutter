import "cacheConfig.dart";
import "user.dart";

part 'profile.g.dart';

class Profile {
  Profile();

  User user;
  String token;
  num theme;
  CacheConfig cache;
  String lastLogin;
  String locale;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
