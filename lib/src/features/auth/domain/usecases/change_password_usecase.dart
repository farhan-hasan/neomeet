import 'package:dartz/dartz.dart';
import 'package:neomeet/src/core/network/responses/failure_response.dart';
import 'package:neomeet/src/core/network/responses/success_response.dart';
import 'package:neomeet/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:neomeet/src/features/auth/domain/repository/auth_repository.dart';
import 'package:neomeet/src/shared/dependency_injection/dependency_injection.dart';
import 'package:neomeet/src/shared/domain/use_cases/base_use_case.dart';

class ChangePasswordUseCase extends UseCase<Either<Failure, Success>, String> {
  final AuthRepository _authRepository = sl.get<AuthRepositoryImpl>();
  @override
  Future<Either<Failure, Success>> call(String params) async {
    return await _authRepository.changePassword(password: params);
  }
}