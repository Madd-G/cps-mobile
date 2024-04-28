import 'package:cps_mobile/core/use_cases/use_cases.dart';
import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUser extends FutureUseCaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repo);

  final UserRepository _repo;

  @override
  ResultFuture<List<UserEntity>> call(UpdateUserParams params) =>
      _repo.updateUser(userId: params.userId, user: params.user);
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.userId, required this.user});

  const UpdateUserParams.empty()
      : this(userId: "", user: const UserModel.empty());

  final String userId;
  final UserModel user;

  @override
  List<Object?> get props => [userId, user];
}
