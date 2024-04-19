import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/domain/entities/users_entity.dart';
import 'package:equatable/equatable.dart';

class UserResponse extends Equatable {
  final List<UserModel>? users;

  const UserResponse({this.users});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        users: json["users"] == null
            ? null
            : List<UserModel>.from(
                json["users"].map((x) => UserModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? null
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };

  UsersEntity toEntity() {
    return UsersEntity(
      users: users?.map((x) => x.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        users,
      ];
}
