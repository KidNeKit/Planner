import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/colors.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../login_screen/login_screen.dart';
import '../settings_screens/personal_data_screen/personal_data_screen.dart';
import 'settings_button.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        SettingsButton(
          text: 'Personal Data',
          onPressedFunc: () =>
              Navigator.of(context).pushNamed(PersonalDataScreen.routeName),
        ),
        const SizedBox(height: 10.0),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.user == null) {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            }
          },
          child: SettingsButton(
            text: 'Log Out',
            color: neonRed,
            onPressedFunc: () =>
                context.read<AuthBloc>().add(LogoutRequested()),
          ),
        ),
      ],
    );
  }
}
