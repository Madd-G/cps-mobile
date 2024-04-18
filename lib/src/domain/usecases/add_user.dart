import 'package:cps_mobile/core/use_cases/use_cases.dart';
import 'package:cps_mobile/core/utils/utils.dart';
import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/domain/entities/user_entity.dart';
import 'package:cps_mobile/src/domain/repositories/user_repository.dart';

class AddUser extends FutureUseCaseWithParams<List<UserEntity>, AddUserParams> {
  const AddUser(this._repo);

  final UserRepository _repo;

  @override
  ResultFuture<List<UserEntity>> call(AddUserParams params) => _repo.addUser(
        employee: params.user,
      );
}

class AddUserParams {
  const AddUserParams({required this.user});

  const AddUserParams.empty() : this(user: const UserModel.empty());

  final UserModel user;
}
