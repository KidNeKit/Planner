part of 'registration_cubit.dart';

class RegistrationState extends Equatable {
  final String email;
  final String password;
  final String secondPassword;
  final OperationStatus status;
  const RegistrationState(
      {required this.email,
      required this.password,
      required this.secondPassword,
      required this.status});

  const RegistrationState.initial()
      : email = '',
        password = '',
        secondPassword = '',
        status = OperationStatus.initial;

  RegistrationState copyWith(
      {String? email,
      String? password,
      String? secondPassword,
      String? username,
      OperationStatus? status}) {
    return RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        secondPassword: secondPassword ?? this.secondPassword,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [email, password, secondPassword, status];
}
