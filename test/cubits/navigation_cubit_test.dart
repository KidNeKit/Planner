import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planner/cubits/navigation_cubit.dart';

void main() {
  group(
    'Testing app navigation',
    () {
      late NavigationCubit navigationCubit;
      setUp(() {
        navigationCubit = NavigationCubit();
      });

      test('Initial test', () {
        expect(navigationCubit.state.index, 0);
      });

      blocTest<NavigationCubit, NavigationState>(
        'Set 3rd screen',
        build: () => NavigationCubit(),
        act: (cubit) => cubit.changeScreenIndex(3),
        expect: () => const <NavigationState>[NavigationState(index: 3)],
      );
    },
  );
}
