part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  final String name;
  final String surname;
  final String username;
  final String city;
  final int screenIndex;
  final OperationStatus status;
  //final String birthDate;

  const OnboardingState({
    required this.name,
    required this.surname,
    required this.city,
    required this.username,
    required this.screenIndex,
    required this.status,
  });

  const OnboardingState.initial()
      : name = '',
        surname = '',
        username = '',
        city = '',
        screenIndex = 0,
        status = OperationStatus.initial;

  OnboardingState copyWith({
    String? name,
    String? surname,
    String? username,
    String? city,
    int? screenIndex,
    OperationStatus? status,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      city: city ?? this.city,
      username: username ?? this.username,
      screenIndex: screenIndex ?? this.screenIndex,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [name, surname, username, city, screenIndex, status];
}
